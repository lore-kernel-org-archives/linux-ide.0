From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: HPA patches
Date: Fri, 23 Mar 2007 13:03:15 -0700
Message-ID: <20070323130315.7ed48121.randy.dunlap@oracle.com>
References: <20070323191321.5d00887a@lxorguk.ukuu.org.uk>
	<20070323112411.f6a8a762.randy.dunlap@oracle.com>
	<20070323200819.4e734f4f@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rgminet01.oracle.com ([148.87.113.118]:26354 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992547AbXCWUDF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Mar 2007 16:03:05 -0400
In-Reply-To: <20070323200819.4e734f4f@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, kyle@canonical.com

On Fri, 23 Mar 2007 20:08:19 +0000 Alan Cox wrote:

> > > +static int ata_ignore_hpa = 0;
> > 
> > Don't init to 0.  Not needed, bloats binary files.
> 
> It'll be one for the final release 8)
> 
> > > +module_param_named(ignore_hpa, ata_ignore_hpa, int, 0644);
> > > +MODULE_PARM_DESC(ignore_hpa, "Ignore HPA (0=off 1=on)");
> > 
> > So 1 = on = ignore, right?
> 
> Yes.
> 
> > > +	tf.command = ATA_CMD_READ_NATIVE_MAX_EXT;
> > > +	tf.flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_LBA48 | ATA_TFLAG_ISADDR;
> > > +	tf.protocol |= ATA_PROT_NODATA;
> > > +	tf.device = 0x40;
> > 
> > What is 0x40?  can it be #defined (or enum-ed) instead of a magic
> > value?  please?  (more of same below)
> 
> It's 0x40. Its a "command dependant bit" - no useful name.

dependent.  OK, thanks.

> > > +	u64 sectors = dev->n_sectors;
> > > +	u64 hpa_sectors;
> > > +	
> > > +	if (ata_id_has_lba48(dev->id))
> > > +		hpa_sectors = ata_read_native_max_address_ext(dev);
> > > +	else
> > > +		hpa_sectors = ata_read_native_max_address(dev);
> > > +
> > > +	/* if no hpa, both should be equal */
> > > +	ata_dev_printk(dev, KERN_INFO, "%s 1: sectors = %lld, hpa_sectors = %lld\n",
> > > +		__FUNCTION__, sectors, hpa_sectors);
> > 
> > (long long) or (unsigned long long) on sectors and hpa_sectors...
> 
> u64 is always unsigned long long (and its debug anyway)
> 
> > 
> > > +
> > > +	if (hpa_sectors > sectors) {
> > > +		ata_dev_printk(dev, KERN_INFO,
> > > +			"Host Protected Area detected:\n"
> > > +			"\tcurrent size: %lld sectors\n"
> > > +			"\tnative size: %lld sectors\n",
> > > +			sectors, hpa_sectors);
> > 
> > printk format types ok?
> 
> Yes
> 
> > > +			if (hpa_sectors) {
> > > +				ata_dev_printk(dev, KERN_INFO,
> > > +					"native size increased to %lld sectors\n", hpa_sectors);
> > 
> > Line lengths < 80 and printk format types?
> 
> See above, and the 80 column fascists can suffer in the name of
> readability. 

Already corrected (printk types).  And putting
					hpa_sectors);
on a separate line doesn't hurt readability.

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
