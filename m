From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ata-acpi: don't call _GTF for disabled drive
Date: Wed, 26 Mar 2008 02:23:15 +0100
Message-ID: <200803260223.16847.rjw@sisk.pl>
References: <1206435045.23794.13.camel@sli10-desk.sh.intel.com> <200803252150.20609.rjw@sisk.pl> <1206493996.14062.0.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1206493996.14062.0.camel@sli10-desk.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>, Len Brown <lenb@kernel.org>, Jeff Garzik <jgarzik@pobox.com>
List-Id: linux-ide@vger.kernel.org

On Wednesday, 26 of March 2008, Shaohua Li wrote:
> 
> On Tue, 2008-03-25 at 21:50 +0100, Rafael J. Wysocki wrote:
> > On Tuesday, 25 of March 2008, Shaohua Li wrote:
> > > I got below log after a S3 resume in a ASUS A6VC laptop. The system has
> > > only one IDE drive. It appears there is no reason calling _GTF for
> > > disabled drive.
> > > 
> > > ACPI Error (dsopcode-0483): Attempt to CreateField of length zero [20070126]
> > > ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.RATA] (Node df822a7c), AE_AML_OPERAND_VALUE
> > > ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.CHN1.DRV0._GTF] (Node df822bd0), AE_AML_OPERAND_VALUE
> > > ata2.00: _GTF evaluation failed (AE 0x3006)
> > > ACPI Error (dsopcode-0483): Attempt to CreateField of length zero [20070126]
> > > ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.RATA] (Node df822a7c), AE_AML_OPERAND_VALUE
> > > ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.IDE0.CHN1.DRV1._GTF] (Node df822b94), AE_AML_OPERAND_VALUE
> > > ata2.01: _GTF evaluation failed (AE 0x3006)
> > > 
> > > Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> > > 
> > > diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
> > > index bf98a56..7cbf023 100644
> > > --- a/drivers/ata/libata-acpi.c
> > > +++ b/drivers/ata/libata-acpi.c
> > > @@ -839,7 +839,8 @@ void ata_acpi_on_resume(struct ata_port *ap)
> > >  		 */
> > >  		ata_link_for_each_dev(dev, &ap->link) {
> > >  			ata_acpi_clear_gtf(dev);
> > 
> > Hmm.  What is the effect of calling ata_acpi_clear_gtf() on a disabled device? 
> No effect, just free some memory if there is.

Ah, ok.

I just wondered why not to do "if (!ata_dev_enabled(dev)) continue" in both
loops.

Thanks,
Rafael
