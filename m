From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/2] ahci: qoriq: Update the default Rx watermark value
Date: Wed, 16 Dec 2015 10:25:19 -0500
Message-ID: <20151216152519.GF4026@mtj.duckdns.org>
References: <1450244630-10065-1-git-send-email-Yuantian.Tang@freescale.com>
 <1450244630-10065-2-git-send-email-Yuantian.Tang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1450244630-10065-2-git-send-email-Yuantian.Tang@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yuantian.Tang@freescale.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wed, Dec 16, 2015 at 01:43:50PM +0800, Yuantian.Tang@freescale.com wrote:
> From: Tang Yuantian <Yuantian.Tang@freescale.com>
> 
> The PTC[RXWM] sets the watermark value for Rx FIFO. The default
> value 0x20 might be insufficient for some hard drives. If the
> watermark value is too small, a single-cycle overflow may occur
> and is reported as a CRC or internal error in the PxSERR register.
> Updated the value to 0x29 according to the validation test.
> All LS platforms are affected.
> 
> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>

Applied 1-2 to libata/for-4.5.

Thanks.

-- 
tejun
