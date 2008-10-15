From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: remove dead <asm-arm/arch-sa1100/ide.h>
Date: Wed, 15 Oct 2008 20:10:48 +0200
Message-ID: <200810152010.48381.bzolnier@gmail.com>
References: <200808101745.20434.bzolnier@gmail.com> <48F4EAC4.4000702@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:51067 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753281AbYJOTuI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Oct 2008 15:50:08 -0400
Received: by gxk9 with SMTP id 9so7371546gxk.13
        for <linux-ide@vger.kernel.org>; Wed, 15 Oct 2008 12:50:06 -0700 (PDT)
In-Reply-To: <48F4EAC4.4000702@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, Stephen Rothwell <sfr@canb.auug.org.au>

On Tuesday 14 October 2008, Sergei Shtylyov wrote:
> Hello.

You're back!! :)

> Bartlomiej Zolnierkiewicz wrote:
> 
> > It has been dead for more than 3 years and needs to be converted
> > to use platform PATA support anyway.
> 
>     This patch in the current pata-2.6 series does not apply at all.

Yeah, Stephen also noticed this while trying to cook new linux-next.

> > Cc: Russell King <rmk@arm.linux.org.uk>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> 
> Applying patch ide-remove-dead-asm-arm-arch-sa1100-ide-h.patch
> The text leading up to this was:
> --------------------------
> |From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> |Subject: [PATCH] ide: remove dead <asm-arm/arch-sa1100/ide.h>
> |
> |It has been dead for more than 3 years and needs to be converted
> |to use platform PATA support anyway.
> |
> |Cc: Russell King <rmk@arm.linux.org.uk>
> |Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> |---
> | include/asm-arm/arch-sa1100/ide.h |   75 --------------------------------------

It seems that in the meantime include/asm-arm/arch-sa1100/ide.h
became arch/arm/mach-sa1100/include/mach/ide.h.  Fixed.

> | 1 file changed, 75 deletions(-)
> |
> |Index: b/include/asm-arm/arch-sa1100/ide.h
> |===================================================================
> |--- a/include/asm-arm/arch-sa1100/ide.h
> |+++ /dev/null
> --------------------------
> No file to patch.  Skipping patch.
> 1 out of 1 hunk ignored
> 
> MBR, Sergei
