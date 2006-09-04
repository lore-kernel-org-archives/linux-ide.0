From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: PATA drivers queued for 2.6.19
Date: Mon, 4 Sep 2006 15:35:41 +0200 (MEST)
Message-ID: <Pine.LNX.4.61.0609041534210.17279@yvahk01.tjqt.qr>
References: <44FC0779.9030405@garzik.org> <po4of2pnhpc0325kqj2hd37b7eh3epcdsm@4ax.com>
 <Pine.LNX.4.61.0609041406140.21005@yvahk01.tjqt.qr> <20060904123546.GB23978@irc.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from emailer.gwdg.de ([134.76.10.24]:57056 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751382AbWIDNmz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Sep 2006 09:42:55 -0400
In-Reply-To: <20060904123546.GB23978@irc.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tomasz Torcz <zdzichu@irc.pl>
Cc: Grant Coady <gcoady.lk@gmail.com>, Jeff Garzik <jeff@garzik.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>


>> Got udev?
>> 
>> /dev/disk/by-id/ata-ST3802110A_5LR13RN7-partX could be your friend.
>
>  Almost. It would alternate between "ata-" and "scsi-".

Well then label your partitions and use /dev/disk/by-label/ (harhar...)

You can also try by-uuid (FS UUID) (a214ecf5-6e06-47a8-bc6d-9cd9d6f10cd6) 
or by-path (pci-0000:00:1f.1-ide-0:0-part1).


Jan Engelhardt
-- 
