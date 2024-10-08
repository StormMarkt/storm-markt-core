# ⛈️ Storm Markt - Weather Prediction Market


## 🏗 We used Scaffold-ETH 2 to get started

<h4>
  <a href="https://docs.scaffoldeth.io">Documentation</a> |
  <a href="https://scaffoldeth.io">Website</a>
</h4>

## Requirements

Before you begin, you need to install the following tools:

- [Node (>= v18.17)](https://nodejs.org/en/download/)
- [Pnpm](https://pnpm.io/)
- [Git](https://git-scm.com/downloads)

## Quickstart

To get started follow the steps below:

1. Clone this repo & install dependencies

```
pnpm install
```

2. Run a local network in the first terminal:

```
pnpm chain
```

This command starts a local Ethereum network using Hardhat. The network runs on your local machine and can be used for testing and development. You can customize the network configuration in `hardhat.config.ts`.

3. On a second terminal, deploy the test contract:

```
pnpm run deploy
```

This command deploys a test smart contract to the local network. The contract is located in `packages/hardhat/contracts` and can be modified to suit your needs. The `pnpm deploy` command uses the deploy script located in `packages/hardhat/deploy` to deploy the contract to the network. You can also customize the deploy script.

4. On a third terminal, start your NextJS app:

```
pnpm start
```

Visit your app on: `http://localhost:3000`. You can interact with your smart contract using the `Debug Contracts` page. You can tweak the app config in `packages/nextjs/scaffold.config.ts`.

**What's next**:

- Edit your smart contract in `packages/hardhat/contracts`
- Edit your frontend homepage at `packages/nextjs/app/page.tsx`. For guidance on [routing](https://nextjs.org/docs/app/building-your-application/routing/defining-routes) and configuring [pages/layouts](https://nextjs.org/docs/app/building-your-application/routing/pages-and-layouts) checkout the Next.js documentation.
- Edit your deployment scripts in `packages/hardhat/deploy`
- Edit your smart contract test in: `packages/hardhat/test`. To run test use `pnpm hardhat:test`

## Documentation

Visit our [docs](https://docs.scaffoldeth.io) to learn how to start building with Scaffold-ETH 2.

To know more about its features, check out our [website](https://scaffoldeth.io).

### Resources

- [envio-cli](https://docs.envio.dev/docs/HyperIndex/cli-commands)
- [KintoID](https://docs.kinto.xyz/kinto-the-safe-l2/building-on-kinto/smart-contract-reference/kintoid)
- [Prediction Markets: Bottlenecks and the Next Major Unlocks](https://mirror.xyz/1kx.eth/jnQhA56Kx9p3RODKiGzqzHGGEODpbskivUUNdd7hwh0)
- [AuthaGraph projection](https://en.m.wikipedia.org/wiki/AuthaGraph_projection)
- [The SackRace](https://www.bettingodds.com/thesackrace)
- [Betting On The Weather With Bookmakers](https://www.olbg.com/blogs/betting-weather-bookmakers)
- [Weather Betting Sites](https://www.onlinebettingsites.com/novelty/weather/)
- [Can You Get Rich Betting on the Weather?](https://www.mentalfloss.com/article/28636/can-you-get-rich-betting-weather)
- [Enter Weather 3.0](https://weatherxm.com/)
