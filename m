From: David Richards <david@industrialstrengthsolutions.com>
Subject: Re: SiI 3112 & Seagate drivers
Date: Mon, 14 Mar 2005 10:14:01 -0500
Message-ID: <4235AA39.7010704@industrialstrengthsolutions.com>
References: <200503121937.55673.kanniball@zmail.pt> <42345E2A.3070707@industrialstrengthsolutions.com> <200503131834.46433.kanniball@zmail.pt> <423557A9.9090708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Received: from lakermmtao08.cox.net ([68.230.240.31]:42957 "EHLO
	lakermmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261522AbVCNPCF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 14 Mar 2005 10:02:05 -0500
In-Reply-To: <423557A9.9090708@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Ben Schwartz <yem@mail.utexas.edu>, linux-ide@vger.kernel.org

Thank you much for breaking this down so well.

>
>  Hello, Kanniball.
>
>  I've digged lkml previously and what I've found out are
>
>  * It's basically because of faulty SATA implementation of the 
> affected seagate hard drives combined with standard-compliant but 
> peculiar behavior of silicon image controllers.
>
>  SATA communicates using packets which is called FIS in SATA 
> terminology.  When transferring data for read/write, the data can be 
> tranferred splitted on multiple packets.  The standard doesn't limit 
> where the data can be splitted, but most controllers split them on 
> block  (512 byte) boundaries.  Unfortunately, siimage controller 
> doesn't always split them on block boundaries and some (well, many) 
> seagate drives depend on packets split on block boundary.  So, that's 
> where everything goes wrong.
>
>  * Data FIS maximum payload size is 8k, or 16 blocks.  And siimage 
> controllers doesn't split packets on odd boundaries (maybe not at all) 
> when data size is equal to or less than 15 blocks.  So, sata_sil 
> driver sets max_sectors to 15, and the drive never gets to transfer 
> more than one page at a time.  So, it's dog slow.
>
>  * As the problem occurs only when writing data, we can improve read 
> performance to normal level, but the current block/libata driver 
> structure isn't structured to support separate limits on reads/writes 
> and the developers don't wanna change it because of some faulty hardware.
>
>  * I don't know how Windows drivers handle this but from the past 
> posts, it seems that Windows driver also has the blacklist.  It would 
> be nice if someone can verify siimage+seagate read/write performance 
> on Windows.  And it would be even better if someone with SATA tracer 
> would investigate how the gruesome-twosome act on Windows.
>
>  * The cleanest way would be some form of firmware updates for either 
> the siimage controller or seagate drives.  Unfortunately, this doesn't 
> seem to be feasible; otherwise, they would have come up with it way back.
>
>  * To top it all, both companies keep details regarding above buggy 
> behavior under strict NDA and continue to sell faulty devices.  Way to 
> go, Silicon images / Seagate. OTZ
>
>  * It seems that IDE/libata developers contacted both companies in the 
> past without any positive result, so I doubt they will act any 
> differently this time.  But, my heart, too, is with you.
>
>  Thanks.
>

