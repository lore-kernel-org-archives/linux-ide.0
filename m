From: Erik Benada <erikbenada@yahoo.ca>
Subject: Re: [PATCH] PATA port support for PDC2037x
Date: Thu, 30 Sep 2004 09:22:30 -0400 (EDT)
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040930132230.34913.qmail@web60308.mail.yahoo.com>
References: <415B7FEA.2060209@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web60308.mail.yahoo.com ([216.109.118.119]:1700 "HELO
	web60308.mail.yahoo.com") by vger.kernel.org with SMTP
	id S269250AbUI3NWd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Sep 2004 09:22:33 -0400
In-Reply-To: <415B7FEA.2060209@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Hi Jeff,

I can work on support for multiple ata_port_operations. It just seemed to me as unnecessary big
change to libata. You would need separate ata_port_operations for each port regardless - even if
they are the same.
What do you think about moving ata_port_operations from ata_host_set structure to ata_port
structure? It would make sense if you want separate ata_port_operations for each port.
Let me know.

  Erik

 --- Jeff Garzik <jgarzik@pobox.com> wrote: 
> Erik Benada wrote:
> > Jeff,
> > 
> > included is patch to add support for PATA port on Promise PDC2037x controllers.
> > Patch is against 2.6.8.1 vanilla kernel.
> > I tested this patch on my PDC20378 on-board controller with 1 PATA drive attached.
> > I didn't do any large testing but my drive was detected properly and I was able to 
> > mount and use filesystem on it.
> > 
> > I tried to minimize changes to libata code. I just added flags for each port to ata_probe_ent
> > structure and modified ata_host_init() function. 
> > 
> > Promise SATA driver was changed to use new ata_probe_ent->port_flags, check for presence of
> > PATA port and pdc_phy_reset will use different reset code for PATA and SATA ports.
> > 
> > Any comments, suggestions?
> 
> 
> Very nice!
> 
> I don't see any bugs in the code...  my main concern is that I 
> definitely want to see host controllers (struct ata_host_set) support 
> multiple ata_port_operations structures.  That would eliminate the need 
> to do
> 
> +	if (ap->flags & ATA_FLAG_SATA)
> +		sata_phy_reset(ap);
> +	else
> +		pdc_pata_phy_reset(ap);
> 
> and also eliminate a few other roadblocks.
> 
> However, implementing such is not a simple as your solution.
> 
> I will definitely merge this patch into my libata-dev queue, so that 
> others can download and test it (and/or simply get their PATA port 
> working).  We'll see where it goes from there.   If nobody (including 
> me) implements the ata_port_operations solution I described, then I will 
> probably push this into upstream 2.6.x as an incremental step towards 
> the proper solution.
> 
> Thanks,
> 
> 	Jeff
> 
> 
> 
> 
>  

______________________________________________________________________ 
Post your free ad now! http://personals.yahoo.ca
