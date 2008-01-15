From: "Kristin Vadas Marsicano" <kristin.marsicano@gmail.com>
Subject: Re: Trouble with hdparm -d on Dell D610
Date: Tue, 15 Jan 2008 13:26:49 -0500
Message-ID: <7f68de3e0801151026t5c92d56am5a4f5274a744a642@mail.gmail.com>
References: <7f68de3e0801111118x3fecace5n5c1f10b90b595d2f@mail.gmail.com>
	 <20080111193036.787a9fdc@lxorguk.ukuu.org.uk>
	 <7f68de3e0801111149x15afd429sf48ed7db5fff8fa1@mail.gmail.com>
	 <20080111195521.7e771e45@lxorguk.ukuu.org.uk>
	 <7f68de3e0801111227x50c9ff31n1435d005e6b6b1f3@mail.gmail.com>
	 <20080111210557.390271a0@lxorguk.ukuu.org.uk>
	 <7f68de3e0801111327m1363b681ree81fbc5f7f43848@mail.gmail.com>
	 <20080111213415.56d90f0d@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.238]:48803 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752599AbYAOS0u (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 15 Jan 2008 13:26:50 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1317855nze.1
        for <linux-ide@vger.kernel.org>; Tue, 15 Jan 2008 10:26:49 -0800 (PST)
In-Reply-To: <20080111213415.56d90f0d@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

I've tried the following configurations, none of which ended up in DMA
functioning on the D610.

# CONFIG_BLK_DEV_PIIX is not set
CONFIG_ATA_PIIX=y
CONFIG_PATA_MPIIX=y
CONFIG_PATA_OLDPIIX=y

# CONFIG_BLK_DEV_PIIX is not set
CONFIG_ATA_PIIX=y
CONFIG_PATA_MPIIX=y
# CONFIG_PATA_OLDPIIX is not set

Ultimately, my goal is to run shred at as quick a pace as possible on
all machines.  The D610 runs slow with the kernel config I was using
for the D600 (any various other machines).  I had success on making it
run quickly on the D610 by configured the kernel with
ATA/ATAPI/MFM/RLL support turned off completely.

Any thoughts as to why the configs listed above don't seem to work for
DMA on my D610?


On 1/11/08, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > My concern with disabling the new drivers is as follows: I use this
> > linux kernel and config image to boot machines over PXE and call a
> > shred program on each of the harddrives.  If I turn off CONFIG_ATA,
> > will this limit my ability to support various new IDE and SATA drives
> > for running shred?  So far, the configuration I have works well with
>
> Yes. In that case you can build without CONFIG_IDE_PIIX and with the
> CONFIG_ATA_PIIX driver and you should be fine too (but your disk will
> move to /dev/sda on that box). The PIIX is an awkward case as in some
> modes it combines both the SATA and PATA onto one 'device'.
>
> > most of the machines I encounter  (and with both SATA and IDE drives),
> > except for the Dell D610 and HP 7700 (small desktop pc).  The models I
> > just mentioned run the shred really slow, which I believe is due to
> > the DMA problem I was having (outlined in my previous emails).  Any
> > thoughts?
>
> If your shred program is relying on DMA then you are using the wrong tool
> for the job. The correct way to erase a disk is to send it a security
> erase command. Rewriting over the data may not do what is wanted.
>


-- 
Kristin Vadas Marsicano
kristin.marsicano@gmail.com
kristinisme.blogspot.com
