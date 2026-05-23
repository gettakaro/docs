import React from 'react';

interface GameHeroProps {
  title: string;
  description: string;
  image: string;
  imageAlt?: string;
}

export default function GameHero({
  title,
  description,
  image,
  imageAlt,
}: GameHeroProps) {
  return (
    <header className="game-hero">
      <img className="game-hero__image" src={image} alt={imageAlt ?? title} />
      <div className="game-hero__content">
        <h1>{title}</h1>
        <p>{description}</p>
      </div>
    </header>
  );
}
