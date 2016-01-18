From: David Miller <davem@davemloft.net>
Subject: Re: [patch] ide: silence some underflow warnings
Date: Mon, 18 Jan 2016 14:12:53 -0500 (EST)
Message-ID: <20160118.141253.803019327755668580.davem@davemloft.net>
References: <20151113143401.GC1445@mwanda>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151113143401.GC1445@mwanda>
Sender: linux-kernel-owner@vger.kernel.org
To: dan.carpenter@oracle.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 13 Nov 2015 17:34:01 +0300

> Back in the day we used to just say this code was root only so it was
> ok that the bounds checking was sloppy.  These days it annoys static
> checkers so we fix it.
> 
> In the original code "c > INT_MAX" was never true since "c" was an int.
> I am not sure what was intended so I left it alone.  But because I made
> "c" unsigned it means we don't have a warning any more.
> 
> The second warning is that we cap "i" but allow negatives leading to an
> underflow of the ide_disks_chs[] array.  The third set of warnings is
> because these values come from the user and we cap most of the upper
> bounds but allow negative values.  Negative cylinders doesn't make
> sense.
> 
> drivers/ide/ide.c:262 ide_set_disk_chs() warn: impossible condition '(c > ((~0 >> 1))) => (s32min-s32max > s32max)'
> drivers/ide/ide.c:270 ide_set_disk_chs() warn: check 'ide_disks_chs[i]' for negative offsets 'i' = s32min.  extra = 's32min-19'
> drivers/ide/ide.c:271 ide_set_disk_chs() warn: no lower bound on 'h'
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied.
