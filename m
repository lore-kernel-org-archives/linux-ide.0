From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: fix R-Car SATA driver dependencies
Date: Wed, 26 Mar 2014 10:21:29 -0400
Message-ID: <20140326142129.GD7171@htj.dyndns.org>
References: <4494466.bbG3GqUbue@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4494466.bbG3GqUbue@amdc1032>
Sender: linux-sh-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-ide@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wed, Mar 26, 2014 at 03:19:23PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Make sata_rcar host driver depend on ARCH_SHMOBILE config option as
> Renesas R-Car SATA support is specific to Renesas SoCs and the driver
> to work requires suitable device tree node (or platform device) to be
> defined.  Additionally allow the driver build if COMPILE_TEST config
> option is set.
> 
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Applied to libata/for-3.15.

Thanks.

-- 
tejun
