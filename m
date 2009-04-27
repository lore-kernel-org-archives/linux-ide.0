From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Delay on intialization ide subsystem(most likely)
Date: Mon, 27 Apr 2009 23:21:48 +0200
Message-ID: <200904272321.48484.bzolnier@gmail.com>
References: <20090425170203.74603b9c@power-debian> <200904251648.38389.bzolnier@gmail.com> <20090428003645.12001d30@power-debian>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f163.google.com ([209.85.218.163]:34025 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754793AbZD0VR1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 Apr 2009 17:17:27 -0400
Received: by bwz7 with SMTP id 7so172192bwz.37
        for <linux-ide@vger.kernel.org>; Mon, 27 Apr 2009 14:17:26 -0700 (PDT)
In-Reply-To: <20090428003645.12001d30@power-debian>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrey Gusev <a.gusev1980@mail.ru>
Cc: linux-ide@vger.kernel.org, petkovbb@gmail.com

On Monday 27 April 2009 22:36:45 Andrey Gusev wrote:
> On Sat, 25 Apr 2009 16:48:38 +0200
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
> > 
> > Hi,
> > 
> > On Saturday 25 April 2009 15:02:03 Andrey Gusev wrote:
> > > Hello!
> > > 
> > > I have tested linux-2.6.30-rc3 on my system and find some problems.
> > > One of them is delaying on initialization IDE subsystem. I don't
> > > have this problem on 2.6.29.1. The difference is looked on log of
> > > dmesg.
> > 
> > Unfortunately this doesn't give us any hint about the root cause of
> > the bug so please try narrowing the problem down to the specific
> > change using git-bisect (sorry, there were 212 drivers/ide/ commits
> > during v2.6.29..v2.6.30-rc3 and much much more non-drivers/ide/ ones).
> > 
> > Thanks,
> > Bart
> > 
> 
> Hello!
> 
> 
> The full result of bisect is:
> 
> 
> git bisect start
> # good: [8e0ee43bc2c3e19db56a4adaa9a9b04ce885cd84] Linux 2.6.29
> git bisect good 8e0ee43bc2c3e19db56a4adaa9a9b04ce885cd84
> # bad: [091069740304c979f957ceacec39c461d0192158] Linux 2.6.30-rc3
> git bisect bad 091069740304c979f957ceacec39c461d0192158
> # good: [40f07111be99b71c1e8d40c13cdc38445add787f] V4L/DVB (11166): pvrusb2: Implement status fetching from sub-devices
> git bisect good 40f07111be99b71c1e8d40c13cdc38445add787f
> # good: [ba0e1ebb7ea0616eebc29d2077355bacea62a9d8] Staging: sxg: slicoss: Specify the license for Sahara SXG and Slicoss drivers
> git bisect good ba0e1ebb7ea0616eebc29d2077355bacea62a9d8
> 
> 
> git bisect start 'drivers/ide/'

Please note that limiting search space to drivers/ide/ may not give reliable
results in case problem was introduced by some other kernel area.

> # good: [ba0e1ebb7ea0616eebc29d2077355bacea62a9d8] Staging: sxg: slicoss: Specify the license for Sahara SXG and Slicoss drivers
> git bisect good ba0e1ebb7ea0616eebc29d2077355bacea62a9d8
> # bad: [091069740304c979f957ceacec39c461d0192158] Linux 2.6.30-rc3
> git bisect bad 091069740304c979f957ceacec39c461d0192158
> # good: [e01f251fd09fa7cb3d352eac7de17bb5d5bd1f9d] ide-cd: convert cdrom_decode_status() to use switch statements
> git bisect good e01f251fd09fa7cb3d352eac7de17bb5d5bd1f9d
> # good: [3153c26b54230d025c6d536e8d3015def4524906] ide: refactor tf_read() method
> git bisect good 3153c26b54230d025c6d536e8d3015def4524906
> # good: [c018f1ee5cf81e58b93d9e93a2ee39cad13dc1ac] hpt366: fix HPT370 DMA timeouts
> git bisect good c018f1ee5cf81e58b93d9e93a2ee39cad13dc1ac
> # bad: [d5f840bf74c09ca5a31e518c9d984999926b5f44] ide: Remove void casts
> git bisect bad d5f840bf74c09ca5a31e518c9d984999926b5f44
> # bad: [59c8d04f5ee97ea46da854e9adbbaa45d988c39d] hpt366: use ATA_DMA_* constants
> git bisect bad 59c8d04f5ee97ea46da854e9adbbaa45d988c39d

Uhh.. something went wrong during bisect.

"hpt366: use ATA_DMA_* constants" cannot be a first bad commit because hpt366
is not even used on this system.

Could it be that the delay doesn't happen on every boot for "bad" kernels?

Also, is 2.6.30-rc1 okay?

Thanks,
Bart
