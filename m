From: Sebastian Kuzminsky <seb.kuzminsky@gmail.com>
Subject: do I have a bad cable?
Date: Fri, 16 Dec 2005 14:29:57 -0700
Message-ID: <7f55de720512161329n79873a3s3f9b7f79db29e0d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.202]:3118 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932457AbVLPV36 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Dec 2005 16:29:58 -0500
Received: by wproxy.gmail.com with SMTP id 57so675931wri
        for <linux-ide@vger.kernel.org>; Fri, 16 Dec 2005 13:29:58 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I've got a system with a pair of Promise TX2 cards (Promise 20269
chipset, PCI card, 2xPATA controller on each).  Each PATA channel has
a master only, no slave.  All four drives are Maxtor 5A300J0 (300 GB,
5400 RPM, 2 MB Cache, ATA133).  This is run as a RAID5 and works fine.
 This is with 2.6.15-rc5, compiled with Debian's gcc 4.0.3 prerelease
(4.0.2-5 20051201).

Very occasionally I'll get this error:

Dec 15 22:04:16 snappy kernel: hdk: dma_intr: status=0x51 { DriveReady
SeekComplete Error }
Dec 15 22:04:16 snappy kernel: hdk: dma_intr: error=0x84 {
DriveStatusError BadCRC }
Dec 15 22:04:16 snappy kernel: ide: failed opcode was: unknown

I'm guessing the BadCRC means I'm getting CRC errors between the drive
and the HBA?  And I'm guessing that means I have a bad cable?  It's a
pretty nice rounded 80-pin cable, FWIW.

Any advice is appreciated...


--
Sebastian Kuzminsky
