From: Andrey Gusev <a.gusev1980@mail.ru>
Subject: Re: Delay on intialization ide subsystem(most likely)
Date: Thu, 30 Apr 2009 01:05:09 +0400
Message-ID: <20090430010509.6a353d7f@power-debian>
References: <20090425170203.74603b9c@power-debian>
	<200904251648.38389.bzolnier@gmail.com>
	<20090428003645.12001d30@power-debian>
	<200904272321.48484.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx38.mail.ru ([94.100.176.52]:57749 "EHLO mx38.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751929AbZD2VF0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 29 Apr 2009 17:05:26 -0400
In-Reply-To: <200904272321.48484.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, petkovbb@gmail.com

On Mon, 27 Apr 2009 23:21:48 +0200
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

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
> > > > I have tested linux-2.6.30-rc3 on my system and find some
> > > > problems. One of them is delaying on initialization IDE
> > > > subsystem. I don't have this problem on 2.6.29.1. The
> > > > difference is looked on log of dmesg.
> > > 
> > > Unfortunately this doesn't give us any hint about the root cause
> > > of the bug so please try narrowing the problem down to the
> > > specific change using git-bisect (sorry, there were 212
> > > drivers/ide/ commits during v2.6.29..v2.6.30-rc3 and much much
> > > more non-drivers/ide/ ones).
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
> > # good: [40f07111be99b71c1e8d40c13cdc38445add787f] V4L/DVB (11166):
> > pvrusb2: Implement status fetching from sub-devices git bisect good
> > 40f07111be99b71c1e8d40c13cdc38445add787f # good:
> > [ba0e1ebb7ea0616eebc29d2077355bacea62a9d8] Staging: sxg: slicoss:
> > Specify the license for Sahara SXG and Slicoss drivers git bisect
> > good ba0e1ebb7ea0616eebc29d2077355bacea62a9d8
> > 
> > 
> > git bisect start 'drivers/ide/'
> 
> Please note that limiting search space to drivers/ide/ may not give
> reliable results in case problem was introduced by some other kernel
> area.
> 
> > # good: [ba0e1ebb7ea0616eebc29d2077355bacea62a9d8] Staging: sxg:
> > slicoss: Specify the license for Sahara SXG and Slicoss drivers git
> > bisect good ba0e1ebb7ea0616eebc29d2077355bacea62a9d8 # bad:
> > [091069740304c979f957ceacec39c461d0192158] Linux 2.6.30-rc3 git
> > bisect bad 091069740304c979f957ceacec39c461d0192158 # good:
> > [e01f251fd09fa7cb3d352eac7de17bb5d5bd1f9d] ide-cd: convert
> > cdrom_decode_status() to use switch statements git bisect good
> > e01f251fd09fa7cb3d352eac7de17bb5d5bd1f9d # good:
> > [3153c26b54230d025c6d536e8d3015def4524906] ide: refactor tf_read()
> > method git bisect good 3153c26b54230d025c6d536e8d3015def4524906 #
> > good: [c018f1ee5cf81e58b93d9e93a2ee39cad13dc1ac] hpt366: fix HPT370
> > DMA timeouts git bisect good
> > c018f1ee5cf81e58b93d9e93a2ee39cad13dc1ac # bad:
> > [d5f840bf74c09ca5a31e518c9d984999926b5f44] ide: Remove void casts
> > git bisect bad d5f840bf74c09ca5a31e518c9d984999926b5f44 # bad:
> > [59c8d04f5ee97ea46da854e9adbbaa45d988c39d] hpt366: use ATA_DMA_*
> > constants git bisect bad 59c8d04f5ee97ea46da854e9adbbaa45d988c39d
> 
> Uhh.. something went wrong during bisect.
> 
> "hpt366: use ATA_DMA_* constants" cannot be a first bad commit
> because hpt366 is not even used on this system.
> 
> Could it be that the delay doesn't happen on every boot for "bad"
> kernels?
> 
> Also, is 2.6.30-rc1 okay?
> 
> Thanks,
> Bart
> 

I made rechecks of last commits and have different result. I think, I did something wrong last time or bug is unstable.
New log of bisect:

andrey@power-debian:~/build/kernel/git$ cat bisect3.log 
git bisect start 'drivers/ide/'
# good: [ba0e1ebb7ea0616eebc29d2077355bacea62a9d8] Staging: sxg: slicoss: Specify the license for Sahara SXG and Slicoss drivers
git bisect good ba0e1ebb7ea0616eebc29d2077355bacea62a9d8
# bad: [091069740304c979f957ceacec39c461d0192158] Linux 2.6.30-rc3
git bisect bad 091069740304c979f957ceacec39c461d0192158
# good: [e01f251fd09fa7cb3d352eac7de17bb5d5bd1f9d] ide-cd: convert cdrom_decode_status() to use switch statements
git bisect good e01f251fd09fa7cb3d352eac7de17bb5d5bd1f9d
# good: [3153c26b54230d025c6d536e8d3015def4524906] ide: refactor tf_read() method
git bisect good 3153c26b54230d025c6d536e8d3015def4524906
# bad: [c018f1ee5cf81e58b93d9e93a2ee39cad13dc1ac] hpt366: fix HPT370 DMA timeouts
git bisect bad c018f1ee5cf81e58b93d9e93a2ee39cad13dc1ac
# good: [55c590b64e70cb9922ff56703578ec271eaaca02] at91_ide: remove unused ide_mm_{outb,inb}
git bisect good 55c590b64e70cb9922ff56703578ec271eaaca02
# good: [fb4252e59452c18b88af014a2c4ee697bbf8cbc6] at91_ide: turn on PIO 6 support
git bisect good fb4252e59452c18b88af014a2c4ee697bbf8cbc6

According it, bad commit is c018f1ee5cf81e58b93d9e93a2ee39cad13dc1ac, but
 driver related to it not enabled in config and this commit is in 2.6.29.2.
2.6.29.2 is ok. There is a long distance between last good and bad kernel. Need 
to search bad commit between them in other parts of code. Some my notes:
1) I can't repeat good and bad behavioral on one kernel . 
2) I can't reproduce bug on 2.6.30-rc1.
3) I got stack trace for reiserfs on first bad kernel. May be is it same bug?

I will have a week trip, hope to find it before.

Thanks,
Andrey
