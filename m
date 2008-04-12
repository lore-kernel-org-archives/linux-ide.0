From: "Anantha Subramanyam" <ananth@broadcom.com>
Subject: RE: [PATCH] sata_svw: 0x0241 has 8 ports not 4
Date: Fri, 11 Apr 2008 18:11:51 -0700
Message-ID: <03235919BBDE634289BB6A0758A20B36041AE3CE@NT-SJCA-0751.brcm.ad.broadcom.com>
References: <47FD6574.8020202@gmail.com> <47FFE51F.3000906@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mms2.broadcom.com ([216.31.210.18]:3934 "EHLO mms2.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756976AbYDLBKl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 11 Apr 2008 21:10:41 -0400
Content-class: urn:content-classes:message
In-Reply-To: <47FFE51F.3000906@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, y_honda_@d1.dion.ne.jp

 

> -----Original Message-----
> From: Jeff Garzik [mailto:jeff@garzik.org] 
> Sent: Friday, April 11, 2008 3:25 PM
> To: Tejun Heo
> Cc: IDE/ATA development list; y_honda_@d1.dion.ne.jp; 
> Benjamin Herrenschmidt; Anantha Subramanyam
> Subject: Re: [PATCH] sata_svw: 0x0241 has 8 ports not 4
> 
> Tejun Heo wrote:
> > From: Yohei Honda <y_honda_@d1.dion.ne.jp>
> > 
> > 0x0241 has 8 ports not 4.
> > 
> > Reported by Yohei Honda on kernel bz 10424.
> > 
> > Signed-off-by: Tejun Heo <htejun@gmail.com>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > ---
> > Benjamin, can you please verify this is correct?
> > 
> > drivers/ata/sata_svw.c |    2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
> > index 840d1c4..75c6853 100644
> > --- a/drivers/ata/sata_svw.c
> > +++ b/drivers/ata/sata_svw.c
> > @@ -531,7 +531,7 @@ static int k2_sata_init_one(struct 
> pci_dev *pdev, 
> > const struct pci_device_id *en
> >  * */
> > static const struct pci_device_id k2_sata_pci_tbl[] = {
> >     { PCI_VDEVICE(SERVERWORKS, 0x0240), chip_svw4 },
> > -    { PCI_VDEVICE(SERVERWORKS, 0x0241), chip_svw4 },
> > +    { PCI_VDEVICE(SERVERWORKS, 0x0241), chip_svw8 },
> >     { PCI_VDEVICE(SERVERWORKS, 0x0242), chip_svw8 },
> >     { PCI_VDEVICE(SERVERWORKS, 0x024a), chip_svw4 },
> >     { PCI_VDEVICE(SERVERWORKS, 0x024b), chip_svw4 },
> 
> This is wrong according to my docs.
> 
> Anantha, can you provide a definitive answer?
> 
> Does PCI ID 0x241 support 4 ports or 8 ports?
> 
> Thanks,
> 
> 	Jeff
> 
> 

0x241 is 8 ports
0x242 is 4 ports

Thanks,

Ananth

