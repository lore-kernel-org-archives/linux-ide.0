From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: pata_imx: fix devm_ioremap_resource() return value
 checking
Date: Fri, 14 Mar 2014 14:31:13 -0400
Message-ID: <20140314183113.GB6889@mtj.dyndns.org>
References: <2050303.yEm1sTq1hQ@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2050303.yEm1sTq1hQ@amdc1032>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Fri, Mar 14, 2014 at 06:33:13PM +0100, Bartlomiej Zolnierkiewicz wrote:
> devm_ioremap_resource() returns a pointer to the remapped memory or
> an ERR_PTR() encoded error code on failure.  Fix the check inside
> pata_imx_probe() accordingly.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Applied to libata/for-3.15.

Thanks.

-- 
tejun
