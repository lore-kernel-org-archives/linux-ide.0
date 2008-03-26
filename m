From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH] ata-acpi: don't call _GTF for disabled drive
Date: Wed, 26 Mar 2008 09:13:16 +0800
Message-ID: <1206493996.14062.0.camel@sli10-desk.sh.intel.com>
References: <1206435045.23794.13.camel@sli10-desk.sh.intel.com>
	 <200803252150.20609.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:61130 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752424AbYCZBNW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 Mar 2008 21:13:22 -0400
In-Reply-To: <200803252150.20609.rjw@sisk.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux acpi <linux-acpi@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>, Len Brown <lenb@kernel.org>, Jeff Garzik <jgarzik@pobox.com>


On Tue, 2008-03-25 at 21:50 +0100, Rafael J. Wysocki wrote:
> On Tuesday, 25 of March 2008, Shaohua Li wrote:
> > I got below log after a S3 resume in a ASUS A6VC laptop. The system has
> > only one IDE drive. It appears there is no reason calling _GTF for
> > disabled drive.
> > 
> > ACPI Error (dsopcode-0483): Attempt to CreateField of length zero [20070126]
> > ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.RATA] (Node df822a7c), AE_AML_OPERAND_VALUE
> > ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.CHN1.DRV0._GTF] (Node df822bd0), AE_AML_OPERAND_VALUE
> > ata2.00: _GTF evaluation failed (AE 0x3006)
> > ACPI Error (dsopcode-0483): Attempt to CreateField of length zero [20070126]
> > ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.RATA] (Node df822a7c), AE_AML_OPERAND_VALUE
> > ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.CHN1.DRV1._GTF] (Node df822b94), AE_AML_OPERAND_VALUE
> > ata2.01: _GTF evaluation failed (AE 0x3006)
> > 
> > Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> > 
> > diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
> > index bf98a56..7cbf023 100644
> > --- a/drivers/ata/libata-acpi.c
> > +++ b/drivers/ata/libata-acpi.c
> > @@ -839,7 +839,8 @@ void ata_acpi_on_resume(struct ata_port *ap)
> >  		 */
> >  		ata_link_for_each_dev(dev, &ap->link) {
> >  			ata_acpi_clear_gtf(dev);
> 
> Hmm.  What is the effect of calling ata_acpi_clear_gtf() on a disabled device? 
No effect, just free some memory if there is.

Thanks,
Shaohua

