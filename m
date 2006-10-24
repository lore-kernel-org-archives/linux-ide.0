From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: SATA driver issues?
Date: Tue, 24 Oct 2006 13:11:25 +0100
Message-ID: <1161691885.22348.10.camel@localhost.localdomain>
References: <2F0FC2A92C0B154BB406D5E74CB3E6930336BD5F@3putt.int.lantronix.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34744 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161002AbWJXMIm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Oct 2006 08:08:42 -0400
In-Reply-To: <2F0FC2A92C0B154BB406D5E74CB3E6930336BD5F@3putt.int.lantronix.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Danny Sung <dsung@lantronix.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Ar Llu, 2006-10-23 am 18:27 -0700, ysgrifennodd Danny Sung:
> Prior to the firmware update, I got errors like these, along with
> periodic system hangs:
> Oct 15 03:50:40 aeolus kernel: ata2: command 0xea timeout, stat 0x50
> host_stat 0x0
> Oct 15 03:50:40 aeolus kernel: ata2: status=0x50 { DriveReady
> SeekComplete }
> Oct 15 03:50:40 aeolus kernel: ata2: error=0x01 { AddrMarkNotFound }

Your drive is reporting an error that it cannot find a disk sector.

> My latest test was to boot up with the following kernel parameters:
> "pci=noacpi idebus=66".  I'm not quite sure if I should be using 66 or

Well unless your system is very strange your idebus is 33Mhz, you only
need idebus= on old 486 systems with vesa local bus.


