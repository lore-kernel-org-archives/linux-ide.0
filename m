From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: SiS 180 pata
Date: Wed, 07 Jul 2004 01:36:45 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <40EB8BED.4070002@pobox.com>
References: <200407051253.47003.ivololeribar@yahoo.it> <200407052305.29015.ivololeribar@yahoo.it> <1089062694.2868.20.camel@uk3.local> <200407052327.41618.ivololeribar@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15235 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264911AbUGGFg6
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Jul 2004 01:36:58 -0400
In-Reply-To: <200407052327.41618.ivololeribar@yahoo.it>
List-Id: linux-ide@vger.kernel.org
To: Nicola <ivololeribar@yahoo.it>
Cc: Uwe Koziolek <uwe.koziolek@gmx.net>, linux-ide@vger.kernel.org

Nicola wrote:
> 00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (prog-if 80 [Master])
> 	Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE Controller (A,B step)
> 	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

> 00:0c.0 RAID bus controller: Silicon Integrated Systems [SiS]: Unknown device 0180 (prog-if 85)
> 	Subsystem: Silicon Integrated Systems [SiS]: Unknown device 0180
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-


It certainly looks like IDE and SATA devices are separate to me?

