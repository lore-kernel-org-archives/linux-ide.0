From: Robert Hancock <hancockr@shaw.ca>
Subject: [PATCH -mm] sata_nv: fix kfree ordering in remove
Date: Mon, 11 Dec 2006 23:34:34 -0600
Message-ID: <457E3F6A.809@shaw.ca>
References: <456E3ED5.3090201@shaw.ca> <457D86F0.4020408@garzik.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=------------030707030608070609040709
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:18417 "EHLO
	pd5mo3so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178AbWLLFgg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Dec 2006 00:36:36 -0500
In-reply-to: <457D86F0.4020408@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Andrew Morton <akpm@osdl.org>

This is a multi-part message in MIME format.
--------------030707030608070609040709
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jeff Garzik wrote:
> It is unwise to free the struct before the ports are even detached.

Right, theoretically something bad could happen here (though not 
likely). Here's a fix. Sorry for attaching with something so trivial, 
but Thunderbird isn't very cooperative..

---

The suspend/resume change for sata_nv introduced a potential bug where 
the hpriv structure could be used after it was freed in nv_remove_one. 
Fix that.

Signed-off-by: Robert Hancock <hancockr@shaw.ca>

---
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

--------------030707030608070609040709
Content-Type: text/plain;
 name="sata_nv-fix-kfree-order-on-remove.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sata_nv-fix-kfree-order-on-remove.patch"

--- linux-2.6.19-rc6-mm2/drivers/ata/sata_nv.c	2006-12-11 22:13:26.000000000 -0600
+++ linux-2.6.19-rc6-mm2admafix/drivers/ata/sata_nv.c	2006-12-11 22:15:58.000000000 -0600
@@ -1555,8 +1555,8 @@ static void nv_remove_one (struct pci_de
 	struct ata_host *host = dev_get_drvdata(&pdev->dev);
 	struct nv_host_priv *hpriv = host->private_data;
 	
-	kfree(hpriv);
 	ata_pci_remove_one(pdev);
+	kfree(hpriv);
 }	
 
 static int nv_pci_device_resume(struct pci_dev *pdev)

--------------030707030608070609040709--

