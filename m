From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 3/6] The definition of ahci_port_standby() and ahci_port_spinup()
Date: Sat, 3 Jun 2006 15:16:30 -0400
Message-ID: <20060603191630.GB27742@havoc.gtf.org>
References: <1149234328.13451.56.camel@forrest26.sh.intel.com> <20060603132354.GC25958@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:19397 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751789AbWFCTRG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Jun 2006 15:17:06 -0400
Content-Disposition: inline
In-Reply-To: <20060603132354.GC25958@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, forrest.zhao@intel.com
Cc: hare@suse.de, axboe@suse.de, jeremy@goop.org, lkml@rtr.ca, linux-ide@vger.kernel.org


General comment:

I don't have code+specs+testbox in front of me, so I can only offer
general [from the airport :)] advice:

Under AHCI particularly, -not- disabling some power management modes has
the effect of making runtime power management _too_ aggressive, leading
to either a too-often parking of heads, or aggressively blinking the
link, which sometimes causes COMRESET to be issued too often.

So libata has followed the general policy of always disabling runtime
power management.  This is _not_ a rule, just a starting point.  Changes
are welcome......  after those changes are verified to not have negative
effects.

	Jeff



