From: Sven Ladegast <sven@linux4geeks.de>
Subject: Re: sata_sis and SIS180 in combined mode
Date: Mon, 4 Dec 2006 00:06:06 +0100
Message-ID: <200612040006.06191.sven@linux4geeks.de>
References: <200612031834.16797.sven@linux4geeks.de> <20061203230411.1df15e56@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from newton.linux4geeks.de ([193.30.1.1]:37605 "EHLO
	newton.linux4geeks.de") by vger.kernel.org with ESMTP
	id S1758818AbWLCXGA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 3 Dec 2006 18:06:00 -0500
In-Reply-To: <20061203230411.1df15e56@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: uwe.koziolek@web.de, linux-ide@vger.kernel.org

Am Montag, 4. Dezember 2006 00:04 schrieben Sie:

> What does lspci show ?

lspci says the following:

00:07.0 RAID bus controller: Silicon Integrated Systems [SiS] RAID bus 
controller 180 SATA/PATA  [SiS] (prog-if 85)
        Subsystem: Silicon Integrated Systems [SiS] RAID bus controller 
180 SATA/PATA  [SiS]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at ff00 [size=8]
        Region 1: I/O ports at fe00 [size=4]
        Region 2: I/O ports at fd00 [size=8]
        Region 3: I/O ports at fc00 [size=4]
        Region 4: I/O ports at fb00 [size=16]
        Region 5: I/O ports at <unassigned>
        [virtual] Expansion ROM at 40040000 [disabled] [size=64K]
