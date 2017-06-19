From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: sata_rcar: make of_device_ids const.
Date: Mon, 19 Jun 2017 14:05:11 -0400
Message-ID: <20170619180511.GD12062@htj.duckdns.org>
References: <474047fe3280ca103275247df6aa67288220a9d4.1497614383.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <474047fe3280ca103275247df6aa67288220a9d4.1497614383.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: b.zolnierkie@samsung.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Fri, Jun 16, 2017 at 05:32:21PM +0530, Arvind Yadav wrote:
> of_device_ids are not supposed to change at runtime. All functions
> working with of_device_ids provided by <linux/of.h> work with const
> of_device_ids. So mark the non-const structs as const.
> 
> File size before:
>    text	   data	    bss	    dec	    hex	filename
>    3946	   2296	      0	   6242	   1862	drivers/ata/sata_rcar.o
> 
> File size after constify sata_rcar_match.
>    text	   data	    bss	    dec	    hex	filename
>    5554	    696	      0	   6250	   186a	drivers/ata/sata_rcar.o
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Applied to libata/for-4.13.

Thanks.

-- 
tejun
