From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] make ide driver compilable as kernel module (2.6.0)
Date: Thu, 8 Jan 2004 19:19:38 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200401081919.38846.bzolnier@elka.pw.edu.pl>
References: <16381.38890.741153.45100@ipc1.karo>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:22934 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265939AbUAHSQk
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Jan 2004 13:16:40 -0500
In-Reply-To: <16381.38890.741153.45100@ipc1.karo>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Lothar Wassmann <LW@KARO-electronics.de>
Cc: linux-ide@vger.kernel.org

On Thursday 08 of January 2004 18:48, Lothar Wassmann wrote:
> Hi,

Hi,

> the following patch enables building the ide driver as a kernel
> module:

It makes them compile, but such modules won't work correctly for some cases.
It should be fixed similarly as in 2.4.23 (IIRC), I've tried to (patch was posted
on lkml but without [PATCH] in the subject), but was reported that it doesn't
work.  This issue requires more work (please read archives for details).

> (BTW: the MAINTAINERS file lists 'B.Zolnierkiewicz@elka.pw.edu.pl' as
>  the maintainers email address, while all the source files say:
> '<bkz@linux-ide.org>') --- linux-2.6.0/drivers/block/ll_rw_blk.c	17 Dec

Both work currently.  Please use B.Zolnierkiewicz@elka.pw.edu.pl,
bkz@linux-ide.org is just a forward.

--bart

