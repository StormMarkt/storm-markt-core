const path = require("path");

const buildNextEslintCommand = (filenames) =>
  `pnpm run --filter=next:lint -- --fix --file ${filenames
    .map((f) => path.relative(path.join("packages", "nextjs"), f))
    .join(" --file ")}`;

const checkTypesNextCommand = () => "pnpm run --filter=next:check-types";

const buildHardhatEslintCommand = (filenames) =>
  `pnpm run --filter=hardhat:lint-staged -- --fix ${filenames
    .map((f) => path.relative(path.join("packages", "hardhat"), f))
    .join(" ")}`;

module.exports = {
  "packages/nextjs/**/*.{ts,tsx}": [
    buildNextEslintCommand,
    checkTypesNextCommand,
  ],
  "packages/hardhat/**/*.{ts,tsx}": [buildHardhatEslintCommand],
};
