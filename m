From: "Tomita, Haruo" <haruo.tomita@toshiba.co.jp>
Subject: RE: libata-dev queue updated
Date: Fri, 26 Aug 2005 09:04:37 +0900
Message-ID: <BF571719A4041A478005EF3F08EA6DF001617B39__34745.3632545241$1125044929$gmane$org@pcsmail03.pcs.pc.ome.toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from inet-tsb.toshiba.co.jp ([202.33.96.40]:39296 "EHLO
	inet-tsb.toshiba.co.jp") by vger.kernel.org with ESMTP
	id S965029AbVHZAHh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 25 Aug 2005 20:07:37 -0400
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, "Tomita, Haruo" <haruo.tomita@toshiba.co.jp>

On  Thursday, August 25, 2005 8:02 PM (JST), Adrian Bunk wrote:

> > 2.6.13- rc7-libata1.patch.bz2 was used. 
> > A combined mode of ata_piix seems not to work. 
> > Is the following patches correct?
> > 
> > diff -urN linux-2.6.13-rc7.orig/drivers/scsi/Kconfig 
> linux-2.6.13-rc7/drivers/scsi/Kconfig
> > --- linux-2.6.13-rc7.orig/drivers/scsi/Kconfig	
> 2005-08-25 13:44:33.000000000 +0900
> > +++ linux-2.6.13-rc7/drivers/scsi/Kconfig	2005-08-25 
> 14:33:38.000000000 +0900
> > @@ -424,7 +424,7 @@
> >  source "drivers/scsi/megaraid/Kconfig.megaraid"
> >  
> >  config SCSI_SATA
> > -	tristate "Serial ATA (SATA) support"
> > +	bool "Serial ATA (SATA) support"
> >  	depends on SCSI
> >  	help
> >  	  This driver family supports Serial ATA host controllers
> 
> No, this bug reintroduces a problem with SCSI=m.

Please explain this bug in detail. 

> Which problem do you face?
> And how did this change alone fix it for you?

I am using Intel 82801EB SATA controller.
2.6.13-rc7-libata1.patch.bz2 worked as PATA when 82801EB was used in a combined mode. 
Does quirk_intel_ide_combined() work effectively?

Thanks,
Haruo
