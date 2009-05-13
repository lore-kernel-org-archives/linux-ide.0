From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Delay on intialization ide subsystem(most likely)
Date: Wed, 13 May 2009 15:28:26 +0200
Message-ID: <200905131528.26940.bzolnier@gmail.com>
References: <20090425170203.74603b9c@power-debian> <200904272321.48484.bzolnier@gmail.com> <20090512235024.5c068423@power-debian>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f222.google.com ([209.85.218.222]:46268 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945AbZEMN2w (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 May 2009 09:28:52 -0400
Received: by bwz22 with SMTP id 22so644824bwz.37
        for <linux-ide@vger.kernel.org>; Wed, 13 May 2009 06:28:52 -0700 (PDT)
In-Reply-To: <20090512235024.5c068423@power-debian>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrey Gusev <a.gusev1980@mail.ru>
Cc: linux-ide@vger.kernel.org, petkovbb@gmail.com

On Tuesday 12 May 2009 21:50:24 Andrey Gusev wrote:
> On Mon, 27 Apr 2009 23:21:48 +0200
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
> > On Monday 27 April 2009 22:36:45 Andrey Gusev wrote:
> > > On Sat, 25 Apr 2009 16:48:38 +0200
> > > Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > > 
> > > > 
> > > > Hi,
> > > > 
> > > > On Saturday 25 April 2009 15:02:03 Andrey Gusev wrote:
> > > > > Hello!
> > > > > 
> > > > > I have tested linux-2.6.30-rc3 on my system and find some
> > > > > problems. One of them is delaying on initialization IDE
> > > > > subsystem. I don't have this problem on 2.6.29.1. The
> > > > > difference is looked on log of dmesg.
> > > > 
> > > > Unfortunately this doesn't give us any hint about the root cause
> > > > of the bug so please try narrowing the problem down to the
> > > > specific change using git-bisect (sorry, there were 212
> > > > drivers/ide/ commits during v2.6.29..v2.6.30-rc3 and much much
> > > > more non-drivers/ide/ ones).
> > > > 
> > > > Thanks,
> > > > Bart
> > > > 
> > > 
> > > Hello!
> > > 
> > > 
> > > The full result of bisect is:
> > > 
> > > 
> > > git bisect start
> > > # good: [8e0ee43bc2c3e19db56a4adaa9a9b04ce885cd84] Linux 2.6.29
> > > git bisect good 8e0ee43bc2c3e19db56a4adaa9a9b04ce885cd84
> > > # bad: [091069740304c979f957ceacec39c461d0192158] Linux 2.6.30-rc3
> > > git bisect bad 091069740304c979f957ceacec39c461d0192158
> > > # good: [40f07111be99b71c1e8d40c13cdc38445add787f] V4L/DVB (11166):
> > > pvrusb2: Implement status fetching from sub-devices git bisect good
> > > 40f07111be99b71c1e8d40c13cdc38445add787f # good:
> > > [ba0e1ebb7ea0616eebc29d2077355bacea62a9d8] Staging: sxg: slicoss:
> > > Specify the license for Sahara SXG and Slicoss drivers git bisect
> > > good ba0e1ebb7ea0616eebc29d2077355bacea62a9d8
> > > 
> > > 
> > > git bisect start 'drivers/ide/'
> > 
> > Please note that limiting search space to drivers/ide/ may not give
> > reliable results in case problem was introduced by some other kernel
> > area.
> > 
> > > # good: [ba0e1ebb7ea0616eebc29d2077355bacea62a9d8] Staging: sxg:
> > > slicoss: Specify the license for Sahara SXG and Slicoss drivers git
> > > bisect good ba0e1ebb7ea0616eebc29d2077355bacea62a9d8 # bad:
> > > [091069740304c979f957ceacec39c461d0192158] Linux 2.6.30-rc3 git
> > > bisect bad 091069740304c979f957ceacec39c461d0192158 # good:
> > > [e01f251fd09fa7cb3d352eac7de17bb5d5bd1f9d] ide-cd: convert
> > > cdrom_decode_status() to use switch statements git bisect good
> > > e01f251fd09fa7cb3d352eac7de17bb5d5bd1f9d # good:
> > > [3153c26b54230d025c6d536e8d3015def4524906] ide: refactor tf_read()
> > > method git bisect good 3153c26b54230d025c6d536e8d3015def4524906 #
> > > good: [c018f1ee5cf81e58b93d9e93a2ee39cad13dc1ac] hpt366: fix HPT370
> > > DMA timeouts git bisect good
> > > c018f1ee5cf81e58b93d9e93a2ee39cad13dc1ac # bad:
> > > [d5f840bf74c09ca5a31e518c9d984999926b5f44] ide: Remove void casts
> > > git bisect bad d5f840bf74c09ca5a31e518c9d984999926b5f44 # bad:
> > > [59c8d04f5ee97ea46da854e9adbbaa45d988c39d] hpt366: use ATA_DMA_*
> > > constants git bisect bad 59c8d04f5ee97ea46da854e9adbbaa45d988c39d
> > 
> > Uhh.. something went wrong during bisect.
> > 
> > "hpt366: use ATA_DMA_* constants" cannot be a first bad commit
> > because hpt366 is not even used on this system.
> > 
> > Could it be that the delay doesn't happen on every boot for "bad"
> > kernels?
> > 
> > Also, is 2.6.30-rc1 okay?
> > 
> > Thanks,
> > Bart
> > 
> 
> Hello all!
> 
> I continue to find reason of bug. I made more testing with bisect and
> got result:
> 
> git bisect start
> # bad: [c018f1ee5cf81e58b93d9e93a2ee39cad13dc1ac] hpt366: fix HPT370 DMA timeouts
> git bisect bad c018f1ee5cf81e58b93d9e93a2ee39cad13dc1ac
> # good: [fb4252e59452c18b88af014a2c4ee697bbf8cbc6] at91_ide: turn on PIO 6 support
> git bisect good fb4252e59452c18b88af014a2c4ee697bbf8cbc6
> # good: [2e1c63b7ed36532b68f0eddd6a184d7ba1013b89] Merge branch 'for-rc1/xen/core' of git://git.kernel.org/pub/scm/linux/kernel/git/jeremy/xen
> git bisect good 2e1c63b7ed36532b68f0eddd6a184d7ba1013b89
> # bad: [cd97824994042b809493807ea644ba26c0c23290] Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-2.6
> git bisect bad cd97824994042b809493807ea644ba26c0c23290
> # bad: [a2c252ebdeaab28c9b400570594d576dae295958] Merge git://git.kernel.org/pub/scm/linux/kernel/git/steve/gfs2-2.6-fixes
> git bisect bad a2c252ebdeaab28c9b400570594d576dae295958
> # good: [b897e6fbc49dd84b2634bca664344d503b907ce9] Merge branch 'drm-intel-next' of git://git.kernel.org/pub/scm/linux/kernel/git/anholt/drm-intel
> git bisect good b897e6fbc49dd84b2634bca664344d503b907ce9
> # good: [dfbc4752eab33e66f113f9daa2effbe241cd661d] brd: support barriers
> git bisect good dfbc4752eab33e66f113f9daa2effbe241cd661d
> # good: [a23c218bd36e11120daf18e00a91d5dc20e288e6] Merge branch 'merge' of git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc
> git bisect good a23c218bd36e11120daf18e00a91d5dc20e288e6
> # good: [23da64b4714812b66ecf010e7dfb3ed1bf2eda69] Merge branch 'for-linus' of git://git.kernel.dk/linux-2.6-block
> git bisect good 23da64b4714812b66ecf010e7dfb3ed1bf2eda69
> # good: [a228df6339e0d385b8149c860d81b6007f5e9c81] GFS2: Move umount flush rwsem
> git bisect good a228df6339e0d385b8149c860d81b6007f5e9c81
> # skip: [1328df725239804ae30fc7257c1a3185e679b517] GFS2: Use DEFINE_SPINLOCK
> git bisect skip 1328df725239804ae30fc7257c1a3185e679b517
> # good: [10d2198805d7faa2b193485446ff6b1de42c9b78] GFS2: cleanup file_operations mess
> git bisect good 10d2198805d7faa2b193485446ff6b1de42c9b78
> 
> As I understand, I found bad commit, but it includes 5 commits. I checked them and 
> they are good. So, I did git checkout a2c252ebdeaab28c9b400570594d576dae295958 and test
> one more time this commit. I found that bag is unstable. The boot can be bad or good 
> on this commit. I compared dmesg of 'bad' and 'good' booting, but it is equal till delay. 

Thanks for doing it.

> Any suggestions?

Hard to tell...

I went through all commits in-between

	fb4252e59452c18b88af014a2c4ee697bbf8cbc6

and

	a2c252ebdeaab28c9b400570594d576dae295958

and there are no obvious candidates..

Could you please refresh my memory and tell me whether 2.6.30-rc2 was OK?
