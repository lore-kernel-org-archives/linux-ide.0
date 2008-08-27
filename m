From: "Heasley, Seth" <seth.heasley@intel.com>
Subject: RE: [PATCH 2.6.26.7-rc4] ata_piix: IDE Mode SATA patch for Intel
 Ibex Peak DeviceIDs
Date: Wed, 27 Aug 2008 16:39:19 -0700
Message-ID: <CF9C39F99A89134C9CF9C4CCB68B8DDF177A1450@orsmsx501.amr.corp.intel.com>
References: <200808271640.06762.seth.heasley@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:40060 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755013AbYH0Xja convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Aug 2008 19:39:30 -0400
In-Reply-To: <200808271640.06762.seth.heasley@intel.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Heasley, Seth" <seth.heasley@intel.com>, "jgarzik@pobox.com" <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kerne>

>-----Original Message-----
>From: Heasley, Seth
>Sent: Wednesday, August 27, 2008 4:40 PM
>To: jgarzik@pobox.com; linux-ide@vger.kernel.org; linux-
>kernel@vger.kernel.org; htejun@gmail.com
>Cc: Heasley, Seth
>Subject: [PATCH 2.6.26.7-rc4] ata_piix: IDE Mode SATA patch for Intel Ibex
>Peak DeviceIDs
>
>This patch updates the Intel Ibex Peak (PCH) IDE mode SATA Controller
>DeviceIDs.
>
>Signed-off-by: Seth Heasley <seth.heasley@intel.com>
>
>--- linux-2.6/drivers/ata/ata_piix.c.orig       2008-08-27
>11:32:28.000000000 -0700
>+++ linux-2.6/drivers/ata/ata_piix.c    2008-08-27 11:47:59.000000000 -0700
>@@ -278,12 +278,15 @@
>        /* SATA Controller IDE (PCH) */
>        { 0x8086, 0x3b20, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
>        /* SATA Controller IDE (PCH) */
>+       { 0x8086, 0x3b21, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
>+       /* SATA Controller IDE (PCH) */
>        { 0x8086, 0x3b26, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
>        /* SATA Controller IDE (PCH) */
>+       { 0x8086, 0x3b28, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
>+       /* SATA Controller IDE (PCH) */
>        { 0x8086, 0x3b2d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_2port_sata },
>        /* SATA Controller IDE (PCH) */
>        { 0x8086, 0x3b2e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, ich8_sata },
>-
>        { }     /* terminate list */
> };

Typo in the subject line.  Should read 2.6.27-rc4.  This was built against http://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
