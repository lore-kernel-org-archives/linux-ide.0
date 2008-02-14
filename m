From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 00/11] ide/ppc: remove PPC specific IDE hacks
Date: Thu, 14 Feb 2008 01:36:21 +0100
Message-ID: <20080214003621.12879.33868.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:64981 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764890AbYBNAV4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Feb 2008 19:21:56 -0500
Received: by nf-out-0910.google.com with SMTP id g13so128999nfb.21
        for <linux-ide@vger.kernel.org>; Wed, 13 Feb 2008 16:21:54 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-kernel@vger.kernel.org


Previous patchset adding warm-plug support allows the removal of PPC specific
IDE hacks (500 LOC gone)...

[ Ben, please take a look when you have some time, thanks! ]

diffstat:

 arch/powerpc/kernel/setup_32.c          |    8 --
 arch/powerpc/platforms/powermac/pci.c   |   22 -------
 arch/powerpc/platforms/powermac/pmac.h  |    5 -
 arch/powerpc/platforms/powermac/setup.c |    8 --
 arch/ppc/configs/sandpoint_defconfig    |    2 
 arch/ppc/kernel/ppc_ksyms.c             |    5 -
 arch/ppc/kernel/setup.c                 |    2 
 arch/ppc/platforms/4xx/bamboo.c         |    1 
 arch/ppc/platforms/4xx/ebony.c          |    1 
 arch/ppc/platforms/4xx/luan.c           |    1 
 arch/ppc/platforms/4xx/ocotea.c         |    1 
 arch/ppc/platforms/4xx/taishan.c        |    1 
 arch/ppc/platforms/4xx/yucca.c          |    1 
 arch/ppc/platforms/chestnut.c           |    1 
 arch/ppc/platforms/cpci690.c            |    1 
 arch/ppc/platforms/ev64260.c            |    1 
 arch/ppc/platforms/hdpu.c               |   36 -----------
 arch/ppc/platforms/lopec.c              |   85 ----------------------------
 arch/ppc/platforms/mvme5100.c           |    1 
 arch/ppc/platforms/powerpmc250.c        |    1 
 arch/ppc/platforms/pplus.c              |   58 -------------------
 arch/ppc/platforms/prep_setup.c         |   38 ------------
 arch/ppc/platforms/prpmc750.c           |    1 
 arch/ppc/platforms/prpmc800.c           |    1 
 arch/ppc/platforms/radstone_ppc7d.c     |    1 
 arch/ppc/platforms/residual.c           |    1 
 arch/ppc/platforms/sandpoint.c          |   94 -------------------------------
 arch/ppc/platforms/sandpoint.h          |    3 
 arch/ppc/platforms/spruce.c             |    1 
 arch/ppc/syslib/m8xx_setup.c            |    6 -
 arch/ppc/syslib/ppc4xx_setup.c          |   23 -------
 drivers/ide/ide.c                       |    6 -
 drivers/ide/pci/sl82c105.c              |    6 +
 drivers/ide/ppc/mpc8xx.c                |   86 +++++++---------------------
 drivers/ide/ppc/pmac.c                  |   97 +++-----------------------------
 include/asm-powerpc/ide.h               |   47 ++++++++++-----
 36 files changed, 72 insertions(+), 581 deletions(-)
