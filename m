From: Konstantinos Margaritis <markos@codex.gr>
Subject: [PATCH] fix sata_sil compilation on non-DMI platforms
Date: Wed, 6 May 2009 20:09:27 +0300
Message-ID: <200905062009.28087.markos@codex.gr>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_IRcAKc+GQXIXaxB"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lvps87-230-20-158.dedicated.hosteurope.de ([87.230.20.158]:46309
	"EHLO lvps87-230-20-158.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755238AbZEFRTL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 May 2009 13:19:11 -0400
Received: from ilmater.localnet (athedsl-420568.home.otenet.gr [79.131.194.214])
	(using SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by lvps87-230-20-158.dedicated.hosteurope.de (Postfix) with ESMTPSA id 8FD2EAFE801C
	for <linux-ide@vger.kernel.org>; Wed,  6 May 2009 19:09:34 +0200 (CEST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

--Boundary-00=_IRcAKc+GQXIXaxB
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

(not subscribed please CC me)

I tried to compile sata_sil on a 2.6.27 kernel on powerpc32 and I found that 
it failed to compile -lots of dmi related errors. I found that I had to 
include the broken_systems handling code in #ifdef CONFIG_DMI (DMI is not 
supported on platforms other than i386/x86_64). 

Lennert on #mklinux told me that this commit broke the non-dmi support, and 
that a similar patch to mine is used on ARM systems :

commit e57db7bde7bff95ae812736ca00c73bd5271455b
SATA Sil: Blacklist system that spins off disks during ACPI power off

With this patch, sata_sil compiles on ppc (and I guess on other platforms). 
I'm using it for a while with no problems with a Delock 4-port SATA PCI card.

Regards

-- 
Konstantinos Margaritis
Codex
http://www.codex.gr

--Boundary-00=_IRcAKc+GQXIXaxB
Content-Type: text/x-patch;
  charset="us-ascii";
  name="sata_sil.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sata_sil.c.patch"

--- sata_sil.c.orig	2009-05-06 20:03:16.472876188 +0300
+++ sata_sil.c	2009-05-06 20:04:22.693209638 +0300
@@ -698,6 +698,7 @@
 
 static bool sil_broken_system_poweroff(struct pci_dev *pdev)
 {
+#ifdef CONFIG_DMI
 	static const struct dmi_system_id broken_systems[] = {
 		{
 			.ident = "HP Compaq nx6325",
@@ -718,7 +719,7 @@
 		/* apply the quirk only to on-board controllers */
 		return slot == PCI_SLOT(pdev->devfn);
 	}
-
+#endif
 	return false;
 }
 

--Boundary-00=_IRcAKc+GQXIXaxB--
