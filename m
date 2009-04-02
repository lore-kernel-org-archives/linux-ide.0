From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: falconide/q40ide - Use __ide_mm_{in,out}sw() for data transfer
Date: Thu, 2 Apr 2009 20:50:51 +0200
Message-ID: <200904022050.52002.bzolnier@gmail.com>
References: <Pine.LNX.4.64.0904012243060.29342@anakin>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:44079 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759794AbZDBTgf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Apr 2009 15:36:35 -0400
In-Reply-To: <Pine.LNX.4.64.0904012243060.29342@anakin>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-ide@vger.kernel.org, Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux/m68k <linux-m68k@vger.kernel.org>

On Wednesday 01 April 2009, Geert Uytterhoeven wrote:
> Both of commits f94116aeec7a299640dd692128e1d22178affa8d ("ide: cleanup
> <asm-m68k/ide.h>") and 15a453a955f89f6545118770c669b52e925368bd ("ide: include
> <asm/ide.h> only when needed") break falconide:
> 
> | Uniform Multi-Platform E-IDE driver
> | ide: Falcon IDE controller
> | Probing IDE interface ide0...
> | hda: Sarge m68k, ATA DISK drive
> | ide0 at 0xfff00000 on irq 15 (serialized)
> | ide-gd driver 1.18
> | hda: max request size: 128KiB
> | hda: 2118816 sectors (1084 MB) w/256KiB Cache, CHS=2102/16/63
> |  hda:<4>hda: lost interrupt
> 
> This happens because falconide relies on {in,out}sw() being redefined in
> <asm/ide.h>, as included by <linux/ide.h>, which is no longer the case.
> Use __ide_mm_{in,out}sw() from <asm/ide.h> instead, just like
> ide_{in,out}put_data() do.
> 
> The same problem seems to exist in q40ide.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

applied

Many thanks for fixing this issue and the IRQF_SHARED one!
