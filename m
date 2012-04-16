From: Andy Whitcroft <apw@canonical.com>
Subject: Re: [PATCH 0/2] Hyper-V disk support V3
Date: Mon, 16 Apr 2012 19:28:42 +0100
Message-ID: <20120416182842.GA3346@shadowen.org>
References: <20120414170223.24f6ea31@pyramind.ukuu.org.uk>
 <1334575229-7493-1-git-send-email-apw@canonical.com>
 <4F8C3B86.8000707@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:40619 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231Ab2DPS2q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Apr 2012 14:28:46 -0400
Content-Disposition: inline
In-Reply-To: <4F8C3B86.8000707@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>, Mike Sterling <Mike.Sterling@microsoft.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Mon, Apr 16, 2012 at 11:32:22AM -0400, Jeff Garzik wrote:
> On 04/16/2012 07:20 AM, Andy Whitcroft wrote:
> >Jeff, I believe the first patch is what you had in mind in your comments.
> >Alan, the piix sadly has no subvendor/subdevice identifiers at all
> >though we are able to detect the platform from the DMI information,
> >this any better?
> 
> Please post "lspci -vvv" for this device...

lspci -nnvvv:

00:07.1 IDE interface [0101]: Intel Corporation 82371AB/EB/MB PIIX4 IDE [8086:7111] (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Region 0: [virtual] Memory at 000001f0 (32-bit, non-prefetchable) [size=8]
	Region 1: [virtual] Memory at 000003f0 (type 3, non-prefetchable) [size=1]
	Region 2: [virtual] Memory at 00000170 (32-bit, non-prefetchable) [size=8]
	Region 3: [virtual] Memory at 00000370 (type 3, non-prefetchable) [size=1]
	Region 4: I/O ports at ffa0 [size=16]
	Kernel driver in use: ata_piix

-apw
