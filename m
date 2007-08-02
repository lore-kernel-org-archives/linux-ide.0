From: Mikko Rapeli <mikko.rapeli@iki.fi>
Subject: Re: ST340823A disk size issue
Date: Thu, 2 Aug 2007 15:35:11 +0300
Message-ID: <20070802123510.GA1374@nalle>
References: <20070801092903.GA1199@nalle> <20070801140556.136ed130@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gw03.mail.saunalahti.fi ([195.197.172.111]:39715 "EHLO
	gw03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754647AbXHBMfQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Aug 2007 08:35:16 -0400
Content-Disposition: inline
In-Reply-To: <20070801140556.136ed130@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

On Wed, Aug 01, 2007 at 02:05:56PM +0100, Alan Cox wrote:
> You've got an odd sized disk. If you have that, old IDE, and you also have
> anything which tries to read the last sector (eg GPT partitioning) it'll
> break as it tries to read 1K block sizes.
>
> Vendors normally clip the drive to an even size which seems to be the
> case on your box with the HPA left alone.

Sorry, but I don't quite get the odd size and 1k block thing.

Drive manual (
http://www.seagate.com/support/disc/manuals/ata/u5pmb01.pdf ) says on
page 12 that the drive has 78165360 sectors of size 512 bytes of which 
0 to 78165359 are addressable in LBA mode.

The drive reports its size as 78165360 and falsely, according to kernels
addr++, with HPA as 78165361. So instead of reporting the maximum
addressable sector 78165359, the drive reports its size 78165360.

Kernel now picks the larger value 78165361 as the drive size and thinks 
sector 78165360 should exist, but it doesn't. Partition code tries to
read the last sector 78165360 and fails:

hdd: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdd: dma_intr: error=0x10 { SectorIdNotFound }, LBAsect=78165360,
sector=78165360
ide: failed opcode was: unknown

Shouldn't the partition code also try to read 78165361 if there was a 1k
read issued?

> It *should* all "just work" with the libata drivers but needs more
> testing of odd sizes to be 100% sure

The drive just worked with libata and 2.6.22.1, but I'd like to get a
back protable fix to ide-disk.c, so distro kernels like 2.6.18 could be
made to work too.

-Mikko
