From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [PATCH] libata: Power off empty ports
Date: Fri, 4 Mar 2011 10:47:56 -0800
Message-ID: <20110304104756.20451b33@kcaccard-MOBL3>
References: <20110304090644.GC20499@htj.dyndns.org>
	<1299263051-3739-1-git-send-email-kristen@linux.intel.com>
	<20110304183836.GZ20499@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:16392 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932436Ab1CDSpj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Mar 2011 13:45:39 -0500
In-Reply-To: <20110304183836.GZ20499@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On Fri, 4 Mar 2011 19:38:36 +0100
Tejun Heo <tj@kernel.org> wrote:

> Hello,
> 
> On Fri, Mar 04, 2011 at 10:24:11AM -0800, Kristen Carlson Accardi wrote:
> >  	case ATA_LPM_MIN_POWER:
> > -		/* no restrictions on LPM transitions */
> > -		scontrol &= ~(0x3 << 8);
> > +		if (ata_link_nr_enabled(link) > 0)
> > +			/* no restrictions on LPM transitions */
> > +			scontrol &= ~(0x3 << 8);
> > +		else {
> > +			/* empty port, power off */
> > +			scontrol &= ~0xf;
> > +			scontrol |= (0x1 << 2);
> > +		}
> 
> Why not just do the following?
> 
> 	scontrol &= ~(0x3 << 8);

because, the IPM value is meaningless if we have no devices,
so this is a wasted operation.

> 	/* if empty, power off */
> 	if (!ata_link_nr_enabled(link)) {
> 		scontrol &= ~0xf;
> 		scontrol |= 0x1 << 2;
> 	}
> 
> Also, can you please provide some details on on which hardware you
> tested the change and how much power it actually saved?
>

This change was tested on Intel's Sandy Bridge platform.  Your power
savings will depend on how many implemented ports you have, and how
many are not being used.  For a system I tested with which had 2 ports
which I could turn off, I saved 300mW.
 
