From: Tejun Heo <htejun@gmail.com>
Subject: Re: [KERNEL 2.6.26-rc4]  bugreport : pata_pcmcia with Sandisk Extreme
 III 8GB
Date: Mon, 16 Jun 2008 22:24:48 +0900
Message-ID: <485669A0.6000404@gmail.com>
References: <20080528225049.9a134e0d.Kristoffer.Ericson@Gmail.com>	<20080528222740.GB20893@isilmar.linta.de>	<20080530135728.be02d3dc.Kristoffer.Ericson@Gmail.com>	<20080607223716.7d142072.komurojun-mbn@nifty.com>	<20080611072029.GB28692@comet.dominikbrodowski.net>	<20080614120055.ad8fbee0.komurojun-mbn@nifty.com>	<48537149.4040102@garzik.org>	<20080614213612.96873c25.komurojun-mbn@nifty.com>	<4855D8E2.10409@gmail.com> <20080616221145.e3b069b9.komurojun-mbn@nifty.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000102010201020501050003"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.232]:41036 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753528AbYFPNY5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Jun 2008 09:24:57 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3578776rvb.1
        for <linux-ide@vger.kernel.org>; Mon, 16 Jun 2008 06:24:55 -0700 (PDT)
In-Reply-To: <20080616221145.e3b069b9.komurojun-mbn@nifty.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Komuro <komurojun-mbn@nifty.com>
Cc: Jeff Garzik <jeff@garzik.org>, Dominik Brodowski <linux@dominikbrodowski.net>, jgarzik@redhat.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pcmcia <linux-pcmcia@lists.infradead.org>, Kristoffer Ericson <kristoffer.ericson@gmail.com>

This is a multi-part message in MIME format.
--------------000102010201020501050003
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Komuro wrote:
> Hi,
> 
> Here is the log  (your patch is applied).
> Unfortunately, no message that you added appears.
> 
> It seems this device is detected as pcmcia0.0 first
> but later it is detected as pcmcia0.1.

Hmmm... strange.  Can you please try the attached patch?

-- 
tejun

--------------000102010201020501050003
Content-Type: text/x-patch;
 name="pata_pcmcia-debug-1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pata_pcmcia-debug-1.patch"

diff --git a/drivers/ata/pata_pcmcia.c b/drivers/ata/pata_pcmcia.c
index 3d39f9d..0eb4f77 100644
--- a/drivers/ata/pata_pcmcia.c
+++ b/drivers/ata/pata_pcmcia.c
@@ -176,9 +176,14 @@ static int pcmcia_init_one(struct pcmcia_device *pdev)
 
 	struct ata_port_operations *ops = &pcmcia_port_ops;
 
+	dev_printk(KERN_INFO, &pdev->dev, "XXX ENTER\n");
+	dump_stack();
+
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
-	if (info == NULL)
+	if (info == NULL) {
+		printk("XXX info alloc failed\n");
 		return -ENOMEM;
+	}
 
 	/* Glue stuff together. FIXME: We may be able to get rid of info with care */
 	info->pdev = pdev;
@@ -196,8 +201,10 @@ static int pcmcia_init_one(struct pcmcia_device *pdev)
 	/* Allocate resoure probing structures */
 
 	stk = kzalloc(sizeof(*stk), GFP_KERNEL);
-	if (!stk)
+	if (!stk) {
+		printk("XXX stk alloc failed\n");
 		goto out1;
+	}
 
 	cfg = &stk->parse.cftable_entry;
 
@@ -290,8 +297,11 @@ next_entry:
 	ret = -ENOMEM;
 	io_addr = devm_ioport_map(&pdev->dev, io_base, 8);
 	ctl_addr = devm_ioport_map(&pdev->dev, ctl_base, 1);
-	if (!io_addr || !ctl_addr)
+	if (!io_addr || !ctl_addr) {
+		printk("XXX ioport_map failed io_addr=%p ctl_addr=%p\n",
+		       io_addr, ctl_addr);
 		goto failed;
+	}
 
 	/* Success. Disable the IRQ nIEN line, do quirks */
 	iowrite8(0x02, ctl_addr);
@@ -311,8 +321,10 @@ next_entry:
 	 */
 	ret = -ENOMEM;
 	host = ata_host_alloc(&pdev->dev, n_ports);
-	if (!host)
+	if (!host) {
+		printk("XXX host alloc failed\n");
 		goto failed;
+	}
 
 	for (p = 0; p < n_ports; p++) {
 		ap = host->ports[p];
@@ -331,11 +343,14 @@ next_entry:
 	/* activate */
 	ret = ata_host_activate(host, pdev->irq.AssignedIRQ, ata_sff_interrupt,
 				IRQF_SHARED, &pcmcia_sht);
-	if (ret)
+	if (ret) {
+		printk("XXX host activate failed ret=%d\n", ret);
 		goto failed;
+	}
 
 	info->ndev = 1;
 	kfree(stk);
+	dev_printk(KERN_INFO, &pdev->dev, "XXX LEAVE 0\n");
 	return 0;
 
 cs_failed:
@@ -345,6 +360,7 @@ failed:
 	info->ndev = 0;
 	pcmcia_disable_device(pdev);
 out1:
+	dev_printk(KERN_INFO, &pdev->dev, "XXX LEAVE %d\n", ret);
 	kfree(info);
 	return ret;
 }

--------------000102010201020501050003--
