From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ST340823A disk size issue
Date: Thu, 2 Aug 2007 21:42:46 +0100
Message-ID: <20070802214246.63a54fe6@the-village.bc.nu>
References: <20070801092903.GA1199@nalle>
	<200708020019.25742.bzolnier@gmail.com>
	<20070801233221.34e2ff0c@the-village.bc.nu>
	<200708020117.58916.bzolnier@gmail.com>
	<20070802200357.GA1178@nalle>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57184 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751043AbXHBUfl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Aug 2007 16:35:41 -0400
In-Reply-To: <20070802200357.GA1178@nalle>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikko Rapeli <mikko.rapeli@iki.fi>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

> hdd: reading: block=78165360, sectors=1, buffer=0xc1e63000
> hdd: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hdd: dma_intr: error=0x10 { SectorIdNotFound }, LBAsect=78165360,

Ok this one does look like its actually a specific drive firmware error

> ide1: reset: master: error (0x00?)
> ide1: start_request: current=0xc1e0b408

and the drive then shits itself in style. Bart's right - this drive does
need a blacklisting. Presumably thats why it shipped with a default HPA
to clip the non-sector 

>
