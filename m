From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/6] ide: simplify 'struct ide_taskfile'
Date: Mon, 6 Apr 2009 23:14:17 +0200
Message-ID: <200904062314.17249.bzolnier@gmail.com>
References: <200904022259.28077.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:43876 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756385AbZDFVLr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Apr 2009 17:11:47 -0400
Received: by fg-out-1718.google.com with SMTP id e12so851169fga.17
        for <linux-ide@vger.kernel.org>; Mon, 06 Apr 2009 14:11:45 -0700 (PDT)
In-Reply-To: <200904022259.28077.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Thursday 02 April 2009, Sergei Shtylyov wrote:
> Make 'struct ide_taskfile' cover only 8 register values and thus put two such
> fields ('tf' and 'hob') into 'struct ide_cmd', dropping unnecessary 'tf_array'
> field from it.
> 
> This required changing the prototype of ide_get_lba_addr() and ide_tf_dump().
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

[...]

> Index: linux-2.6/drivers/ide/ide-disk.c
> ===================================================================
> --- linux-2.6.orig/drivers/ide/ide-disk.c
> +++ linux-2.6/drivers/ide/ide-disk.c
> @@ -105,18 +105,19 @@ static ide_startstop_t __ide_do_rw_disk(
>  			pr_debug("%s: LBA=0x%012llx\n", drive->name,
>  					(unsigned long long)block);
>  
> -			tf->hob_nsect = (nsectors >> 8) & 0xff;
> -			tf->hob_lbal  = (u8)(block >> 24);
> -			if (sizeof(block) != 4) {
> -				tf->hob_lbam = (u8)((u64)block >> 32);
> -				tf->hob_lbah = (u8)((u64)block >> 40);
> -			}
> -
>  			tf->nsect  = nsectors & 0xff;
>  			tf->lbal   = (u8) block;
>  			tf->lbam   = (u8)(block >>  8);
>  			tf->lbah   = (u8)(block >> 16);
>  
> +			tf = &cmd.hob;
> +			tf->nsect = (nsectors >> 8) & 0xff;
> +			tf->lbal  = (u8)(block >> 24);
> +			if (sizeof(block) != 4) {
> +				tf->lbam = (u8)((u64)block >> 32);
> +				tf->lbah = (u8)((u64)block >> 40);
> +			}

The only drawback of having identical structures for tf and hob
is that it is now possible to try setting hob->{command,status,device}
instead of tf's field.

i.e. this chunk needed following fixup:

diff -u b/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- b/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -109,6 +109,7 @@
 			tf->lbal   = (u8) block;
 			tf->lbam   = (u8)(block >>  8);
 			tf->lbah   = (u8)(block >> 16);
+			tf->device = ATA_LBA;
 
 			tf = &cmd.hob;
 			tf->nsect = (nsectors >> 8) & 0xff;
@@ -126,10 +127,8 @@
 			tf->lbal   = block;
 			tf->lbam   = block >>= 8;
 			tf->lbah   = block >>= 8;
-			tf->device = (block >> 8) & 0xf;
+			tf->device = ((block >> 8) & 0xf) | ATA_LBA;
 		}
-
-		tf->device |= ATA_LBA;
 	} else {
 		unsigned int sect, head, cyl, track;
 
Probably BUG_ON() on non-zero hob->{command,device} in do_rw_taskfile()
would be very useful for catching such problems early...
