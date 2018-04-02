From: Tejun Heo <tj@kernel.org>
Subject: Re: 4.16-rc2+git: pata_serverworks: hanging ata detection thread on
 HP DL380G3
Date: Mon, 2 Apr 2018 09:24:25 -0700
Message-ID: <20180402162425.GB388343@devbig577.frc2.facebook.com>
References: <alpine.LRH.2.21.1802261049140.4893@math.ut.ee>
 <alpine.LRH.2.21.1803291153070.12825@math.ut.ee>
 <CGME20180329101255epcas2p22aeb95d869cdd2954bb9183037dace5f@epcas2p2.samsung.com>
 <1597679.yzYZqmDdA5@amdc3058>
 <alpine.LRH.2.21.1803301144380.11026@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.1803301144380.11026@math.ut.ee>
Sender: linux-kernel-owner@vger.kernel.org
To: Meelis Roos <mroos@linux.ee>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, linux-block@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello,

On Fri, Mar 30, 2018 at 11:47:24AM +0300, Meelis Roos wrote:
> Added CC-s, start of the thread is at 
> https://lkml.org/lkml/2018/2/26/165
> 
> > > > 4.16 git bootup on HP Proliant DL380 G3 pauses for a a minute or two and 
> > > > then continues with "blocked for more than 120 seconds" message with 
> > > > libata detection functions in ther stack - 
> > > > async_synchronize_cookie_domain() as the last. It seems to happen during 
> > > > IDE CD-ROM detection (detected before but registered as sr0 after the 
> > > > warning). After detection, the eject button on the drive did not work.
> > > > 
> > > > 
> > > > pata_serverworks is the libata driver in use.
> > 
> > There were no changes to pata_serverworks since 2014 and libata changes
> > in v4.16 look obviously correct..
> > 
> > > This is still the same in 4.16.0-rc7-00062-g0b412605ef5f.
> > 
> > Any chance that you could bisect this issue?
> 
> Bisected to the following commit:
> 
> 358f70da49d77c43f2ca11b5da584213b2add29c is the first bad commit
> commit 358f70da49d77c43f2ca11b5da584213b2add29c
> Author: Tejun Heo <tj@kernel.org>
> Date:   Tue Jan 9 08:29:50 2018 -0800
> 
>     blk-mq: make blk_abort_request() trigger timeout path

Can you share the .config file?

Thanks.

-- 
tejun
