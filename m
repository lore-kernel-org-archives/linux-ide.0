From: Mikael Pettersson <mikpe@csd.uu.se>
Subject: Re: PDC20269 problems on PowerMac with 2.4.27 kernel
Date: Sun, 15 Aug 2004 13:25:03 +0200 (MEST)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200408151125.i7FBP3AJ029047@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:29640 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266582AbUHOLZG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Aug 2004 07:25:06 -0400
Received: from harpo.it.uu.se (daemon@harpo.it.uu.se [130.238.12.34])
	by aun.it.uu.se (8.12.11/8.12.10) with ESMTP id i7FBP3to024830
	for <linux-ide@vger.kernel.org>; Sun, 15 Aug 2004 13:25:03 +0200 (MEST)
Received: (from mikpe@localhost)
	by harpo.it.uu.se (8.12.10+Sun/8.12.10) id i7FBP3AJ029047
	for linux-ide@vger.kernel.org; Sun, 15 Aug 2004 13:25:03 +0200 (MEST)
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I wrote:
>I have a PowerMac G3 (beige) upgraded with a 1GHz G4 processor
>and a PDC20269 (Promise Ultra 133 TX2) IDE PCI controller,
>which works reliably with the 2.6.8-rc kernels. The controller,
>disk, and cable also work in an x86 box with both 2.6 and 2.4 kernels.
>
>However, with 2.4.27 on the PowerMac I frequently get DMA timeouts
>while doing heavy I/O operations like a cp -ax from my scsi root
>to a partition on the PDC20269's disk:

The issue has been resolved. There is an erratum causing
PPC745x processors to read stale data from non-coherent
memory mappings. The fix is to enforce coherent mappings:
2.6.8-rc had that fix but 2.4.27 did not, and that utterly
broke both the PDC202XX old and new drivers.

Interestingly, the SYM53C8XX SCSI driver did not break.

/Mikael
