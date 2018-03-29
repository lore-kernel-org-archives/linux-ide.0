From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: 4.16-rc2+git: pata_serverworks: hanging ata detection thread on
 HP DL380G3
Date: Thu, 29 Mar 2018 12:12:52 +0200
Message-ID: <1597679.yzYZqmDdA5@amdc3058>
References: <alpine.LRH.2.21.1802261049140.4893@math.ut.ee>
        <alpine.LRH.2.21.1803291153070.12825@math.ut.ee>
        <CGME20180329101255epcas2p22aeb95d869cdd2954bb9183037dace5f@epcas2p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <alpine.LRH.2.21.1803291153070.12825@math.ut.ee>
Sender: linux-kernel-owner@vger.kernel.org
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Hi,

On Thursday, March 29, 2018 11:54:09 AM Meelis Roos wrote:
> > 4.16 git bootup on HP Proliant DL380 G3 pauses for a a minute or two and 
> > then continues with "blocked for more than 120 seconds" message with 
> > libata detection functions in ther stack - 
> > async_synchronize_cookie_domain() as the last. It seems to happen during 
> > IDE CD-ROM detection (detected before but registered as sr0 after the 
> > warning). After detection, the eject button on the drive did not work.
> > 
> > 
> > pata_serverworks is the libata driver in use.

There were no changes to pata_serverworks since 2014 and libata changes
in v4.16 look obviously correct..

> This is still the same in 4.16.0-rc7-00062-g0b412605ef5f.

Any chance that you could bisect this issue?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
