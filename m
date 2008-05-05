From: "Guglielmo Fanini" <g.fanini@gmail.com>
Subject: request for SiS SATA hard disk controller 966 rev. 1183 windows driver
Date: Mon, 5 May 2008 20:54:41 +0100
Message-ID: <602D57F60B6F41499FD3A4E0A96AD1FD@willpc>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:10062 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171AbYEETyx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 May 2008 15:54:53 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1159370nfc.21
        for <linux-ide@vger.kernel.org>; Mon, 05 May 2008 12:54:51 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I found on http://www.sis.com/aboutsis/aboutsis_index05_01.htm a SATA driver 
411a.zip but it is for chipset 966 revisions 1182, 1184, I have chip 
revision 1183, can you ask SiS where to find the driver ?

I found on http://driver.sis.com/linux/raid/sis18x_20060508.zip

static struct pci_device_id sis_pci_tbl[] = {
 { PCI_VENDOR_ID_SI, 0x0180, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
 { PCI_VENDOR_ID_SI, 0x0181, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
 { PCI_VENDOR_ID_SI, 0x0182, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
 { PCI_VENDOR_ID_SI, 0x1180, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
 { PCI_VENDOR_ID_SI, 0x1182, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },

 { PCI_VENDOR_ID_SI, 0x1183, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },

 { PCI_VENDOR_ID_SI, 0x1184, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
 { } /* terminate list */
}; 

