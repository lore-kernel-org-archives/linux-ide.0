From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: ahci-fsl-qoriq: add ls1028a chip name
 to the list
Date: Wed, 27 Mar 2019 19:25:56 -0500
Message-ID: <20190328002556.GA15649@bogus>
References: <20190311072014.36565-1-peng.ma@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190311072014.36565-1-peng.ma@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: axboe@kernel.dk, robh+dt@kernel.org, shawnguo@kernel.org, mark.rutland@arm.com, leoyang.li@nxp.com, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, andy.tang@nxp.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peng Ma <peng.ma@nxp.com>
List-Id: linux-ide@vger.kernel.org

On Mon, 11 Mar 2019 15:20:12 +0800, Peng Ma wrote:
> Add ls1028a compatible to bindings documentation.
> 
> Signed-off-by: Peng Ma <peng.ma@nxp.com>
> ---
> depends on:
> 	- http://patchwork.ozlabs.org/patch/1045217/
> 
>  .../devicetree/bindings/ata/ahci-fsl-qoriq.txt     |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
