From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [RESEND PATCH] arm: assabet_defconfig: disable IDE subsystem
Date: Thu, 09 Mar 2017 12:47:53 +0100
Message-ID: <1821488.fi4Ak6Xj0W@amdc3058>
References: <1467991490-24895-1-git-send-email-b.zolnierkie@samsung.com>
 <1fd840c5-b0bb-726b-6357-669977c4ae5f@ti.com>
 <a3161cfc-56f7-4577-c37f-3798cdb03713@ti.com>
 <CGME20170309114756epcas5p3761bce85d5a8e3a095cb3a876c484ea6@epcas5p3.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:45927 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932065AbdCILsA (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 9 Mar 2017 06:48:00 -0500
In-reply-to: <a3161cfc-56f7-4577-c37f-3798cdb03713@ti.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@baylibre.com>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Olof Johansson <olof@lixom.net>, Tejun Heo <tj@kernel.org>


Hi Sekhar,

On Thursday, March 09, 2017 02:09:30 PM Sekhar Nori wrote:
> Hi Bartlomiej,
> 
> On Wednesday 08 March 2017 08:30 PM, Sekhar Nori wrote:
> 
> >> It took a while to get to it but here is the draft driver patch
> >> against v4.11-rc1.  Please test.
> > 
> > I tested this on DM6446 EVM. I was able to mount existing partitions on 
> > the hard disk and see that the directory listing looks good[1]. I will do 
> > more tests (including comparing performance with old driver) tomorrow. I 
> 
> I completed the tests I wanted to, including some read/write/data 
> integrity tests. Performance is same as before too.
> 
> Tested-by: Sekhar Nori <nsekhar@ti.com>

Thanks for testing!

> Here are the additional changes I did. These changes do not clash with 

I'll split the draft patch on ATA & platform changes and make a proper
submission.  I'll also include your changes (can I have your Signed-by
for them?).

> what I have already queued for v4.12. That said, its probably better if 
> I carry the platform pieces through my tree. Let me know how you want 
> to proceed.

I think that it would be the best to ask Tejun to make a separate branch
with a pata_bk3710 driver so it can be pulled into your tree to preserve
bisectability.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

