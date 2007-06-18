From: "Gaston, Jason D" <jason.d.gaston@intel.com>
Subject: RE: libata: ATA_PIIX missing ICH8M PCIIDs.
Date: Mon, 18 Jun 2007 11:00:33 -0700
Message-ID: <39B20DF628532344BC7A2692CB6AEE07016FE47F@orsmsx420.amr.corp.intel.com>
References: <200706181520.06682.chunkeey@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:24203 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761651AbXFRSAg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jun 2007 14:00:36 -0400
Content-class: urn:content-classes:message
In-Reply-To: <200706181520.06682.chunkeey@web.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chr <chunkeey@web.de>, linux-ide@vger.kernel.org

I don't think we want to have a PATA controller DID added to the SATA I=
DE mode driver.  This DID is already in the PATA piix.c driver.

Jason



>-----Original Message-----
>From: linux-ide-owner@vger.kernel.org [mailto:linux-ide-
>owner@vger.kernel.org] On Behalf Of Chr
>Sent: Monday, June 18, 2007 6:20 AM
>To: linux-ide@vger.kernel.org
>Cc: chunkeey@web.de
>Subject: libata: ATA_PIIX missing ICH8M PCIIDs.
>
>Hi,
>
>I got a new laptop and I had a little problem that the DVD drive wasn'=
t
>recognized by
>libata's piix driver (but the old IDE Subsystem found it!).
>
>So, after adding the new pciid 8086:2850 it works!
>But, I don't know if it's ich_pata_100 or ich_pata_133 since the
>dvd/cd drives only goes up to udma2 speeds.
>
>Thanks,
>=A0=A0=A0=A0=A0=A0=A0=A0Chr.
>
>(I'm not on the list, please keep the cc!)
>
>-
>this patch adds a necessary PCIID for santa rosa's PATA controller.
>
>Signed-off-by: Christian Lamparter <chunkeey@web.de>
