From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: arm-lh7a40x IDE support in 2.6.6
Date: Fri, 14 May 2004 18:52:25 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200405141852.25816.bzolnier@elka.pw.edu.pl>
References: <200405141840.04401.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:15772 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261597AbUENRAY
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 May 2004 13:00:24 -0400
In-Reply-To: <200405141840.04401.bzolnier@elka.pw.edu.pl>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: elf@buici.com, rmk@arm.linux.org.uk
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


This code won't even compile it the current form:
it uses ide_ioreg_t but I killed all users of ide_ioreg_t
and obsoleted <asm/hdreg.h> braindamage.

On Friday 14 of May 2004 18:40, Bartlomiej Zolnierkiewicz wrote:
> I was just porting my patches killing <asm/arch/ide.h> for
> ARM to 2.6.6 when noticed that more work is needed now. :-(
>
> arch/arm/mach-lh7a40x/ide-lpd7a40x.c
> include/asm-arm/arch-lh7a40x/ide.h

<...>

> BTW does it even work as IDE polling code is not merged yet?
>
> Bartlomiej

