From: Ericisko <linux2@rogers.com>
Subject: Re: Pata support on Promise controller under Fedora Core 3
Date: Wed, 27 Oct 2004 09:58:00 -0400 (EDT)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20041027135800.77927.qmail@web88007.mail.re2.yahoo.com>
References: <006101c4baed$f3b46d80$0c01a8c0@nugget>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web88007.mail.re2.yahoo.com ([206.190.37.194]:22714 "HELO
	web88007.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S262452AbUJ0N6E (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 27 Oct 2004 09:58:04 -0400
In-Reply-To: <006101c4baed$f3b46d80$0c01a8c0@nugget>
List-Id: linux-ide@vger.kernel.org
To: "James C. Bevier" <jbev@jbsys.com>
Cc: linux-ide@vger.kernel.org

James,

you have the same controller as me (PDC20378) which
has only 1 PATA port. PATA ports support up to 2
devices per port, as opposed to SATA ports which
support only 1 device per port.
There is source code for 2.4 linux driver on Promise
web site, you can have a look.
Could you send your dmesg output?

  Erik

 --- "James C. Bevier" <jbev@jbsys.com> wrote: 
> I have played around with the driver patches a
> little
> and I think the folowing code needs some
> modifications
> to work on the ASUS MB Promise controller.
> 
>   case board_2037x:
> -         probe_ent->n_ports = 2;
> +  /* Some boards have also PATA port */
> +  tmp = readb(base + PDC_FLASH_CTL+1);
> +  if (!(tmp & 0x80))
> +  {
> + //  probe_ent->n_ports = 3;
> +   probe_ent->n_ports = 4;                       //
> I think this should be
> 4
> +   pdc_sata_setup_port(&probe_ent->port[2], base +
> 0x300);
> +   pdc_sata_setup_port(&probe_ent->port[3], base +
> 0x380);  // this does
> not work, need port address
> +   probe_ent->port_flags[2] = ATA_FLAG_SLAVE_POSS;
> +   probe_ent->port_flags[3] = ATA_FLAG_SLAVE_POSS; 
>  // this needs to be
> there for 2nd pata disk
> +   printk(KERN_INFO DRV_NAME " PATA port found\n");
> +  }
> +  else
> +          probe_ent->n_ports = 2;
>    break;
> 
> I think if I had the valid port address, it might
> work.  Do you have it?
> 
> Jim
> 
> 
> ----- Original Message ----- 
> From: "Ericisko" <linux2@rogers.com>
> To: "James C. Bevier" <jbev@jbsys.com>; "Jeff
> Garzik" <jgarzik@pobox.com>
> Cc: <linux-ide@vger.kernel.org>
> Sent: Tuesday, October 26, 2004 4:17 AM
> Subject: Re: Pata support on Promise controller
> under Fedora Core 3
> 
> 
> > James,
> >
> > I don't have any additional code. I quickly tested
> it
> > on my system (PDC20378) and both drives were
> > recognized.
> > However, I've got hard lockup after about 1 min.
> It is
> > with vanilla 2.6.9-rc3, smp, preempt enabled.
> Didn't
> > have time to investigate further.
> > Are your drives recognized by BIOS? Also, AFAIK
> PATA
> > port on 378 supports only ATA (disk) drives, not
> ATAPI
> > drives (CD/DVD). Is your second drive disk or
> CD/DVD?
> >
> >   Erik
> >
> >  --- "James  C. Bevier" <jbev@jbsys.com> wrote:
> > > Jeff,
> > >
> > > I cut out the attached patch from the
> sata_promise
> > > dev patches on kernel.org.  I
> > > put it in the latest kernel in Fedora Core 3
> RC1.
> > > It is version 2.6.9-1.640
> > > kernel.  It works well enough to be able to see
> the
> > > first PATA drive on the
> > > Promise controller.  It does not see the second
> > > drive.  The code only seems to
> > > work for one drive.  Could you (or Erik) provide
> the
> > > rest of the code that will
> > > see the second drive.  If you could point me to
> > > specs for the controller or give
> > > me the register offset for the last drive, I
> could
> > > try to hack at it myself.  I
> > > really need this to work in Fedora Core 3.
> > >
> > > Thanks for your help!
> > >
> > > Jim Bevier
> > >
> >
> > > ATTACHMENT part 2 application/octet-stream
> > name=linux-2.6.9-sata_promise.patch
> >  )
> >
> 
>  
