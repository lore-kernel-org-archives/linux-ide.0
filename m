From: Matthew Wilcox <willy@debian.org>
Subject: [PATCH] Unify some Kconfig options
Date: Mon, 9 Jun 2003 21:43:09 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20030609204309.GC28581@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50655 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261819AbTFIU3a
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 9 Jun 2003 16:29:30 -0400
Received: from willy by www.linux.org.uk with local (Exim 4.14)
	id 19PTTx-0001lg-SP
	for linux-ide@vger.kernel.org; Mon, 09 Jun 2003 21:43:09 +0100
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


This patch allows all architectures to simply include the
drivers/ide/Kconfig file.  Comments?  It's 40k, so I think sending it
inline would be deemed 'obnoxious'.  Here's the diffstat instead:

 arch/alpha/Kconfig     |   60 -------------------------------------------------
 arch/arm/Kconfig       |   51 -----------------------------------------
 arch/cris/Kconfig      |    8 ------
 arch/h8300/Kconfig     |   15 ------------
 arch/i386/Kconfig      |   51 -----------------------------------------
 arch/ia64/Kconfig      |   53 -------------------------------------------
 arch/m68k/Kconfig      |   51 -----------------------------------------
 arch/m68knommu/Kconfig |   15 ------------
 arch/mips/Kconfig      |   52 ------------------------------------------
 arch/mips64/Kconfig    |   51 -----------------------------------------
 arch/parisc/Kconfig    |    6 ----
 arch/ppc/Kconfig       |   48 ---------------------------------------
 arch/ppc64/Kconfig     |   48 ---------------------------------------
 arch/sh/Kconfig        |   51 -----------------------------------------
 arch/sparc/Kconfig     |   50 ----------------------------------------
 arch/sparc64/Kconfig   |   50 ----------------------------------------
 arch/v850/Kconfig      |   10 --------
 arch/x86_64/Kconfig    |   51 -----------------------------------------
 drivers/ide/Kconfig    |   58 +++++++++++++++++++++++++++++++++++++++++++++++
 19 files changed, 59 insertions(+), 720 deletions(-)

http://ftp.linux.org.uk/pub/linux/willy/patches/ide-Kconfig.diff

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
