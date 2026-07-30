import React, { useEffect } from 'react';
import { useLocation } from '@docusaurus/router';
import useDocusaurusContext from '@docusaurus/useDocusaurusContext';
import posthog from 'posthog-js';

let initialized = false;

export default function Root({ children }: { children: React.ReactNode }) {
  const { siteConfig } = useDocusaurusContext();
  const location = useLocation();
  const posthogApiKey = typeof siteConfig.customFields?.posthogPublicApiKey === 'string'
    ? siteConfig.customFields.posthogPublicApiKey
    : '';
  const posthogApiHost = typeof siteConfig.customFields?.posthogApiUrl === 'string'
    ? siteConfig.customFields.posthogApiUrl
    : 'https://eu.i.posthog.com';

  useEffect(() => {
    if (!posthogApiKey || initialized) return;

    posthog.init(posthogApiKey, {
      api_host: posthogApiHost,
      capture_pageview: false,
      capture_pageleave: true,
      person_profiles: 'identified_only',
    });

    initialized = true;
  }, [posthogApiHost, posthogApiKey]);

  useEffect(() => {
    if (!initialized) return;

    posthog.capture('$pageview', {
      $current_url: typeof window !== 'undefined' ? window.location.href : location.pathname,
      path: `${location.pathname}${location.search}`,
    });
  }, [location.pathname, location.search]);

  return <>{children}</>;
}
