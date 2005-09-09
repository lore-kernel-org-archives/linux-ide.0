From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: Re: [git patch] libata fixes
Date: Fri, 09 Sep 2005 11:30:02 +0200
Message-ID: <4321561A.7040904@gmx.net>
References: <20050909031207.GA25014@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from imap.gmx.net ([213.165.64.20]:12010 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030198AbVIIJaE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Sep 2005 05:30:04 -0400
In-Reply-To: <20050909031207.GA25014@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Hello Jeff,

i have seen you have corrected a bug with a unused variable in
sata_sis.c. one time.
But i have seen this problem 2 times.

my git data are not acually i have used.
git pull
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
git checkout -f upstream

may be it is already fixed.

diff --git a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
@@ -159,17 +161,17 @@ static u32 sis_scr_cfg_read (struct ata_
 {
        struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
        unsigned int cfg_addr = get_scr_cfg_addr(ap->port_no, sc_reg,
pdev->device);
-       u32 val, val2;
+       u32 val, val2 = 0;
        u8 pmr;

        if (sc_reg == SCR_ERROR) /* doesn't exist in PCI cfg space */
                return 0xffffffff;

        pci_read_config_byte(pdev, SIS_PMR, &pmr);
-
+
        pci_read_config_dword(pdev, cfg_addr, &val);

-       if ((pdev->device == 0x182) || (pmr & SIS_PMR_COMBINED))
+       if ((pdev->device == 0x182) || (pmr & SIS_PMR_COMBINED))
                pci_read_config_dword(pdev, cfg_addr+0x10, &val2);

        return val|val2;





>Please pull from 'upstream' branch of
>master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
>
>to obtain fixes for last-minute problems noticed in current build,
>following GregKH's PCI merge.
>
>
> drivers/scsi/sata_mv.c  |   16 ----------------
> drivers/scsi/sata_sis.c |   20 +++++++++++---------
> 2 files changed, 11 insertions(+), 25 deletions(-)
>
>
>
>diff --git a/drivers/scsi/sata_sis.c b/drivers/scsi/sata_sis.c
>--- a/drivers/scsi/sata_sis.c
>+++ b/drivers/scsi/sata_sis.c
>@@ -55,7 +55,7 @@ enum {
> 	SIS180_SATA1_OFS	= 0x10, /* offset from sata0->sata1 phy regs */
> 	SIS182_SATA1_OFS	= 0x20, /* offset from sata0->sata1 phy regs */
> 	SIS_PMR			= 0x90, /* port mapping register */
>-	SIS_PMR_COMBINED	= 0x30, 
>+	SIS_PMR_COMBINED	= 0x30,
> 
> 	/* random bits */
> 	SIS_FLAG_CFGSCR		= (1 << 30), /* host flag: SCRs via PCI cfg */
>@@ -147,11 +147,13 @@ static unsigned int get_scr_cfg_addr(uns
> {
> 	unsigned int addr = SIS_SCR_BASE + (4 * sc_reg);
> 
>-	if (port_no) 
>+	if (port_no)  {
> 		if (device == 0x182)
> 			addr += SIS182_SATA1_OFS;
> 		else
> 			addr += SIS180_SATA1_OFS;
>+	}
>+
> 	return addr;
> }
> 
>@@ -166,10 +168,10 @@ static u32 sis_scr_cfg_read (struct ata_
> 		return 0xffffffff;
> 
> 	pci_read_config_byte(pdev, SIS_PMR, &pmr);
>-	
>+
> 	pci_read_config_dword(pdev, cfg_addr, &val);
> 
>-	if ((pdev->device == 0x182) || (pmr & SIS_PMR_COMBINED)) 
>+	if ((pdev->device == 0x182) || (pmr & SIS_PMR_COMBINED))
> 		pci_read_config_dword(pdev, cfg_addr+0x10, &val2);
> 
> 	return val|val2;
>@@ -185,7 +187,7 @@ static void sis_scr_cfg_write (struct at
> 		return;
> 
> 	pci_read_config_byte(pdev, SIS_PMR, &pmr);
>-	
>+
> 	pci_write_config_dword(pdev, cfg_addr, val);
> 
> 	if ((pdev->device == 0x182) || (pmr & SIS_PMR_COMBINED))
>@@ -195,7 +197,7 @@ static void sis_scr_cfg_write (struct at
> static u32 sis_scr_read (struct ata_port *ap, unsigned int sc_reg)
> {
> 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
>-	u32 val,val2;
>+	u32 val, val2 = 0;
> 	u8 pmr;
> 
> 	if (sc_reg > SCR_CONTROL)
>@@ -209,9 +211,9 @@ static u32 sis_scr_read (struct ata_port
> 	val = inl(ap->ioaddr.scr_addr + (sc_reg * 4));
> 
> 	if ((pdev->device == 0x182) || (pmr & SIS_PMR_COMBINED))
>-		val2 = inl(ap->ioaddr.scr_addr + (sc_reg * 4)+0x10);
>+		val2 = inl(ap->ioaddr.scr_addr + (sc_reg * 4) + 0x10);
> 
>-	return val|val2;
>+	return val | val2;
> }
> 
> static void sis_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val)
>@@ -223,7 +225,7 @@ static void sis_scr_write (struct ata_po
> 		return;
> 
> 	pci_read_config_byte(pdev, SIS_PMR, &pmr);
>-	
>+
> 	if (ap->flags & SIS_FLAG_CFGSCR)
> 		sis_scr_cfg_write(ap, sc_reg, val);
> 	else {
>-
>  
>

