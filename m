From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [PATCH v2] ahci: qoriq: fixed using uninitialized variable
 warnings
Date: Fri, 11 Sep 2015 11:31:06 +0800
Message-ID: <20150911033106.GA15477@wfg-t540p.sh.intel.com>
References: <1441869212-14695-1-git-send-email-Yuantian.Tang@freescale.com>
 <20150910142214.GA8114@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:4156 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751042AbbIKDbJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 10 Sep 2015 23:31:09 -0400
Content-Disposition: inline
In-Reply-To: <20150910142214.GA8114@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Yuantian.Tang@freescale.com, hdegoede@redhat.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Tejun, Yuantian,

On Thu, Sep 10, 2015 at 10:22:14AM -0400, Tejun Heo wrote:
> (cc'ing Fengguang, hi!)
> 
> Fengguang, this is about kbuild test robot warning titled
> "drivers/ata/ahci_qoriq.c:70:6: warning: 'px_cmd' may be used
> uninitialized in this function".  Yuantian can't reproduce the warning
> and I'm wondering whether the below patch would make the warning go
> away.  Which gcc was the build bot using?

It's gcc-4.5.1-or32-1.0rc1. The reproduce steps are:

  wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
  chmod +x ~/bin/make.cross
  git checkout ecfb4598512a7c3e21df2941db58c10461583bb9

# this command will auto download/install openrisc cross compiler

  make.cross ARCH=openrisc allyesconfig
  make.cross ARCH=openrisc drivers/ata/ahci_qoriq.o

> Would it be possible to
> verify that the following patch makes the warning go away?

With the patch applied, the warnings are still there:

wfg@inn ~/linux/obj-compiletest% make ARCH=openrisc drivers/ata/ahci_qoriq.o
/usr/bin/make -C source O=/home/wfg/linux/obj-compiletest ARCH=openrisc CROSS_COMPILE=/usr/local/gcc-4.5.1-nolibc/or32-linux/bin/or32-linux- -j32 ARCH=openrisc drivers/
ata/ahci_qoriq.o                                                                                                                                                        make: Entering directory '/c/wfg/linux'
make[1]: Entering directory '/c/wfg/linux/obj-compiletest'
  CHK     include/config/kernel.release
  GEN     ./Makefile
  CHK     include/generated/uapi/linux/version.h
  UPD     include/config/kernel.release
  Using .. as source for kernel
  CHK     include/generated/utsrelease.h
  UPD     include/generated/utsrelease.h
  CHK     include/generated/timeconst.h
  CHK     include/generated/bounds.h
  CHK     include/generated/asm-offsets.h
  CALL    ../scripts/checksyscalls.sh
<stdin>:1298:2: warning: #warning syscall userfaultfd not implemented
  CC      drivers/ata/ahci_qoriq.o
../drivers/ata/ahci_qoriq.c: In function 'ahci_qoriq_hardreset':
../drivers/ata/ahci_qoriq.c:70:6: warning: 'px_cmd' may be used uninitialized in this function
../drivers/ata/ahci_qoriq.c:70:14: warning: 'px_is' may be used uninitialized in this function
make[1]: Leaving directory '/c/wfg/linux/obj-compiletest'
make: Leaving directory '/c/wfg/linux'

Thanks,
Fengguang

> On Thu, Sep 10, 2015 at 03:13:32PM +0800, Yuantian.Tang@freescale.com wrote:
> > From: Tang Yuantian <Yuantian.Tang@freescale.com>
> > 
> > kbuild test robot reports the warnings:
> > drivers/ata/ahci_qoriq.c: In function 'ahci_qoriq_hardreset':
> > >> include/asm-generic/io.h:163:2: warning: 'px_is' may be used
> > >> uninitialized in this function [-Wuninitialized]
> > drivers/ata/ahci_qoriq.c:70:14: note: 'px_is' was declared here
> > >> include/asm-generic/io.h:163:2: warning: 'px_cmd' may be used
> > >> uninitialized in this function [-Wuninitialized]
> > drivers/ata/ahci_qoriq.c:70:6: note: 'px_cmd' was declared here
> > 
> > This patch fixed it by making type as a local variable.
> > 
> > Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> > ---
> > v2:
> > 	- try another way to fix the warnings
> > 	- remove clean up code
> > 
> >  drivers/ata/ahci_qoriq.c | 13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
> > index e5e4988..0d06e76 100644
> > --- a/drivers/ata/ahci_qoriq.c
> > +++ b/drivers/ata/ahci_qoriq.c
> > @@ -48,9 +48,9 @@ enum ahci_qoriq_type {
> >  	AHCI_LS2085A,
> >  };
> >  
> > +enum ahci_qoriq_type type;
> >  struct ahci_qoriq_priv {
> >  	struct ccsr_ahci *reg_base;
> > -	enum ahci_qoriq_type type;
> >  	void __iomem *ecc_addr;
> >  };
> >  
> > @@ -71,7 +71,6 @@ static int ahci_qoriq_hardreset(struct ata_link *link, unsigned int *class,
> >  	struct ata_port *ap = link->ap;
> >  	struct ahci_port_priv *pp = ap->private_data;
> >  	struct ahci_host_priv *hpriv = ap->host->private_data;
> > -	struct ahci_qoriq_priv *qoriq_priv = hpriv->plat_data;
> >  	u8 *d2h_fis = pp->rx_fis + RX_FIS_D2H_REG;
> >  	struct ata_taskfile tf;
> >  	bool online;
> > @@ -92,7 +91,7 @@ static int ahci_qoriq_hardreset(struct ata_link *link, unsigned int *class,
> >  	 * After the sequence is complete, software should restore the
> >  	 * PxCMD and PxIS with the stored values.
> >  	 */
> > -	if (qoriq_priv->type == AHCI_LS1021A) {
> > +	if (type == AHCI_LS1021A) {
> >  		px_cmd = readl(port_mmio + PORT_CMD);
> >  		px_is = readl(port_mmio + PORT_IRQ_STAT);
> >  	}
> > @@ -106,7 +105,7 @@ static int ahci_qoriq_hardreset(struct ata_link *link, unsigned int *class,
> >  				 ahci_check_ready);
> >  
> >  	/* restore the PxCMD and PxIS on ls1021 */
> > -	if (qoriq_priv->type == AHCI_LS1021A) {
> > +	if (type == AHCI_LS1021A) {
> >  		px_val = readl(port_mmio + PORT_CMD);
> >  		if (px_val != px_cmd)
> >  			writel(px_cmd, port_mmio + PORT_CMD);
> > @@ -146,7 +145,7 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
> >  	struct ahci_qoriq_priv *qpriv = hpriv->plat_data;
> >  	void __iomem *reg_base = hpriv->mmio;
> >  
> > -	switch (qpriv->type) {
> > +	switch (type) {
> >  	case AHCI_LS1021A:
> >  		writel(SATA_ECC_DISABLE, qpriv->ecc_addr);
> >  		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
> > @@ -188,9 +187,9 @@ static int ahci_qoriq_probe(struct platform_device *pdev)
> >  	if (!qoriq_priv)
> >  		return -ENOMEM;
> >  
> > -	qoriq_priv->type = (enum ahci_qoriq_type)of_id->data;
> > +	type = (enum ahci_qoriq_type)of_id->data;
> >  
> > -	if (qoriq_priv->type == AHCI_LS1021A) {
> > +	if (type == AHCI_LS1021A) {
> >  		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> >  				"sata-ecc");
> >  		qoriq_priv->ecc_addr = devm_ioremap_resource(dev, res);
> > -- 
> > 2.1.0.27.g96db324
> > 
> 
> -- 
> tejun
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
