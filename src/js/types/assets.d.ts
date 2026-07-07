// Non-code imports handled by webpack loaders, so TypeScript treats them as
// side-effect modules rather than erroring on a missing declaration.
declare module '*.scss';
declare module '*.css';
