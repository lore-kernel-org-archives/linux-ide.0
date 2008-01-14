From: "Kristin Vadas Marsicano" <kristin.marsicano@gmail.com>
Subject: Re: Trouble with hdparm -d on Dell D610
Date: Mon, 14 Jan 2008 17:48:08 -0500
Message-ID: <7f68de3e0801141448n42d73d43p66f4dc31a47e9028@mail.gmail.com>
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
Received: from wa-out-1112.google.com ([209.85.146.183]:15606 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694AbYANWsK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Jan 2008 17:48:10 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3922552wah.23
        for <linux-ide@vger.kernel.org>; Mon, 14 Jan 2008 14:48:09 -0800 (PST)
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

In looking through my config file, I don't see "CONFIG_IDE_PIIX".
Below is a list of all the config entries that contain the patter
"PIIX":
CONFIG_BLK_DEV_PIIX=y
CONFIG_ATA_PIIX=y
CONFIG_PATA_MPIIX=y
CONFIG_PATA_OLDPIIX=y

Any suggestions on how I may turn of the conflicting piix support?
Perhaps set CONFIG_PATA_OLDPIIX to n?

Thank you!

-- 
Kristin Vadas Marsicano
kristin.marsicano@gmail.com
kristinisme.blogspot.com
