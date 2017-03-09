From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [RESEND PATCH] arm: assabet_defconfig: disable IDE subsystem
Date: Thu, 09 Mar 2017 13:14:19 +0100
Message-ID: <1924455.PnXtBOmdyf@amdc3058>
References: <1467991490-24895-1-git-send-email-b.zolnierkie@samsung.com>
 <1821488.fi4Ak6Xj0W@amdc3058> <bca846c5-6fb8-7e60-f5c5-24772c57803b@ti.com>
 <CGME20170309121425epcas1p119ed8e5e27e3f7d8bfc71d0173cd301b@epcas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <bca846c5-6fb8-7e60-f5c5-24772c57803b@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@baylibre.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Olof Johansson <olof@lixom.net>, Tejun Heo <tj@kernel.org>
List-Id: linux-ide@vger.kernel.org

On Thursday, March 09, 2017 05:27:12 PM Sekhar Nori wrote:
> On Thursday 09 March 2017 05:17 PM, Bartlomiej Zolnierkiewicz wrote:
> > 
> > Hi Sekhar,
> > 
> > On Thursday, March 09, 2017 02:09:30 PM Sekhar Nori wrote:
> >> Hi Bartlomiej,
> >>
> >> On Wednesday 08 March 2017 08:30 PM, Sekhar Nori wrote:
> >>
> >>>> It took a while to get to it but here is the draft driver patch
> >>>> against v4.11-rc1.  Please test.
> >>>
> >>> I tested this on DM6446 EVM. I was able to mount existing partitions on 
> >>> the hard disk and see that the directory listing looks good[1]. I will do 
> >>> more tests (including comparing performance with old driver) tomorrow. I 
> >>
> >> I completed the tests I wanted to, including some read/write/data 
> >> integrity tests. Performance is same as before too.
> >>
> >> Tested-by: Sekhar Nori <nsekhar@ti.com>
> > 
> > Thanks for testing!
> > 
> >> Here are the additional changes I did. These changes do not clash with 
> > 
> > I'll split the draft patch on ATA & platform changes and make a proper
> > submission.  I'll also include your changes (can I have your Signed-by
> > for them?).
> 
> Signed-of-by: Sekhar Nori <nsekhar@ti.com>

Thanks.

> >> what I have already queued for v4.12. That said, its probably better if 
> >> I carry the platform pieces through my tree. Let me know how you want 
> >> to proceed.
> > 
> > I think that it would be the best to ask Tejun to make a separate branch
> > with a pata_bk3710 driver so it can be pulled into your tree to preserve
> > bisectability.
> 
> Sounds good. What about removal of IDE driver? Do you want to have both
> drivers existing in v4.12 and get rid of the IDE driver in v4.13 ?

Sounds good to me.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
