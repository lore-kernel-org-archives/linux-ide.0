From: =?koi8-r?Q?=E1=CE=C4=D2=C5=CA_=E7=D5=D3=C5=D7?=
	<a.gusev1980@mail.ru>
Subject: =?koi8-r?Q?Re[2]=3A_Delay_on_intialization_ide_subsystem(most_likely)?=
Date: Tue, 28 Apr 2009 12:26:06 +0400
Message-ID: <E1Lyidi-0004IG-00.a-gusev1980-mail-ru@f138.mail.ru>
References: <200904272321.48484.bzolnier@gmail.com>
Reply-To: =?koi8-r?Q?=E1=CE=C4=D2=C5=CA_=E7=D5=D3=C5=D7?=
	  <a.gusev1980@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx45.mail.ru ([94.100.176.59]:35417 "EHLO mx45.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752900AbZD1IfS (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 28 Apr 2009 04:35:18 -0400
Received: from f138.mail.ru (f138.mail.ru [194.67.57.119])
	by mx45.mail.ru (mPOP.Fallback_MX) with ESMTP id 75C4FE005123
	for <linux-ide@vger.kernel.org>; Tue, 28 Apr 2009 12:26:39 +0400 (MSD)
In-Reply-To: <200904272321.48484.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, petkovbb@gmail.com



-----Original Message-----
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Andrey Gusev <a.gusev1980@mail.ru>
Date: Mon, 27 Apr 2009 23:21:48 +0200
Subject: Re: Delay on intialization ide subsystem(most likely)

> On Monday 27 April 2009 22:36:45 Andrey Gusev wrote:
> > On Sat, 25 Apr 2009 16:48:38 +0200
> > Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > 
> > > 
> > > Hi,
> > > 
> > > On Saturday 25 April 2009 15:02:03 Andrey Gusev wrote:
> > > > Hello!
> > > > 
> > > > I have tested linux-2.6.30-rc3 on my system and find some problems.
> > > > One of them is delaying on initialization IDE subsystem. I don't
> > > > have this problem on 2.6.29.1. The difference is looked on log of
> > > > dmesg.
> > > 
> > > Unfortunately this doesn't give us any hint about the root cause of
> > > the bug so please try narrowing the problem down to the specific
> > > change using git-bisect (sorry, there were 212 drivers/ide/ commits
> > > during v2.6.29..v2.6.30-rc3 and much much more non-drivers/ide/ ones).
> > > 
> > > Thanks,
> > > Bart
> > > 
> > 
> > Hello!
> > 
> > 
> > The full result of bisect is:
> > 
> > 
> > git bisect start
> > # good: [8e0ee43bc2c3e19db56a4adaa9a9b04ce885cd84] Linux 2.6.29
> > git bisect good 8e0ee43bc2c3e19db56a4adaa9a9b04ce885cd84
> > # bad: [091069740304c979f957ceacec39c461d0192158] Linux 2.6.30-rc3
> > git bisect bad 091069740304c979f957ceacec39c461d0192158
> > # good: [40f07111be99b71c1e8d40c13cdc38445add787f] V4L/DVB (11166): pvrusb2: Implement status fetching from sub-devices
> > git bisect good 40f07111be99b71c1e8d40c13cdc38445add787f
> > # good: [ba0e1ebb7ea0616eebc29d2077355bacea62a9d8] Staging: sxg: slicoss: Specify the license for Sahara SXG and Slicoss drivers
> > git bisect good ba0e1ebb7ea0616eebc29d2077355bacea62a9d8
> > 
> > 
> > git bisect start 'drivers/ide/'
> 
> Please note that limiting search space to drivers/ide/ may not give reliable
> results in case problem was introduced by some other kernel area.

I agree, but most likely it is ide related. I want to build kernel in point previous this commit. I am not very familiar with git, try to do it today.

> 
> > # good: [ba0e1ebb7ea0616eebc29d2077355bacea62a9d8] Staging: sxg: slicoss: Specify the license for Sahara SXG and Slicoss drivers
> > git bisect good ba0e1ebb7ea0616eebc29d2077355bacea62a9d8
> > # bad: [091069740304c979f957ceacec39c461d0192158] Linux 2.6.30-rc3
> > git bisect bad 091069740304c979f957ceacec39c461d0192158
> > # good: [e01f251fd09fa7cb3d352eac7de17bb5d5bd1f9d] ide-cd: convert cdrom_decode_status() to use switch statements
> > git bisect good e01f251fd09fa7cb3d352eac7de17bb5d5bd1f9d
> > # good: [3153c26b54230d025c6d536e8d3015def4524906] ide: refactor tf_read() method
> > git bisect good 3153c26b54230d025c6d536e8d3015def4524906
> > # good: [c018f1ee5cf81e58b93d9e93a2ee39cad13dc1ac] hpt366: fix HPT370 DMA timeouts
> > git bisect good c018f1ee5cf81e58b93d9e93a2ee39cad13dc1ac
> > # bad: [d5f840bf74c09ca5a31e518c9d984999926b5f44] ide: Remove void casts
> > git bisect bad d5f840bf74c09ca5a31e518c9d984999926b5f44
> > # bad: [59c8d04f5ee97ea46da854e9adbbaa45d988c39d] hpt366: use ATA_DMA_* constants
> > git bisect bad 59c8d04f5ee97ea46da854e9adbbaa45d988c39d
> 
> Uhh.. something went wrong during bisect.
> 
> "hpt366: use ATA_DMA_* constants" cannot be a first bad commit because hpt366
> is not even used on this system.

I saw it and didn't understand, how this commit can take effect

> 
> Could it be that the delay doesn't happen on every boot for "bad" kernels?

It was on all boots for "bad" kernels. 

> 
> Also, is 2.6.30-rc1 okay?

I did "make deb-pkg" and packages 2.6.30-rc1 was ok.

> 
> Thanks,
> Bart
> 

