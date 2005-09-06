From: Tejun Heo <htejun@gmail.com>
Subject: Re: RE :sata_sil + UDMA CRC errors
Date: Wed, 7 Sep 2005 00:38:26 +0900
Message-ID: <20050906153826.GA3067@htj.dyndns.org>
References: <1126006398.3097.9.camel@m00> <20050906115659.GA16865@htj.dyndns.org> <1126016000.3760.15.camel@m00>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.207]:62074 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750729AbVIFPii (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Sep 2005 11:38:38 -0400
Received: by zproxy.gmail.com with SMTP id r28so831927nza
        for <linux-ide@vger.kernel.org>; Tue, 06 Sep 2005 08:38:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1126016000.3760.15.camel@m00>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexander Shaposhnikov <shaposh@isp.nsc.ru>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Carlos.Pardo@siliconimage.com, Paul.Taylor@siliconimage.com, "lbattraw@insightbb.com" <lbattraw@insightbb.com>, Yuri Kirsanov <flash@rccb.ru>

[Alexander dropped all CC's when replying to my mail.  I'm adding them
 back.  Alexander, please reply to all, not just me. ]

On Tue, Sep 06, 2005 at 09:13:20PM +0700, Alexander Shaposhnikov wrote:
> Hello Tejun
> 
> I dont really know what has changed in sata_sil driver, but:
> 1. I have no more problems with my Seagate drive
> 2. I have now good read and write perfomance (around 50MB/s both) on my
> Seagate drive, without your patch.

 #2 is because we don't apply m15w quirk to 3114's as sii has
confirmed that 3114's are not affected.  Maybe it affected #1 in a
mysterious way, I just don't know.

> The hardware problem was my first sought, naturally.
> I tried several cables with no difference. Probably controller error.
> 
> But there is strong reason against this: i have no errors under Windows.
> These CRC errors are logged and can be be viewed in SMART status of hard
> drives. If, as you suppose, i am getting this errors under Windows too,
> i would see the growth of according UDMA CRC errors number during hard
> disk activity. But this does not happen, no single error under Windows,
> while alot of them under Linux. 
> 
> Is it possible you can test your drives on sil3114 controller?.  Or,
> better, on the same board (ASUS K8N-DL) ?
> 
> Best Regards,
> Alexander Shaposhnikov
> 

 Okay, as SII has kindly opened documents for 3112/3114.  I digged a
little bit and here's something I came up with.  This is highly
experimental and potentially dangerous.

 The chip has a phy configuration register which can adjust
differentail voltage swing.  The following patch adds a module
parameter tx_swing to sata_sil driver.  This is an integer parameter
and has the following meaning.

-1 : don't change transmission voltage swing (default)
0  : 500mV
1  : 600mV
2  : 700mV
3  : 800mV

 So, after building sata_sil as a module and installing it.

# modprobe sata_sil
sata_sil(0000:01:02.0): phy_conf 0x80f1 (nominal output swing 500mV)
ata5: SATA max UDMA/100 cmd 0xE1020C80 ctl 0xE1020C8A bmdma 0xE1020C00 irq 19
ata6: SATA max UDMA/100 cmd 0xE1020CC0 ctl 0xE1020CCA bmdma 0xE1020C08 irq 19
ata5: no device found (phy stat 00000000)
scsi5 : sata_sil
ata6: dev 0 ATA, max UDMA7, 312581808 sectors: lba48
ata6: dev 0 configured for UDMA/100
scsi6 : sata_sil
  Vendor: ATA       Model: SAMSUNG HD160JJ   Rev: WU10
  Type:   Direct-Access                      ANSI SCSI revision: 05
~~~~~

 Note that the driver prints current phy_conf setting on
initialization.  Mine is initialized to default 500mV.  Let's bump it
up to 600mV.

# modprobe sata_sil tx_swing=1
sata_sil(0000:01:02.0): overwriting phy_conf to 0xc0f1
sata_sil(0000:01:02.0): phy_conf 0xc0f1 (nominal output swing 600mV)
ata7: SATA max UDMA/100 cmd 0xE1020C80 ctl 0xE1020C8A bmdma 0xE1020C00 irq 19
ata8: SATA max UDMA/100 cmd 0xE1020CC0 ctl 0xE1020CCA bmdma 0xE1020C08 irq 19
ata7: no device found (phy stat 00000000)
scsi7 : sata_sil
ata8: dev 0 ATA, max UDMA7, 312581808 sectors: lba48
ata8: dev 0 configured for UDMA/100
scsi8 : sata_sil
  Vendor: ATA       Model: SAMSUNG HD160JJ   Rev: WU10
  Type:   Direct-Access                      ANSI SCSI revision: 05
~~~~~

 You can see that now tx swing voltage is set to 600mV.  In my case,
both settings work fine.  So, if you're brave enough to try this....

1. First load the module without any argument and see what's the
   default value is.  It probably is 500mV unless your BIOS has
   twicked it.

2. If the default is 500mV, try 600mV with tx_swing=1.  Theoretically
   this should be safe.  According to SATA spec, max value of both
   Vdiff,tx and Vdiff,rx is 600mV, so setting 600mV is inside the
   limit and shouldn't cause any problem.  Well, that's the theory.

   If the default is not 500mV, try the next higher setting.  This
   can be dangerous, but my bet is that this shouldn't cause any
   damage on the drive.  The BIOS should be configuring for 500mV
   at the connector and increasing 100mV shouldn't make the swing
   voltage go over 600mV at the rx side.  But this is just my guess
   and it's unlikely but possible that you fry the PHY of your drive.

3. See if CRC errors continue to occur.

 Again, though unlikely, this might fry PHY of your drive, so try it
at your own risk.


diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -73,6 +73,7 @@ enum {
 	SIL_MASK_4PORT		= SIL_MASK_2PORT |
 				  SIL_MASK_IDE2_INT | SIL_MASK_IDE3_INT,
 
+	SIL_PHY_CONF		= 0x144,
 	SIL_IDE2_BMDMA		= 0x200,
 
 	SIL_INTR_STEERING	= (1 << 1),
@@ -231,6 +232,9 @@ MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, sil_pci_tbl);
 MODULE_VERSION(DRV_VERSION);
 
+static int tx_swing = -1;
+module_param(tx_swing, int, 0444);
+
 static unsigned char sil_get_device_cache_line(struct pci_dev *pdev)
 {
 	u8 cache_line = 0;
@@ -379,7 +383,7 @@ static int sil_init_one (struct pci_dev 
 	int rc;
 	unsigned int i;
 	int pci_dev_busy = 0;
-	u32 tmp, irq_mask;
+	u32 phy_conf, tmp, irq_mask;
 	u8 cls;
 
 	if (!printed_version++)
@@ -445,6 +449,25 @@ static int sil_init_one (struct pci_dev 
 		ata_std_ports(&probe_ent->port[i]);
 	}
 
+	/* PHY configuration */
+	if (tx_swing >= 0) {
+		if (tx_swing <= 3) {
+			phy_conf = readl(mmio_base + SIL_PHY_CONF);
+			phy_conf &= ~((1 << 19) | (1 << 14));
+			phy_conf |= ((tx_swing & (1 << 1)) << 18) | ((tx_swing & (1 << 0)) << 14);
+			printk(KERN_INFO DRV_NAME "(%s): overwriting phy_conf to 0x%x\n",
+			       pci_name(pdev), phy_conf);
+			writel(phy_conf, mmio_base + SIL_PHY_CONF);
+		} else
+			printk(KERN_WARNING DRV_NAME "(%s): tx_swing out of range\n",
+			       pci_name(pdev));
+	}
+
+	phy_conf = readl(mmio_base + SIL_PHY_CONF);
+	tmp = ((phy_conf & (1 << 19)) >> 18) | ((phy_conf & (1 << 14)) >> 14);
+	printk(KERN_INFO DRV_NAME "(%s): phy_conf 0x%x (nominal output swing %dmV)\n",
+	       pci_name(pdev), phy_conf, 500 + 100 * tmp);
+
 	/* Initialize FIFO PCI bus arbitration */
 	cls = sil_get_device_cache_line(pdev);
 	if (cls) {
