From: "Kristin Vadas Marsicano" <kristin.marsicano@gmail.com>
Subject: Re: Trouble with hdparm -d on Dell D610
Date: Fri, 11 Jan 2008 16:49:38 -0500
Message-ID: <7f68de3e0801111349i2518924bj7bcfd7b5e9c604e2@mail.gmail.com>
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
Received: from wa-out-1112.google.com ([209.85.146.179]:55787 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759328AbYAKVtk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Jan 2008 16:49:40 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1993520wah.23
        for <linux-ide@vger.kernel.org>; Fri, 11 Jan 2008 13:49:39 -0800 (PST)
In-Reply-To: <20080111213415.56d90f0d@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

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

Can I set this option through make menuconfig, or do I need to take
some other action?  I poked around the menu config a big and wasn't
sure I found the properties you are refering to.

Would all my disks then be listed as sd[a-z] on every machine?  Or just some?

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

For now, my desired action is to overwrite the drives with random
characters.  My understanding is that security erase commands are
implemented in the firmware, and that it may be buggy.  Please correct
me if my understanding is incorrect.  Also, is there a way to invoke
the firmware security erase with a linux command?


-- 
Kristin Vadas Marsicano
kristin.marsicano@gmail.com
kristinisme.blogspot.com
