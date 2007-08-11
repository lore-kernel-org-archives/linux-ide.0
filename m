From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/2] hpt366: UltraDMA filtering for SATA cards
Date: Sat, 11 Aug 2007 20:03:35 +0200
Message-ID: <200708112003.35489.bzolnier@gmail.com>
References: <200708060008.38077.sshtylyov@ru.mvista.com> <200708090008.10352.bzolnier@gmail.com> <46BDF1A4.2020902@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.190]:44356 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753948AbXHKSDt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 11 Aug 2007 14:03:49 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1560077mue
        for <linux-ide@vger.kernel.org>; Sat, 11 Aug 2007 11:03:48 -0700 (PDT)
In-Reply-To: <46BDF1A4.2020902@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: rah@bash.sh, linux-ide@vger.kernel.org

On Saturday 11 August 2007, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> >>Index: linux-2.6/drivers/ide/pci/hpt366.c
> >>===================================================================
> >>--- linux-2.6.orig/drivers/ide/pci/hpt366.c
> >>+++ linux-2.6/drivers/ide/pci/hpt366.c
> [...]
> >>+	case HPT372 :
> >>+	case HPT372A:
> >>+	case HPT372N:
> >>+	case HPT374 :
> >>+		/*
> >>+		 * Check for SATA drive by verifying that the word 93 is 0 and
> >>+		 * the drive is ATA-5 or higher compatible.
> >>+		 */
> >>+		if (id->hw_config == 0 && (id->major_rev_num & 0x7fe0))
> 
> > Same check as in ide-iops.c::eighty_ninty_three().
> 
> > Would make sense to add ide_id_is_sata_dev() inline to <linux/ide.h>.
> 
>     Right in this patch, or a later cleanup?

I prefer doing it in this patch but later cleanup is also OK...

Thanks.
Bart
