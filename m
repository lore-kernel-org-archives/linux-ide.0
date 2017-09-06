From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: zpodd: make arrays cdb static, reduces object
 code size
Date: Wed, 6 Sep 2017 07:40:54 -0700
Message-ID: <20170906144054.GM1774378@devbig577.frc2.facebook.com>
References: <20170906085629.23938-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170906085629.23938-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: linux-ide@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Wed, Sep 06, 2017 at 09:56:29AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the arrays cdb on the stack, instead make them static.
> Makes the object code smaller by 230 bytes:
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>    3797	    240	      0	   4037	    fc5	drivers/ata/libata-zpodd.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>    3407	    400	      0	   3807	    edf	drivers/ata/libata-zpodd.o
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to libata/for-4.14.

Thanks.

-- 
tejun
