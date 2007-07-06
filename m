From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.22-rc7] libata: fix assigned IRQ reporting
Date: Fri, 06 Jul 2007 15:40:45 +0900
Message-ID: <468DE3ED.3040100@gmail.com>
References: <20070702163847.GV29122@htj.dyndns.org> <20070702214747.GA23182@electric-eye.fr.zoreil.com> <4689A432.6080104@gmail.com> <20070703222205.GA18532@electric-eye.fr.zoreil.com> <468B3126.3080706@gmail.com> <468B3452.6040509@gmail.com> <20070704185936.GA13212@electric-eye.fr.zoreil.com> <468C59B6.1030502@gmail.com> <20070705224536.GA9148@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080001010404060503080903"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.224]:49731 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758088AbXGFGkv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 6 Jul 2007 02:40:51 -0400
Received: by nz-out-0506.google.com with SMTP id s18so118209nze
        for <linux-ide@vger.kernel.org>; Thu, 05 Jul 2007 23:40:51 -0700 (PDT)
In-Reply-To: <20070705224536.GA9148@electric-eye.fr.zoreil.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

This is a multi-part message in MIME format.
--------------080001010404060503080903
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Francois Romieu wrote:
> Tejun Heo <htejun@gmail.com> :
> [...]
>> Apparently, I'm more confused than you are.  My "master" was at 872aad45
>> but my index was at rc7.  Can you please force checkout the head and
>> re-test?  I've tested both native and legacy modes and it's fixed here.
> 
> I have done a forced checkout + mrproper before rebuild and there is no
> difference.
> 
> Complete dmesg is attached.

Hmmmm... Weird.  Can you please apply the attached patch and post boot
dmesg?  Thanks.

-- 
tejun

--------------080001010404060503080903
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index fa1c22c..1a5bd75 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -1069,6 +1069,7 @@ int ata_pci_init_one(struct pci_dev *pdev,
 		rc = devm_request_irq(dev, pdev->irq, pi->port_ops->irq_handler,
 				      IRQF_SHARED, DRV_NAME, host);
 		host->irq = pdev->irq;
+		printk("XXX native mode irq=%lu\n", host->irq);
 	} else {
 		irq_handler_t handler[2] = { host->ops->irq_handler,
 					     host->ops->irq_handler };
@@ -1076,6 +1077,7 @@ int ata_pci_init_one(struct pci_dev *pdev,
 		void *dev_id[2] = { host, host };
 
 		rc = ata_request_legacy_irqs(host, handler, irq_flags, dev_id);
+		printk("XXX legacy mode irq=%lu irq2=%lu\n", host->irq, host->irq2);
 	}
 	if (rc)
 		goto err_out;

--------------080001010404060503080903--
