From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [2.4 IDE PATCH] SanDisk is flash (fwd)
Date: Tue, 13 Apr 2004 22:12:11 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200404132212.11481.bzolnier@elka.pw.edu.pl>
References: <20040413195344.GA523@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:47769 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263730AbUDMUNY
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 13 Apr 2004 16:13:24 -0400
In-Reply-To: <20040413195344.GA523@fs.tum.de>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@fs.tum.de>, Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Tuesday 13 of April 2004 21:53, Adrian Bunk wrote:
> The patch forwarded below by Meelis Roos was already included in
> 2.4.26-rc. It does apply against 2.6, too, so I assume it should also be
> added there?

Some time ago I sent mail to Meelis asking if this patch is really necessary.
No answer yet.

> cu
> Adrian
>
>
> ----- Forwarded message from Meelis Roos <mroos@linux.ee> -----
>
> Date:	Thu, 1 Apr 2004 21:26:13 +0300 (EEST)
> From: Meelis Roos <mroos@linux.ee>
> To: Linux Kernel list <linux-kernel@vger.kernel.org>
> Subject: [2.4 IDE PATCH] SanDisk is flash
>
> This is self-explanatory - former SunDisk renamed itself to SanDisk and
> now there are flash disks with both names.

Please excuse me but I am dumb... ;-)

Does this mean that CF test fail or that SunDisk is SanDisk now?

id->config == 0x848a test was introduced in kernel 2.3.27 _after_
SunDisk model name test and if id->config == 0x848a test fails
comment to drive_is_flashcard() needs fixing.

> ===== drivers/ide/ide-probe.c 1.21 vs edited =====
> --- 1.21/drivers/ide/ide-probe.c	Mon Nov 24 00:05:18 2003
> +++ edited/drivers/ide/ide-probe.c	Thu Apr  1 21:15:22 2004
> @@ -102,7 +102,8 @@
>  		if (id->config == 0x848a) return 1;	/* CompactFlash */
>  		if (!strncmp(id->model, "KODAK ATA_FLASH", 15)	/* Kodak */
>
>  		 || !strncmp(id->model, "Hitachi CV", 10)	/* Hitachi */
>
> -		 || !strncmp(id->model, "SunDisk SDCFB", 13)	/* SunDisk */
> +		 || !strncmp(id->model, "SunDisk SDCFB", 13)	/* old SanDisk */
> +		 || !strncmp(id->model, "SanDisk SDCFB", 13)	/* SanDisk */
>
>  		 || !strncmp(id->model, "HAGIWARA HPC", 12)	/* Hagiwara */
>  		 || !strncmp(id->model, "LEXAR ATA_FLASH", 15)	/* Lexar */
>  		 || !strncmp(id->model, "ATA_FLASH", 9))	/* Simple Tech */

