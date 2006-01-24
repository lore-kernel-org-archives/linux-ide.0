From: Borislav Petkov <bbpetkov@yahoo.de>
Subject: Re: PATCH convert libata-core to the new debugging scheme
Date: Tue, 24 Jan 2006 20:43:43 +0100
Message-ID: <20060124194343.GB25402@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp102.mail.sc5.yahoo.com ([216.136.174.140]:32868 "HELO
	smtp102.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1030232AbWAXTnr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 24 Jan 2006 14:43:47 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: htejun@gmail.com, randy_d_dunlap@linux.intel.com

On Tue, 24 Jan 2006 22:08:38 +0900
Tejun Heo <htejun@gmail.com> wrote:

First of all, sorry for this "generated" reply but I was not subscribed until
now...

> > Borislav Petkov wrote:
> > > On Tue, Jan 17, 2006 at 10:57:02AM -0800, Randy Dunlap wrote:
> > > Hi Jeff, Randy,
> > >    
> > >    here's a rehash against 2.6.16-rc1 of the 2nd patch I sent then but it somehow 
> > >    got lost along the way. It converts the libata-core.c to the new debugging scheme.
> > > 
> > >    Problem: In the ata_dev_classify() function we don't have access to an 
> > >    ata_host struct probably because we're still probing so maybe we'll have to 
> > >    print debugging statements in a different manner. Same for early init 
> > >    routines like ata_device_add(),  ata_probe_ent_alloc(), ata_pci_init_one().
> > > 
> > >    Also, Jeff, if you'd still like to have a way of setting/getting debugging 
> > >    levels from userspace, please elaborate more on that so that I have some
> > >    directions (ioctl, proc, etc).
> > 
> > I'm not Jeff, but my 5 Won (that's like half a cent) would be on sysfs. 
> >   People hate ioctl and proc these days.
> >
I'll get on it.
> > > 
> > >    Thanks,
> > >    Boris.
> > > 
> > >    p.s. Please CC me since I'm not subscribed to the linux-ide ML.
> > > 
> > >    Signed-off-by: Borislav Petkov <petkov@uni-muenster.de>
> > > 
> > > 
> > > --- 16-rc1/drivers/scsi/libata-core.c.orig	2006-01-21 09:42:53.000000000 +0100
> > > +++ 16-rc1/drivers/scsi/libata-core.c	2006-01-24 09:58:00.000000000 +0100
> > > @@ -115,13 +115,15 @@ static void ata_tf_load_pio(struct ata_p
> > >  		outb(tf->hob_lbal, ioaddr->lbal_addr);
> > >  		outb(tf->hob_lbam, ioaddr->lbam_addr);
> > >  		outb(tf->hob_lbah, ioaddr->lbah_addr);
> > > -		VPRINTK("hob: feat 0x%X nsect 0x%X, lba 0x%X 0x%X 0x%X\n",
> > > -			tf->hob_feature,
> > > -			tf->hob_nsect,
> > > -			tf->hob_lbal,
> > > -			tf->hob_lbam,
> > > -			tf->hob_lbah);
> > > -	}
> > > +		if (ata_msg_ctl(ap)) 
> > > +			printk(KERN_DEBUG "%s: hob: feat 0x%X nsect 0x%X, lba 0x%X 0x%X 0x%X\n",
> > > +				__FUNCTION__,
> > > +				tf->hob_feature,
> > > +				tf->hob_nsect,
> > > +				tf->hob_lbal,
> > > +				tf->hob_lbam,
> > > +				tf->hob_lbah);
> > > +		}
> > 
> > Wouldn't it be better to wrap 'if (ata_msg_ctl(ap)) printk' into some 
> > pretty macro?  Debug messages tend to be long and 8 characters can be 
> > used better.  IMHO, 'if' clauses for debug messages lower readability a bit.
> 
> I agree that a wrapper would be nice.
> Without a wrapper (in this current patch), I see some (new) lines
> that are indented too much, e.g.:
> 
> 	if (ata_msg_err(ap))
> 			printk(KERN_WARNING "%s: ata%u: PIO error\n", __FUNCTION__, ap->id);
> Secondly, we usually try to make source lines fit into 80
> columns, so using a line break after the first comma would be
> Good.
Will do.
> 
> Both of these points apply to multiple places in the patch.
> 
> And here:
> -	DPRINTK("init dev params \n");
> +	if (ata_msg_ctl(ap))
> +			printk(KERN_DEBUG "%s: init dev params \n", __FUNCTION__);
> 
> Drop the space after "params".
> 
> Anyway, back to the more important point.  How can we make
> this more compact (Tejun's wrapper recommendation)?
> 
> Maybe something like (when <ap> is available):
> 
> #define ATA_MSG_CTL(ap, fmt, args)			\
> 			do { if (ata_msg_ctl(ap))	\
> 				printk(KERN_DEBUG "%s: " fmt, \
> 					__FUNCTION__, ## args); \
> 			} while(0)
> 
> or for "?:" fans like me, prints even when <ap> is NULL:
> 
> #define ATA_MSG_CTL(ap, fmt, args)			\
> 			do { if (ap ? ata_msg_ctl(ap) : 1) \
> 				printk(KERN_DEBUG "%s: " fmt, \
> 					__FUNCTION__, ## args); \
> 			} while(0)

Hm, don't know about that, the idea was actually that we implement a sliding
scale for debugging messages in the manner Donald Becker has described in
http://www.scyld.com/pipermail/vortex/2001-November/001426.html. Since we have
different debugging levels we have also different debugging macros of the sort
ata_msg_xxx() and for that matter we'll also have to do different wrapper macros
for the debugging macros which to me _is_ kinda too much. In addition, the
ata_msg_xxx() macros are going to be pretty useless if we wrap them one more
time into other macros but this is only my opinion.

Regards,
		Boris.

	

	
		
___________________________________________________________ 
Telefonate ohne weitere Kosten vom PC zum PC: http://messenger.yahoo.de

