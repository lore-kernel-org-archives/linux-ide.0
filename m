From: Tejun Heo <htejun@gmail.com>
Subject: Re: SATA SB600 works in 2.6.20.4 but not in 2.6.21-rc5 with irqpoll
 parameter
Date: Fri, 04 May 2007 11:49:18 +0200
Message-ID: <463B019E.7010700@gmail.com>
References: <4608807F.6040202@gmail.com> <4608820D.2000203@gmail.com> <46088328.8070601@gmail.com> <460883FB.1030000@gmail.com> <460896D8.8040203@gmail.com> <460899D4.6070708@gmail.com> <4608A0BD.2010209@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020600070503020907040403"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:20091 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031361AbXEDJt3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 4 May 2007 05:49:29 -0400
Received: by py-out-1112.google.com with SMTP id a29so636945pyi
        for <linux-ide@vger.kernel.org>; Fri, 04 May 2007 02:49:29 -0700 (PDT)
In-Reply-To: <4608A0BD.2010209@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Mat=ED=ADas_Alejandro_Torres?= <torresmat@gmail.com>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------020600070503020907040403
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Matí­as Alejandro Torres wrote:
> CORRECTION:
> 
> I tried with the irqpoll parameter (used in the right way) and the sata
> disk is detected but lots of "unexpected IRQ trap at vector a0" are
> displayed. When the pci=nomsi flag is set, no warning/error is shown and
> the SATA disk is detected properly.
> 
> 
> This is for kernel version 2.6.17, I must be falling asleep.

Matias, are you still there?  If so, can you please test the attached
patch and see whether it fixes your problem - ie. boots okay without
'pci=nomsi'?

-- 
tejun

--------------020600070503020907040403
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

Index: tree0/drivers/pci/quirks.c
===================================================================
--- tree0.orig/drivers/pci/quirks.c
+++ tree0/drivers/pci/quirks.c
@@ -1761,6 +1761,7 @@ static void __devinit quirk_disable_msi(
 	}
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8131_BRIDGE, quirk_disable_msi);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x5a3f, quirk_disable_msi); /* RS480 PCI bridge */
 
 /* Go through the list of Hypertransport capabilities and
  * return 1 if a HT MSI capability is found and enabled */

--------------020600070503020907040403--
