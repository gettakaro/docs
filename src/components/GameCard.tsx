import React from 'react';
import Link from '@docusaurus/Link';

interface GameCardProps {
  title: string;
  description: string;
  image: string;
  link: string;
}

export default function GameCard({ title, description, image, link }: GameCardProps) {
  return (
    <Link to={link} className="game-card">
      <div className="game-card__image">
        <img src={image} alt={title} />
      </div>
      <div className="game-card__content">
        <h3>{title}</h3>
        <p>{description}</p>
      </div>
    </Link>
  );
}

export function GameCardGrid({ children }: { children: React.ReactNode }) {
  return <div className="game-card-grid">{children}</div>;
}
