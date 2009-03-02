From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Kernel bug crashing in HDIO_DRIVE_TASKFILE
Date: Sun, 01 Mar 2009 20:38:05 -0600
Message-ID: <49AB468D.6030506@gmail.com>
References: <20090302002434.62707.qmail@web4109.mail.ogk.yahoo.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:62349 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757351AbZCBCiN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Mar 2009 21:38:13 -0500
Received: by ey-out-2122.google.com with SMTP id 25so483076eya.37
        for <linux-ide@vger.kernel.org>; Sun, 01 Mar 2009 18:38:10 -0800 (PST)
In-Reply-To: <20090302002434.62707.qmail@web4109.mail.ogk.yahoo.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: n0diamond@yahoo.co.jp
Cc: linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Chuck Ebbert <cebbert@redhat.com>, Jens Axboe <jens.axboe@oracle.com>

Norman Diamond wrote:
> I will try building a kernel without legacy IDE drivers,
> but meanwhile here's the latest bug.
> 
> Knoppix 6.0.1 is built on kernel 2.6.28.4.  Legacy IDE
> drivers still claim /dev/hda and /dev/hdc (the Knoppix CD
> being on /dev/hdc).
> 
> In order to view part of a dump if it occurs, I typed the
> following boot command:
> knoppix 3 lang=en keyboard=jp106
> 
> When I try to do a TASKFILE WRITE_DMA (LBA28), the process
> hangs.  No dump.  Ctrl+C and Ctrl+Z were ignored. 
> Ctrl+Alt+F2 switched to a second VT (by the way this no
> longer works if Knoppix 6.0.1 is booted to graphical
> mode).  The second VT responded at first.  Then tried to
> do a dd if=/dev/hda bs=512 count=5 | od, and the second VT
> hanged too.
> 
> In the third VT, dmesg showed this error message:
> hda-intel: Invalid position buffer, using LPIB read method
> instead.
> 
> Google found several threads where people are blaming this
> error message on audio drivers or wireless LAN drivers. 
> Some people are saying it was fixed somewhere earlier than
> 2.6.28.4.  2.6.28.4 tells me it's not fixed, and the
> timing sure doesn't look like audio or wireless LAN.

I'm guessing that's a symptom and not a cause, if the IDE driver is
causing some kind of partial lockup then that could be messing with the
audio driver..

> 
> I'll try building a kernel without legacy IDE drivers, but
> I wonder which kernel version to try.

Normally latest is best..
