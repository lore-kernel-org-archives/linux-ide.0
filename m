From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH] fix sata_sil compilation on non-DMI platforms
Date: Sat, 16 May 2009 00:46:31 +0200
Message-ID: <18957.61639.955028.36649@pilspetsen.it.uu.se>
References: <200905062009.28087.markos@codex.gr>
	<4A086A76.3090008@garzik.org>
	<18953.15575.632189.258813@pilspetsen.it.uu.se>
	<4A0940B9.5080905@garzik.org>
	<18957.19954.594210.891282@pilspetsen.it.uu.se>
	<4A0DAB1C.6060404@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:64972 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752136AbZEOWsF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 15 May 2009 18:48:05 -0400
In-Reply-To: <4A0DAB1C.6060404@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Mikael Pettersson <mikpe@it.uu.se>, Konstantinos Margaritis <markos@codex.gr>, linux-ide@vger.kernel.org, Lennert Buytenhek <buytenh@wantstofly.org>, Lennart Sorensen <lsorense@csclub.uwaterloo.ca>

Jeff Garzik writes:
 > Mikael Pettersson wrote:
 > > Ok I've checked now, and the breakage is that the commit referenced
 > > above added dmi stuff to sata_sil.c without an #include <linux/dmi.h>,
 > > and that broke !x86 builds:
 > 
 > Great!  Thanks for checking.
 > 
 > 
 > > drivers/ata/sata_sil.c: In function 'sil_broken_system_poweroff':
 > > drivers/ata/sata_sil.c:713: error: implicit declaration of function 'dmi_first_match'
 > > drivers/ata/sata_sil.c:713: warning: initialization makes pointer from integer without a cast
 > > 
 > > x86 builds work because they drag in dmi.h indirectly via some other header.
 > > 
 > > The follow-up commit 1737ef7598d3515fdc11cb9ba7e054f334404e04
 > > "sata_sil: Fix build breakage" added #include <linux/dmi.h> which
 > > made !x86 builds work again. 2.6.29-rc3 was released in the window
 > > between these two commits so it had this build breakage.
 > > 
 > > So the problem is not that <linux/dmi.h> doesn't work, but that
 > > someone apparently backported e57db7bde7bff95ae812736ca00c73bd5271455b
 > > to 2.6.27 but not 1737ef7598d3515fdc11cb9ba7e054f334404e04.
 > 
 > OK, so it sounds like upstream is OK, and 2.6.27.x needs 
 > 1737ef7598d3515fdc11cb9ba7e054f334404e04

Upstream is ok, but so is 2.6.27.x. 2.6.27 vanilla sata_sil.c has no
dmi stuff in it, and 2.6.27.23 (current latest -stable for 2.6.27)
has no updates to sata_sil.c. I just compiled both those kernels for
ARM with sata_sil enabled and there were no errors.

Looks like the original poster used a patched 2.6.27...
