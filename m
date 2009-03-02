From: Norman Diamond <n0diamond@yahoo.co.jp>
Subject: Re: Kernel bug crashing in HDIO_DRIVE_TASKFILE
Date: Mon, 2 Mar 2009 09:24:34 +0900 (JST)
Message-ID: <20090302002434.62707.qmail@web4109.mail.ogk.yahoo.co.jp>
References: <49AA6C35.9080403@gmail.com>
Reply-To: n0diamond@yahoo.co.jp
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web4109.mail.ogk.yahoo.co.jp ([124.83.200.71]:41634 "HELO
	web4109.mail.ogk.yahoo.co.jp" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750900AbZCBAbQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 1 Mar 2009 19:31:16 -0500
In-Reply-To: <49AA6C35.9080403@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Mark Lord <liml@rtr.ca>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Chuck Ebbert <cebbert@redhat.com>, Robert Hancock <hancockrwd@gmail.com>, Jens Axboe <jens.axboe@oracle.com>, n0diamond@yahoo.co.jp

I will try building a kernel without legacy IDE drivers,
but meanwhile here's the latest bug.

Knoppix 6.0.1 is built on kernel 2.6.28.4.  Legacy IDE
drivers still claim /dev/hda and /dev/hdc (the Knoppix CD
being on /dev/hdc).

In order to view part of a dump if it occurs, I typed the
following boot command:
knoppix 3 lang=en keyboard=jp106

When I try to do a TASKFILE WRITE_DMA (LBA28), the process
hangs.  No dump.  Ctrl+C and Ctrl+Z were ignored. 
Ctrl+Alt+F2 switched to a second VT (by the way this no
longer works if Knoppix 6.0.1 is booted to graphical
mode).  The second VT responded at first.  Then tried to
do a dd if=/dev/hda bs=512 count=5 | od, and the second VT
hanged too.

In the third VT, dmesg showed this error message:
hda-intel: Invalid position buffer, using LPIB read method
instead.

Google found several threads where people are blaming this
error message on audio drivers or wireless LAN drivers. 
Some people are saying it was fixed somewhere earlier than
2.6.28.4.  2.6.28.4 tells me it's not fixed, and the
timing sure doesn't look like audio or wireless LAN.

I'll try building a kernel without legacy IDE drivers, but
I wonder which kernel version to try.


--------------------------------------
Power up the Internet with Yahoo! Toolbar.
http://pr.mail.yahoo.co.jp/toolbar/
