From: Tejun Heo <tj@kernel.org>
Subject: Re: "ahci: drop intx manipulation on msi enable" breaks ULI M1575
Date: Wed, 08 Apr 2009 14:13:25 -0700
Message-ID: <49DD1375.8030400@kernel.org>
References: <49DB6914.1030107@freescale.com> <49DBE858.9040004@kernel.org>	 <ed82fe3e0904071736w55dff582y8ac2681f6410865b@mail.gmail.com>	 <1239156559.10104.7.camel@localhost> <ed82fe3e0904080440w130b5dc5of6d5ed3051ed04e2@mail.gmail.com> <49DD1154.3040106@kernel.org> <49DD11D1.7060105@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:36031 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753682AbZDHVOP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Apr 2009 17:14:15 -0400
In-Reply-To: <49DD11D1.7060105@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Timur Tabi <timur@freescale.com>
Cc: michael@ellerman.id.au, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Linux PPC Development <linuxppc-dev@ozlabs.org>

Timur Tabi wrote:
> Tejun Heo wrote:
> 
>> Running "lspci -nnvvvxxx" before loading the driver should be enough.
> 
> That might be difficult.  My root file system is on my SATA drive.
> It'll be a while before I can build an NFS rootfs.
> 

Yeah, right.  The following patch should do the trick then.

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 788bba2..b3f4df7 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -2606,6 +2606,12 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!printed_version++)
 		dev_printk(KERN_DEBUG, &pdev->dev, "version " DRV_VERSION "\n");
 
+	{
+		u16 cmd;
+		pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+		printk("XXX PCI_COMMAND=0x%x\n", cmd);
+	}
+
 	/* The AHCI driver can only drive the SATA ports, the PATA driver
 	   can drive them all so if both drivers are selected make sure
 	   AHCI stays out of the way */


-- 
tejun
