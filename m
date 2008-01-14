From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Trouble with hdparm -d on Dell D610
Date: Mon, 14 Jan 2008 23:14:17 +0000
Message-ID: <20080114231417.64a46284@lxorguk.ukuu.org.uk>
References: <7f68de3e0801111118x3fecace5n5c1f10b90b595d2f@mail.gmail.com>
	<20080111193036.787a9fdc@lxorguk.ukuu.org.uk>
	<7f68de3e0801111149x15afd429sf48ed7db5fff8fa1@mail.gmail.com>
	<20080111195521.7e771e45@lxorguk.ukuu.org.uk>
	<7f68de3e0801111227x50c9ff31n1435d005e6b6b1f3@mail.gmail.com>
	<20080111210557.390271a0@lxorguk.ukuu.org.uk>
	<7f68de3e0801111327m1363b681ree81fbc5f7f43848@mail.gmail.com>
	<20080111213415.56d90f0d@lxorguk.ukuu.org.uk>
	<7f68de3e0801141448n42d73d43p66f4dc31a47e9028@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45774 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753522AbYANXRA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Jan 2008 18:17:00 -0500
In-Reply-To: <7f68de3e0801141448n42d73d43p66f4dc31a47e9028@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kristin Vadas Marsicano <kristin.marsicano@gmail.com>
Cc: linux-ide@vger.kernel.org

> In looking through my config file, I don't see "CONFIG_IDE_PIIX".
> Below is a list of all the config entries that contain the patter
> "PIIX":
> CONFIG_BLK_DEV_PIIX=y
> CONFIG_ATA_PIIX=y
> CONFIG_PATA_MPIIX=y
> CONFIG_PATA_OLDPIIX=y
> 
> Any suggestions on how I may turn of the conflicting piix support?
> Perhaps set CONFIG_PATA_OLDPIIX to n?

Set CONFIG_BLK_DEV_PIIX to n
