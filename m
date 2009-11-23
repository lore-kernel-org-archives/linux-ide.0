From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: RE: drivers/ide/au1xxx-ide.c: use resource_size()
Date: Mon, 23 Nov 2009 15:01:02 -0500
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901EE5C3E@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE190901EE5BFD@mi8nycmail19.Mi8.com><20091123.102817.157628485.davem@davemloft.net><BD79186B4FD85F4B8E60E381CAEE190901EE5C0C@mi8nycmail19.Mi8.com> <20091123.103810.44071453.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from exprod6ob109.obsmtp.com ([64.18.1.22]:44888 "EHLO psmtp.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753226AbZKWUA7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 Nov 2009 15:00:59 -0500
Content-class: urn:content-classes:message
In-Reply-To: <20091123.103810.44071453.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Monday, November 23, 2009 11:38 AM, David Miller wrote:
>>  
>> -	ahwif->regbase = (u32)ioremap(res->start, res->end - res->start + 1);
>> +	ahwif->regbase = (u32)ioremap(res->start, resource_size(res));
>>  	if (ahwif->regbase == 0) {
>>  		ret = -ENOMEM;
>>  		goto out;
>
> That needs some fixing.  ioremap()'s return value is an
> "__iomem" pointer, not an integer.  ->regbase's type should be
> changed to something like "void __iomem *" etc.

FWIW, following is an updated patch that fixes the "__iomem" pointer.

I have no way to even build test this but it seems clean enough.  The
only issue I can see is in auide_setup_ports().  The regbase needed
to be cast back to a unsigned long in order to correctly setup the
io_ports_array.

---

Use resource_size() for {request/release}_mem_region and ioremap.

The iomap return value is an __iomem *, not an integer.  Update the
private structure to reflect this.  Remove the typedef for _auide_hwif
and just use struct auide_hwif instead.

auide_setup_ports() still needs to cast the regbase back to an integer
to correctly setup the io_ports_array.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: David Miller <davem@davemloft.net>

---

diff --git a/arch/mips/include/asm/mach-au1x00/au1xxx_ide.h b/arch/mips/include/asm/mach-au1x00/au1xxx_ide.h
index 5656c72..f44b8bc 100644
--- a/arch/mips/include/asm/mach-au1x00/au1xxx_ide.h
+++ b/arch/mips/include/asm/mach-au1x00/au1xxx_ide.h
@@ -46,7 +46,7 @@
 #define CONFIG_BLK_DEV_IDE_AU1XXX_BURSTABLE_ON	0
 #endif
 
-typedef struct {
+struct auide_hwif {
 	u32			tx_dev_id, rx_dev_id, target_dev_id;
 	u32			tx_chan, rx_chan;
 	void			*tx_desc_head, *rx_desc_head;
@@ -57,8 +57,8 @@ typedef struct {
 	dma_addr_t		dma_table_dma;
 #endif
 	int			irq;
-	u32			regbase;
-} _auide_hwif;
+	void __iomem		*regbase;
+};
 
 /******************************************************************************/
 /* PIO Mode timing calculation :					      */
diff --git a/drivers/ide/au1xxx-ide.c b/drivers/ide/au1xxx-ide.c
index 58121bd..1c6d663 100644
--- a/drivers/ide/au1xxx-ide.c
+++ b/drivers/ide/au1xxx-ide.c
@@ -46,13 +46,13 @@
 /* enable the burstmode in the dbdma */
 #define IDE_AU1XXX_BURSTMODE	1
 
-static _auide_hwif auide_hwif;
+static struct auide_hwif auide_hwif;
 
 #if defined(CONFIG_BLK_DEV_IDE_AU1XXX_PIO_DBDMA)
 
 static inline void auide_insw(unsigned long port, void *addr, u32 count)
 {
-	_auide_hwif *ahwif = &auide_hwif;
+	struct auide_hwif *ahwif = &auide_hwif;
 	chan_tab_t *ctp;
 	au1x_ddma_desc_t *dp;
 
@@ -70,7 +70,7 @@ static inline void auide_insw(unsigned long port, void *addr, u32 count)
 
 static inline void auide_outsw(unsigned long port, void *addr, u32 count)
 {
-	_auide_hwif *ahwif = &auide_hwif;
+	struct auide_hwif *ahwif = &auide_hwif;
 	chan_tab_t *ctp;
 	au1x_ddma_desc_t *dp;
 
@@ -212,7 +212,7 @@ static void auide_set_dma_mode(ide_drive_t *drive, const u8 speed)
 static int auide_build_dmatable(ide_drive_t *drive, struct ide_cmd *cmd)
 {
 	ide_hwif_t *hwif = drive->hwif;
-	_auide_hwif *ahwif = &auide_hwif;
+	struct auide_hwif *ahwif = &auide_hwif;
 	struct scatterlist *sg;
 	int i = cmd->sg_nents, count = 0;
 	int iswrite = !!(cmd->tf_flags & IDE_TFLAG_WRITE);
@@ -344,7 +344,7 @@ static const struct ide_dma_ops au1xxx_dma_ops = {
 
 static int auide_ddma_init(ide_hwif_t *hwif, const struct ide_port_info *d)
 {
-	_auide_hwif *auide = &auide_hwif;
+	struct auide_hwif *auide = &auide_hwif;
 	dbdev_tab_t source_dev_tab, target_dev_tab;
 	u32 dev_id, tsize, devwidth, flags;
 
@@ -404,7 +404,7 @@ static int auide_ddma_init(ide_hwif_t *hwif, const struct ide_port_info *d)
 #else
 static int auide_ddma_init(ide_hwif_t *hwif, const struct ide_port_info *d)
 {
-	_auide_hwif *auide = &auide_hwif;
+	struct auide_hwif *auide = &auide_hwif;
 	dbdev_tab_t source_dev_tab;
 	int flags;
 
@@ -449,17 +449,18 @@ static int auide_ddma_init(ide_hwif_t *hwif, const struct ide_port_info *d)
 }
 #endif
 
-static void auide_setup_ports(struct ide_hw *hw, _auide_hwif *ahwif)
+static void auide_setup_ports(struct ide_hw *hw, struct auide_hwif *ahwif)
 {
-	int i;
 	unsigned long *ata_regs = hw->io_ports_array;
+	unsigned long regbase = (unsigned long)ahwif->regbase;
+	int i;
 
 	/* FIXME? */
 	for (i = 0; i < 8; i++)
-		*ata_regs++ = ahwif->regbase + (i << IDE_REG_SHIFT);
+		*ata_regs++ = regbase + (i << IDE_REG_SHIFT);
 
 	/* set the Alternative Status register */
-	*ata_regs = ahwif->regbase + (14 << IDE_REG_SHIFT);
+	*ata_regs = regbase + (14 << IDE_REG_SHIFT);
 }
 
 #ifdef CONFIG_BLK_DEV_IDE_AU1XXX_PIO_DBDMA
@@ -504,7 +505,7 @@ static const struct ide_port_info au1xxx_port_info = {
 
 static int au_ide_probe(struct platform_device *dev)
 {
-	_auide_hwif *ahwif = &auide_hwif;
+	struct auide_hwif *ahwif = &auide_hwif;
 	struct resource *res;
 	struct ide_host *host;
 	int ret = 0;
@@ -516,7 +517,7 @@ static int au_ide_probe(struct platform_device *dev)
 	char *mode = "PIO+DDMA(offload)";
 #endif
 
-	memset(&auide_hwif, 0, sizeof(_auide_hwif));
+	memset(&auide_hwif, 0, sizeof(struct auide_hwif));
 	ahwif->irq = platform_get_irq(dev, 0);
 
 	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
@@ -532,15 +533,14 @@ static int au_ide_probe(struct platform_device *dev)
 		goto out;
 	}
 
-	if (!request_mem_region(res->start, res->end - res->start + 1,
-				dev->name)) {
+	if (!request_mem_region(res->start, resource_size(res), dev->name)) {
 		pr_debug("%s: request_mem_region failed\n", DRV_NAME);
 		ret =  -EBUSY;
 		goto out;
 	}
 
-	ahwif->regbase = (u32)ioremap(res->start, res->end - res->start + 1);
-	if (ahwif->regbase == 0) {
+	ahwif->regbase = ioremap(res->start, resource_size(res));
+	if (!ahwif->regbase) {
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -568,14 +568,14 @@ static int au_ide_remove(struct platform_device *dev)
 {
 	struct resource *res;
 	struct ide_host *host = platform_get_drvdata(dev);
-	_auide_hwif *ahwif = &auide_hwif;
+	struct auide_hwif *ahwif = &auide_hwif;
 
 	ide_host_remove(host);
 
-	iounmap((void *)ahwif->regbase);
+	iounmap(ahwif->regbase);
 
 	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
-	release_mem_region(res->start, res->end - res->start + 1);
+	release_mem_region(res->start, resource_size(res));
 
 	return 0;
 } 
