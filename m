From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: HPA patches
Date: Fri, 23 Mar 2007 20:08:19 +0000
Message-ID: <20070323200819.4e734f4f@lxorguk.ukuu.org.uk>
References: <20070323191321.5d00887a@lxorguk.ukuu.org.uk>
	<20070323112411.f6a8a762.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.2.110.250] ([81.2.110.250]:60147 "EHLO lxorguk.ukuu.org.uk"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S932067AbXCWTFF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Mar 2007 15:05:05 -0400
In-Reply-To: <20070323112411.f6a8a762.randy.dunlap@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, kyle@canonical.com

> > +static int ata_ignore_hpa = 0;
> 
> Don't init to 0.  Not needed, bloats binary files.

It'll be one for the final release 8)

> > +module_param_named(ignore_hpa, ata_ignore_hpa, int, 0644);
> > +MODULE_PARM_DESC(ignore_hpa, "Ignore HPA (0=off 1=on)");
> 
> So 1 = on = ignore, right?

Yes.

> > +	tf.command = ATA_CMD_READ_NATIVE_MAX_EXT;
> > +	tf.flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_LBA48 | ATA_TFLAG_ISADDR;
> > +	tf.protocol |= ATA_PROT_NODATA;
> > +	tf.device = 0x40;
> 
> What is 0x40?  can it be #defined (or enum-ed) instead of a magic
> value?  please?  (more of same below)

It's 0x40. Its a "command dependant bit" - no useful name.

> > +	u64 sectors = dev->n_sectors;
> > +	u64 hpa_sectors;
> > +	
> > +	if (ata_id_has_lba48(dev->id))
> > +		hpa_sectors = ata_read_native_max_address_ext(dev);
> > +	else
> > +		hpa_sectors = ata_read_native_max_address(dev);
> > +
> > +	/* if no hpa, both should be equal */
> > +	ata_dev_printk(dev, KERN_INFO, "%s 1: sectors = %lld, hpa_sectors = %lld\n",
> > +		__FUNCTION__, sectors, hpa_sectors);
> 
> (long long) or (unsigned long long) on sectors and hpa_sectors...

u64 is always unsigned long long (and its debug anyway)

> 
> > +
> > +	if (hpa_sectors > sectors) {
> > +		ata_dev_printk(dev, KERN_INFO,
> > +			"Host Protected Area detected:\n"
> > +			"\tcurrent size: %lld sectors\n"
> > +			"\tnative size: %lld sectors\n",
> > +			sectors, hpa_sectors);
> 
> printk format types ok?

Yes

> > +			if (hpa_sectors) {
> > +				ata_dev_printk(dev, KERN_INFO,
> > +					"native size increased to %lld sectors\n", hpa_sectors);
> 
> Line lengths < 80 and printk format types?

See above, and the 80 column fascists can suffer in the name of
readability. 

Alan
