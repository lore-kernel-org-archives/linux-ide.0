From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Subject: Re: WIN_READ_NATIVE_MAX_EXT returns incomplete result
Date: Wed, 17 Nov 2004 15:41:27 +0000
Message-ID: <20041117154126.GA16688@palantir8>
References: <20041116173444.GA27676@palantir8> <58cb370e04111610291be130b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mra04.ex.eclipse.net.uk ([212.104.129.139]:43912 "EHLO
	mra04.ex.eclipse.net.uk") by vger.kernel.org with ESMTP
	id S262343AbUKQPlf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 17 Nov 2004 10:41:35 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mra04.ex.eclipse.net.uk (Postfix) with ESMTP id B07D9133ACA
	for <linux-ide@vger.kernel.org>; Wed, 17 Nov 2004 15:41:18 +0000 (GMT)
Received: from mra04.ex.eclipse.net.uk ([127.0.0.1])
 by localhost (mra04.ex.eclipse.net.uk [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 09191-01-55 for <linux-ide@vger.kernel.org>;
 Wed, 17 Nov 2004 15:41:17 +0000 (GMT)
Received: from palantir8.mph.eclipse.net (unknown [81.168.73.77])
	by mra04.ex.eclipse.net.uk (Postfix) with ESMTP id 61A3F1343F4
	for <linux-ide@vger.kernel.org>; Wed, 17 Nov 2004 15:41:17 +0000 (GMT)
Received: from mhabets by palantir8.mph.eclipse.net with local (Exim 3.36 #1 (Debian))
	id 1CURvz-00083G-00
	for <linux-ide@vger.kernel.org>; Wed, 17 Nov 2004 15:41:27 +0000
Content-Disposition: inline
In-Reply-To: <58cb370e04111610291be130b4@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On Tue, Nov 16, 2004 at 07:29:31PM +0100, Bartlomiej Zolnierkiewicz wrote:
> In kernel 2.6.8 LBA48 support is disabled for ALi chipsets with revisions
> <= 0xC4 (drive->addressing is set to zero) but idedisk_check_hpa()
> incorrectly uses drive->id directly which results in this bug (because
> do_rw_taskfile() and ide_end_drive_cmd() rely on drive->addressing).
> 
> This patch should fix it:

Thanks, works like a charm!

> --- ide-disk.c.orig	2004-11-05 23:24:41.000000000 +0100
> +++ ide-disk.c	2004-11-16 19:24:17.321273832 +0100
> @@ -625,7 +625,7 @@
>  static inline void idedisk_check_hpa(ide_drive_t *drive)
>  {
>  	unsigned long long capacity, set_max;
> -	int lba48 = idedisk_supports_lba48(drive->id);
> +	unsigned int lba48 = drive->addressing;
>  
>  	capacity = drive->capacity64;
>  	if (lba48)
> 
> Moreover you shouldn't hit this bug in current kernels because they
> use LBA48 (with some limitations: no DMA for LBA48 area) for ALi
> chipsets revs <= 0xC4.

Was planning to stay on 2.6.8 for a while.

-- 
Martin
