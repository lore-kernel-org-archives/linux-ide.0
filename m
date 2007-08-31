From: "Gaston, Jason D" <jason.d.gaston@intel.com>
Subject: RE: [PATCH 2.6.23-rc4][RESEND] ahci: RAID mode SATA patch for Intel Tolapai
Date: Thu, 30 Aug 2007 18:00:26 -0700
Message-ID: <39B20DF628532344BC7A2692CB6AEE0701B5BC46@orsmsx420.amr.corp.intel.com>
References: <200708301753.31692.jason.d.gaston@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:39138 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754255AbXHaBAc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Aug 2007 21:00:32 -0400
Content-class: urn:content-classes:message
In-Reply-To: <200708301753.31692.jason.d.gaston@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Gaston, Jason D" <jason.d.gaston@intel.com>, jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

>-----Original Message-----
>From: Gaston, Jason D
>Sent: Thursday, August 30, 2007 5:54 PM
>To: jgarzik@pobox.com; Gaston, Jason D
>Cc: linux-ide@vger.kernel.org; linux-kernel@vger.kernel.org
>Subject: [PATCH 2.6.23-rc4][RESEND] ahci: RAID mode SATA patch for Int=
el
>Tolapai
>
>Resend without wordwrap.
>
>This patch adds the Intel Tolapai RAID controller DID's for SATA suppo=
rt.
>
>Signed-off-by: =A0Jason Gaston <jason.d.gaston@intel.com>
>
>--- linux-2.6.23-rc4/drivers/ata/ahci.c.orig	2007-08-27
>18:32:35.000000000 -0700
>+++ linux-2.6.23-rc4/drivers/ata/ahci.c	2007-08-28 16:58:11.000000000 =
-
>0700
>@@ -411,6 +411,8 @@
> 	{ PCI_VDEVICE(INTEL, 0x292f), board_ahci_pi }, /* ICH9M */
> 	{ PCI_VDEVICE(INTEL, 0x294d), board_ahci_pi }, /* ICH9 */
> 	{ PCI_VDEVICE(INTEL, 0x294e), board_ahci_pi }, /* ICH9M */
>+	{ PCI_VDEVICE(INTEL, 0x502a), board_ahci }, /* Tolapai */
>+	{ PCI_VDEVICE(INTEL, 0x502b), board_ahci }, /* Tolapai */
>
> 	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
> 	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,


I am having trouble sending these patches.  When I look in the LKML.org=
 message archive, I see "=3DA0" and "=3D20" in the messages.  I am usin=
g KMail to send these, I have wordwrap turned off and am inserting the =
patch file.  Does anyone know what I am doing wrong?

Thanks,

Jason
