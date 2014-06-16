From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 1/9] of: Add NVIDIA Tegra SATA controller binding
Date: Mon, 16 Jun 2014 15:55:14 -0600
Message-ID: <539F67C2.9080303@wwwdotorg.org>
References: <1401881559-18469-1-git-send-email-mperttunen@nvidia.com> <1401881559-18469-2-git-send-email-mperttunen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1401881559-18469-2-git-send-email-mperttunen@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mikko Perttunen <mperttunen@nvidia.com>, thierry.reding@gmail.com, tj@kernel.org, pdeschrijver@nvidia.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 06/04/2014 05:32 AM, Mikko Perttunen wrote:
> This patch adds device tree binding documentation for the SATA
> controller found on NVIDIA Tegra SoCs.

Just one nit below:

> diff --git a/Documentation/devicetree/bindings/ata/tegra-sata.txt b/Documentation/devicetree/bindings/ata/tegra-sata.txt

> + - clocks : Defines the clocks listed in the clock-names property.
> + - clock-names : The following clock names must be present:
> +   - sata
...

It would be nice if the binding could use the exact same wording as all
the other Tegra bindings, i.e.:

==========
- clocks : Must contain an entry for each entry in clock-names.
  See ../clocks/clock-bindings.txt for details.
- clock-names : Must include the following entries:
  - pll_a
  - pll_a_out0
  - mclk (The Tegra cdev1/extern1 clock, which feeds the CODEC's mclk)
==========

Same for the resets property.
