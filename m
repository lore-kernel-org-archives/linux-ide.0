From: Kanniball <kanniball@zmail.pt>
Subject: Re: SiI 3112 & Seagate drivers
Date: Mon, 14 Mar 2005 14:01:26 +0000
Message-ID: <200503141401.27269.kanniball@zmail.pt>
References: <200503121937.55673.kanniball@zmail.pt> <200503131834.46433.kanniball@zmail.pt> <423557A9.9090708@gmail.com>
Reply-To: kanniball@zmail.pt
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from [81.92.212.1] ([81.92.212.1]:49421 "EHLO zmail.pt")
	by vger.kernel.org with ESMTP id S261492AbVCNNeG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Mar 2005 08:34:06 -0500
Received: from 80.172.45.21
	by zmail.pt
	(Cipher SSLv3:RC4-MD5:128) (MDaemon.PRO.v6.8.4.R)
	with ESMTP id 35-md50000000001.tmp
	for <linux-ide@vger.kernel.org>; Mon, 14 Mar 2005 13:31:53 +0000
In-Reply-To: <423557A9.9090708@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com
Cc: linux-ide@vger.kernel.org

Thanks for your replay.
I've sent one email to my board manufacter, because my sata controller is part 
of my MB, and in the SI site they say that don't provide support for that 
class of products.
Because I already know their answer (oh linux... we don't provide support for 
this, please ask your disto vendor ) I'm figuring out other possibilites, 
like buy a new sata controller without any SI chip, another board, or maybe 
one upgrade if I can sell my actual hardware.
Now I've added Silicon Image and Seagate to my black list... (that's a great 
idea for a site, have a blacklist of hardware vendors)
I've found this site with some unofficial bios updates:
http://homepage.ntlworld.com/michael.mcclay/
wich includes updates on Sil 3112 sata controller.
So one good point was to have access to firmware's changelog (sata 
controller).

Thanks and I'll keep you informed of the board's answer.
Regards,
Paulo Fidalgo

On Monday 14 March 2005 09:21, Tejun Heo wrote:
> Kanniball wrote:
> > Well let's see if we can get the tecnical info...
> > This is a very annoying problem... so please "devs" give us the info we
> > need, and we'll try to do your best
>
>   Hello, Kanniball.
>
>   I've digged lkml previously and what I've found out are
>
>   * It's basically because of faulty SATA implementation of the affected
> seagate hard drives combined with standard-compliant but peculiar
> behavior of silicon image controllers.
>
>   SATA communicates using packets which is called FIS in SATA
> terminology.  When transferring data for read/write, the data can be
> tranferred splitted on multiple packets.  The standard doesn't limit
> where the data can be splitted, but most controllers split them on block
>   (512 byte) boundaries.  Unfortunately, siimage controller doesn't
> always split them on block boundaries and some (well, many) seagate
> drives depend on packets split on block boundary.  So, that's where
> everything goes wrong.
>
>   * Data FIS maximum payload size is 8k, or 16 blocks.  And siimage
> controllers doesn't split packets on odd boundaries (maybe not at all)
> when data size is equal to or less than 15 blocks.  So, sata_sil driver
> sets max_sectors to 15, and the drive never gets to transfer more than
> one page at a time.  So, it's dog slow.
>
>   * As the problem occurs only when writing data, we can improve read
> performance to normal level, but the current block/libata driver
> structure isn't structured to support separate limits on reads/writes
> and the developers don't wanna change it because of some faulty hardware.
>
>   * I don't know how Windows drivers handle this but from the past
> posts, it seems that Windows driver also has the blacklist.  It would be
> nice if someone can verify siimage+seagate read/write performance on
> Windows.  And it would be even better if someone with SATA tracer would
> investigate how the gruesome-twosome act on Windows.
>
>   * The cleanest way would be some form of firmware updates for either
> the siimage controller or seagate drives.  Unfortunately, this doesn't
> seem to be feasible; otherwise, they would have come up with it way back.
>
>   * To top it all, both companies keep details regarding above buggy
> behavior under strict NDA and continue to sell faulty devices.  Way to
> go, Silicon images / Seagate. OTZ
>
>   * It seems that IDE/libata developers contacted both companies in the
> past without any positive result, so I doubt they will act any
> differently this time.  But, my heart, too, is with you.
>
>   Thanks.

-- 
Jabber ID: kanniball@jabber80.com

