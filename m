From: "Shane Huang" <Shane.Huang@amd.com>
Subject: RE: [patch] SB700 contains more than one IDE channel
Date: Fri, 28 Sep 2007 11:44:26 +0800
Message-ID: <5CAB7B5D6F8AB84AA868A46B47A5070544C2CE@sshaexmb1.amd.com>
References: <46FB9FA7.7090403@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outbound-dub.frontbridge.com ([213.199.154.16]:22196 "EHLO
	outbound6-dub-R.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754575AbXI1DqX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 Sep 2007 23:46:23 -0400
Content-class: urn:content-classes:message
In-Reply-To: <46FB9FA7.7090403@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>, bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org, gregkh@suse.de, "Su, Henry" <Henry.Su@amd.com>, Shane Huang <Shane.Huang@amd.com>

Hi Sergei:

Thanks for your reply.

>     The inlined patch has suffered from word wrapping, 

OK, I think the cause is my mail client MS outlook's setting.
I try to change my outlook settings and attach the patch again at the
end of this mail. Please check it again.

> and the attached one
> luckily didn't; yet the attachment has a wrong MIME type -- patches
should be
> text/plain.

As to this case, I don't know why. The patch was generated with diff on
linux,
and copied to my windows mail machine to be sent. All my previous
patches
with the same method do NOT meet such problem.
So if the patch in this mail does not work either, would you please help
to
change and apply it for me? So that we can save some time, otherwise
I'll
have to try to use gmail to send it at home.

Thanks
Best Regards
Shane


Signed-off-by: shane.huang@amd.com
----------------------------------------------
diff -ruN linux-2.6.23-rc5_orig/drivers/ide/pci/atiixp.c
linux-2.6.23-rc5/drivers/ide/pci/atiixp.c
--- linux-2.6.23-rc5_orig/drivers/ide/pci/atiixp.c	2007-09-01
14:08:24.000000000 +0800
+++ linux-2.6.23-rc5/drivers/ide/pci/atiixp.c	2007-09-28
00:35:55.000000000 +0800
@@ -325,7 +325,7 @@
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP300_IDE, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP400_IDE, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_IDE, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 1},
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP700_IDE, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 1},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP700_IDE, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 0},
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, atiixp_pci_tbl);



