From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 86/86] libata: add private driver field to struct ata_device
Date: Thu, 3 Dec 2009 13:37:41 +0100
Message-ID: <200912031337.41440.bzolnier@gmail.com>
References: <20091125170218.5446.13513.sendpatchset@localhost> <20091125171248.5446.22482.sendpatchset@localhost> <4B177118.5020501@garzik.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754554AbZLCMqK@vger.kernel.org>
In-Reply-To: <4B177118.5020501@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thursday 03 December 2009 09:04:40 am Jeff Garzik wrote:
> On 11/25/2009 12:12 PM, Bartlomiej Zolnierkiewicz wrote:
> > From: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
> > Subject: [PATCH] libata: add private driver field to struct ata_device
> >
> > This brings struct ata_device in-line with struct ata_{port,host}.
> >
> > Signed-off-by: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
> > ---
> >   include/linux/libata.h |    1 +
> >   1 file changed, 1 insertion(+)
> >
> > Index: b/include/linux/libata.h
> > ===================================================================
> > --- a/include/linux/libata.h
> > +++ b/include/linux/libata.h
> > @@ -585,6 +585,7 @@ struct ata_device {
> >   	unsigned int		horkage;	/* List of broken features */
> >   	unsigned long		flags;		/* ATA_DFLAG_xxx */
> >   	struct scsi_device	*sdev;		/* attached SCSI device */
> > +	void			*private_data;
> >   #ifdef CONFIG_ATA_ACPI
> >   	acpi_handle		acpi_handle;
> >   	union acpi_object	*gtf_cache;
> 
> I'm fine with this, and would like to merge this sooner rather than later.
> 
> However, BIG FAT WARNING:  you must take special care to be sure you 
> don't leak as devices appear and disappear, etc.  IOW, watch your object 
> lifetimes carefully.  Object lifetime was the reason this was not added 
> until now.

It should be fine for now as the only user is pata_ep93xx and it gets it
right.  Though it would definitely be nice to see the underlying issue
(which is the lack of dynamic allocation for struct ata_device objects)
fixed one day in libata.

--
Bartlomiej Zolnierkiewicz
