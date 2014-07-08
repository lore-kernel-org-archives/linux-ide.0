From: Peter De Schrijver <pdeschrijver@nvidia.com>
Subject: Re: [PATCH] clk: tegra: Use XUSB-compatible SATA PLL sequence
Date: Tue, 8 Jul 2014 11:16:47 +0300
Message-ID: <20140708081647.GV3679@tbergstrom-lnx.Nvidia.com>
References: <CAL1qeaHo_HEoXoCQjQuqux_BNPtz4BtOnrYTa4=vcNQCYxiDSg@mail.gmail.com>
 <1404804615-23587-1-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1404804615-23587-1-git-send-email-mperttunen@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: "abrestic@chromium.org" <abrestic@chromium.org>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "tj@kernel.org" <tj@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Tue, Jul 08, 2014 at 09:30:15AM +0200, Mikko Perttunen wrote:
> Use a sequence for enabling hardware control of the SATA PLL
> that works both when using the SATA lane with SATA and when
> using it with XUSB.
> 

I'm going to take it as a separate patch on top of what's there now.

Cheers,

Peter.
