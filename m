From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: Re: Pata support for SIS180
Date: Sun, 12 Jun 2005 22:31:53 +0200
Message-ID: <42AC9BB9.2030304@gmx.net>
References: <42AAE8B1.8080607@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from imap.gmx.net ([213.165.64.20]:56264 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261210AbVFLUb6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Jun 2005 16:31:58 -0400
In-Reply-To: <42AAE8B1.8080607@verizon.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Wes Newell <w.newell@verizon.net>
Cc: "linux.ide" <linux-ide@vger.kernel.org>

Wes Newell schrieb:

> Can anyone tell me if/how one could add device support for the sis180
> chipset pata ports to the sis5513 module? I've tried adding this as
> others have said it works for the 965 southbridge,
>
> if ((trueid == 0x5518) || (trueid == 0x0180)) {
>
> but it stll doesn't see a real sis180 on a Jetway S755MAX MB.


you must include the chip into the pci_device_id table

static *struct* pci_device_id sis5513_pci_tbl[] = {
	{ PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_5513, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
	{ PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_5518, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_180, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
	{ 0, },
};


regards
Uwe Koziolek
