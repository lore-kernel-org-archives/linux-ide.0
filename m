From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] QD65xx I/O ports
Date: Fri, 9 Apr 2004 00:50:24 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200404090050.24841.bzolnier@elka.pw.edu.pl>
References: <Pine.GSO.4.58.0404061330470.4158@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:6575 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262898AbUDHWli
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Apr 2004 18:41:38 -0400
In-Reply-To: <Pine.GSO.4.58.0404061330470.4158@waterleaf.sonytel.be>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On Tuesday 06 of April 2004 13:31, Geert Uytterhoeven wrote:
> I/O port numbers can be larger than 8-bit on many platforms (this caused a
> warning when {out,in}b() cast reg to a pointer on platforms with memory
> mapped I/O)

Was VESA Local Bus ever used on something else than 486?
I think it's better to just add "depends on X86" to drivers/ide/Kconfig.

Cheers,
Bartlomiej

