From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: LibPATA code issues / 2.6.15.4
Date: Wed, 08 Mar 2006 16:46:55 +0000
Message-ID: <1141836415.7605.50.camel@localhost.localdomain>
References: <Pine.LNX.4.64.0602140439580.3567@p34>
	 <43F2050B.8020006@dgreaves.com> <Pine.LNX.4.64.0602141211350.10793@p34>
	 <200602141300.37118.lkml@rtr.ca> <440040B4.8030808@dgreaves.com>
	 <440083B4.3030307@rtr.ca> <Pine.LNX.4.64.0602251244070.20297@p34>
	 <4400A1B <1141238277.23170.2.camel@localhost.localdomain>
	 <4406003A.1070606@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33502 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932098AbWCHQnF
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Mar 2006 11:43:05 -0500
In-Reply-To: <4406003A.1070606@cfl.rr.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phillip Susi <psusi@cfl.rr.com>
Cc: David Greaves <david@dgreaves.com>, Mark Lord <liml@rtr.ca>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>, albertcc@tw.ibm.com, axboe@suse.de, Linus@lxorguk.ukuu.org.uk

On Mer, 2006-03-01 at 15:12 -0500, Phillip Susi wrote:
> >>   It Broke And I Dont Know Why
> >> to
> >>   Aborted Command
> > 
> > So whats the SCSI sense encoding for that ?
> > 
> 
> Wouldn't that just be 0/0/0?  IIRC the standard defines that as "NO 
> ADDITIONAL SENSE DATA" which sounds to me like another way of saying "I 
> don't know what went wrong, but that didn't work".

The 0/0/0 sense is already used. The question is what error do you use
with that sense. At the moment I'm using aborted command.

