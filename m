From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: ide-io.c, ide_do_request -- race condition?
Date: Mon, 12 Jul 2004 17:47:54 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200407121747.54569.bzolnier@elka.pw.edu.pl>
References: <40E99531.BDB8D339@verizon.net> <200407102207.19713.bzolnier@elka.pw.edu.pl> <40F2AAF5.79BEC86B@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:29591 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265203AbUGLPmk
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jul 2004 11:42:40 -0400
In-Reply-To: <40F2AAF5.79BEC86B@verizon.net>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: "Max T. Woodbury" <max.teneyck.woodbury@verizon.net>
Cc: linux-ide@vger.kernel.org


On Monday 12 of July 2004 17:15, Max T. Woodbury wrote:
> PIIXa: IDE controller at PCI slot 00:01.0
> PIIXa: chipset revision 2
> PIIXa: not 100% native mode: will probe irqs later
> PIIXa: neither IDE port enabled (BIOS)

Do you have IDE ports disabled in BIOS?

This prevents piix IDE driver from working and instead you are using
generic IDE driver which is much slower (no DMA!) and may be unsafe.

Bartlomiej

