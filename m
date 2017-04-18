From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH/RFT] sata: rcar_sata: Reset SATA PHY on resume
Date: Tue, 18 Apr 2017 16:17:38 +0900
Message-ID: <20170418071738.GD3899@wtj.duckdns.org>
References: <1492498973-2969-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1492498973-2969-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Magnus Damm <magnus.damm@gmail.com>, linux-ide@vger.kernel.org, Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
List-Id: linux-ide@vger.kernel.org

On Tue, Apr 18, 2017 at 04:02:53PM +0900, Simon Horman wrote:
> In the case where power is cut on suspend the SATA PHY state needs to be
> suspended on resume.
  ^
  re-initialized?

> 
> This is the case on the Salvator-X board with the r8a7795 or r8a7796 SoC.
> In that environment it has been observed that SATA partitions cannot not be
> accessed on resume.
> 
> Based on work by Khiem Nguyen.
> 
> Cc: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
> * Compile and boot tested only

Can somebody verify this fix?

Thanks.

-- 
tejun
