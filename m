From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] pata_pdc2027x: Fix coding sytle errors
Date: Tue, 5 Dec 2017 11:49:48 -0800
Message-ID: <20171205194948.GY2421075@devbig577.frc2.facebook.com>
References: <1512498399-23577-1-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1512498399-23577-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: b.zolnierkie@samsung.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, Dec 05, 2017 at 11:56:38PM +0530, Arvind Yadav wrote:
> Fix these checkpatch.pl errors:
> Fix checkpatch.pl error:
> ERROR: space prohibited before open square bracket '['.
> 
> ERROR: space prohibited after that '~' (ctx:WxW)
> +		mask &= ~ (1 << (6 + ATA_SHIFT_UDMA));
> 
> ERROR: spaces required around that '?' (ctx:VxW)
> +	long pout_required = board_idx? PDC_133_MHZ:PDC_100_MHZ;
> 
> ERROR: that open brace { should be on the previous line
> +	const struct ata_port_info *ppi[] =
> +		{ &pdc2027x_port_info[board_idx], NULL };
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Patch doesn't apply to libata/for-4.16.  Also, please keep Bart's
Acked-by when posting updated versions.

Thanks.

-- 
tejun
