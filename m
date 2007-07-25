From: Eric Sesterhenn / Snakebyte <snakebyte@gmx.de>
Subject: Re: Time Problems with 2.6.23-rc1-gf695baf2
Date: Wed, 25 Jul 2007 13:33:49 +0200
Message-ID: <20070725113349.GB5469@alice>
References: <20070723221630.GA28951@alice> <6bffcb0e0707241614s7b563b5bu114d2ecb227b1557@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:49444 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759747AbXGYLdw (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 25 Jul 2007 07:33:52 -0400
Content-Disposition: inline
In-Reply-To: <6bffcb0e0707241614s7b563b5bu114d2ecb227b1557@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Eric Sesterhenn / Snakebyte <snakebyte@gmx.de>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

* Michal Piotrowski (michal.k.k.piotrowski@gmail.com) wrote:
>  On 24/07/07, Eric Sesterhenn / Snakebyte <snakebyte@gmx.de> wrote:
> > see second 13 to 510, after pressing it about ten
> > times, it continues booting.
> 
>  Probing IDE interface...
> 
>  [   13.867939] VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on
>  pci0000:00:04.1
>  [   13.868062]     ide0: BM-DMA at 0xd800-0xd807, BIOS settings:
>  hda:DMA, hdb:pio
>  [   13.868268]     ide1: BM-DMA at 0xd808-0xd80f, BIOS settings:
>  hdc:DMA, hdd:DMA
>  [   13.868574] Probing IDE interface ide0...
>  [  387.279576] Clocksource tsc unstable (delta = 370195339890 ns)
>  [  496.200082] hda: ST340823A, ATA DISK drive
>  [  510.264511] hda: selected mode 0x44
>  [  510.264826] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> 
>  Could you please try to revert these commits
> 
>  commit 4099d14322149c7a467e4997b87be4ba8eb78697
>  commit 6a824c92db4d606c324272c4eed366fb71672440
>  commit a5d8c5c834d3cabf4b7b477c3f6ee923c25026fc

reverting these commits didnt change anything at all,
booting with acpi=off resolved the issue, so i guess it is
an acpi problem after all.

Greetings, Eric
