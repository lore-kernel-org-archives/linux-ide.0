From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [linux-usb-devel] Re: BUG?: VIA IDE transfer-rate problem
Date: Sun, 22 Jan 2006 18:16:13 +0100
Message-ID: <43D3BDDD.3050405@keyaccess.nl>
References: <Pine.LNX.4.44L0.0601191623570.4622-100000@iolanthe.rowland.org> <200601201227.27000.pvrusb2@toplitzer.net> <43D0FD98.4080406@keyaccess.nl> <200601201644.19916.pvrusb2@toplitzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtpq3.groni1.gr.home.nl ([213.51.130.202]:5352 "EHLO
	smtpq3.groni1.gr.home.nl") by vger.kernel.org with ESMTP
	id S932197AbWAVROh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 22 Jan 2006 12:14:37 -0500
In-Reply-To: <200601201644.19916.pvrusb2@toplitzer.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Helmut Toplitzer <pvrusb2@toplitzer.net>
Cc: Alan Stern <stern@rowland.harvard.edu>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, dbrownell@users.sourceforge.net, linux-usb-devel@lists.sourceforge.net

Helmut Toplitzer wrote:

> However, at least temperatur goes slightly up (2K) wenn i load ehci-hcd
> and I can confirm the ASYNC problem:

[ snip ]

> bus pci, device 0000:00:10.3 (driver 10 Dec 2004)
> EHCI Host Controller
> EHCI 1.00, hcd state 1
> ownership 01000001 linux
> SMI sts/enable 0xe0080000
> structural params 0x00003206
> capability params 0x00006872
> status a008 Async Recl FLR
> command 010009 (park)=0 ithresh=1 period=256 RUN
> intrenable 37 IAA FATAL PCD ERR INT
> uframe 3851
> port 1 status 001000 POWER sig=se0
> port 2 status 001000 POWER sig=se0
> port 3 status 001000 POWER sig=se0
> port 4 status 001005 POWER sig=se0 PE CONNECT
> port 5 status 001000 POWER sig=se0
> port 6 status 001000 POWER sig=se0
> irq normal 963 err 0 reclaim 452 (lost 17)
> complete 964 unlink 0

Ah, indeed. "Wonderful", still a shared problem then. Guess we still 
want that person with the PCI analyser...

Cheers,
Rene
