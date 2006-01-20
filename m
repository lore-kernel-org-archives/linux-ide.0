From: Helmut Toplitzer <pvrusb2@toplitzer.net>
Subject: Re: [linux-usb-devel] Re: BUG?: VIA IDE transfer-rate problem
Date: Fri, 20 Jan 2006 16:44:19 +0100
Message-ID: <200601201644.19916.pvrusb2@toplitzer.net>
References: <Pine.LNX.4.44L0.0601191623570.4622-100000@iolanthe.rowland.org> <200601201227.27000.pvrusb2@toplitzer.net> <43D0FD98.4080406@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from toplitzer.net ([83.151.30.110]:11727 "EHLO toplitzer.net")
	by vger.kernel.org with ESMTP id S1750808AbWATPoY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Jan 2006 10:44:24 -0500
In-Reply-To: <43D0FD98.4080406@keyaccess.nl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Alan Stern <stern@rowland.harvard.edu>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, dbrownell@users.sourceforge.net, linux-usb-devel@lists.sourceforge.net

> experiencing the same problem after all. I feel so alone again...

However, at least temperatur goes slightly up (2K) wenn i load ehci-hcd
and I can confirm the ASYNC problem:

bus pci, device 0000:00:10.3 (driver 10 Dec 2004)
EHCI Host Controller
EHCI 1.00, hcd state 1
ownership 01000001 linux
SMI sts/enable 0xe0080000
structural params 0x00003206
capability params 0x00006872
status 0008 FLR
command 010009 (park)=0 ithresh=1 period=256 RUN
intrenable 37 IAA FATAL PCD ERR INT
uframe 0bb4
port 1 status 001000 POWER sig=se0
port 2 status 001000 POWER sig=se0
port 3 status 001000 POWER sig=se0
port 4 status 001005 POWER sig=se0 PE CONNECT
port 5 status 001000 POWER sig=se0
port 6 status 001000 POWER sig=se0
irq normal 963 err 0 reclaim 452 (lost 17)
complete 964 unlink 0


bus pci, device 0000:00:10.3 (driver 10 Dec 2004)
EHCI Host Controller
EHCI 1.00, hcd state 1
ownership 01000001 linux
SMI sts/enable 0xe0080000
structural params 0x00003206
capability params 0x00006872
status a008 Async Recl FLR
command 010009 (park)=0 ithresh=1 period=256 RUN
intrenable 37 IAA FATAL PCD ERR INT
uframe 3851
port 1 status 001000 POWER sig=se0
port 2 status 001000 POWER sig=se0
port 3 status 001000 POWER sig=se0
port 4 status 001005 POWER sig=se0 PE CONNECT
port 5 status 001000 POWER sig=se0
port 6 status 001000 POWER sig=se0
irq normal 963 err 0 reclaim 452 (lost 17)
complete 964 unlink 0

So there at least some similarities.

Helmut

-- 
My GNUpg fingerprint http://www.gnupg.org
4563 F4FB 0B7E 8698 53CD  00E9 E319 35BD 6A91 1656
