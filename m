From: Rob Herring <robh@kernel.org>
Subject: Re: [v6 1/3] dt-bindings: ahci-fsl-qoriq: add lx2160a chip name to
 the list
Date: Fri, 22 Feb 2019 08:39:31 -0600
Message-ID: <20190222143931.GA17132@bogus>
References: <20190220085607.31582-1-peng.ma@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190220085607.31582-1-peng.ma@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: axboe@kernel.dk, robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org, leoyang.li@nxp.com, andy.tang@nxp.com, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, yousaf.kaukab@suse.com, Peng Ma <peng.ma@nxp.com>
List-Id: linux-ide@vger.kernel.org

On Wed, 20 Feb 2019 08:56:05 +0000, Peng Ma wrote:
> Add lx2160a compatible to bindings documentation.
> 
> Signed-off-by: Peng Ma <peng.ma@nxp.com>
> ---
> changed for V6:
> 	- no changed 
> 
>  .../devicetree/bindings/ata/ahci-fsl-qoriq.txt     |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
