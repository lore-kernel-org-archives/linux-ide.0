From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_vsc with iq3124h regression in 2.6.20
Date: Sat, 10 Feb 2007 16:08:01 -0500
Message-ID: <45CE3431.1040209@rtr.ca>
References: <0C7297FA1D2D244A9C7F6959C0BF1E52015235BE@azsmsx413.amr.corp.intel.com> <45CCF6BD.9020404@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:1944 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751898AbXBJVID (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 10 Feb 2007 16:08:03 -0500
In-Reply-To: <45CCF6BD.9020404@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "Williams, Dan J" <dan.j.williams@intel.com>, htejun@gmail.com, linux-ide@vger.kernel.org, jeremy@sgi.com

Jeff Garzik wrote:
>
> As I recall, the 31244 and VSC-7174 always send an interrupt, so the 
> driver should account for this.  I thought we had code already in the 
> driver to handle this, but perhaps recent changes stomped that.
> 
> It would be good to standardize the way we handle these sorts of 
> controllers, because (I think) Mark Lord has the same problem on 
> sata_qstor (or pdc_adma?).

sata_qstor has a different problem.
For IDENTIFY and other non-R/W commands, it behaves nicely
as a simple, dumb, PIO style interface.

For regular block I/O R/W commands, it uses full DMA with
the internal host queue, depth=1, *but* requires NIEN=1
during such commands.

It's on my near-term "to fix" list, along with migration to the new EH stuff.

Cheers
