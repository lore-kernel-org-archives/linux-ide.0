From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: sata_mv important note
Date: Thu, 19 Jan 2006 09:08:47 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0601190908160.11660@shark.he.net>
References: <43CD07D5.30302@pobox.com> <E1EytdC-0006DE-IS@highlab.com>
 <43CD46B7.4000907@rtr.ca> <1137581636.10890.81.camel@localhost.localdomain>
  <43CE6965.9040408@pobox.com> <1137613505.25727.6.camel@localhost.localdomain>
 <43CFC6C2.60607@rtr.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:30169 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751207AbWASRIw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Jan 2006 12:08:52 -0500
Received: from shark.he.net ([66.160.160.2]) by xenotime.net for <linux-ide@vger.kernel.org>; Thu, 19 Jan 2006 09:08:47 -0800
In-Reply-To: <43CFC6C2.60607@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Erik Slagter <erik@slagter.name>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Thu, 19 Jan 2006, Mark Lord wrote:

> Erik Slagter wrote:
> >
> >>sata_qstor
> >
> > Bummer. I silently hoped it would be using ahci, but I will dream on ;-)
>
> It has a UHCI interface rather than AHCI.

UHCI as in USB Universal Host Controller Interface??
or something else?

> There is an alternative SCSI LLD for it that supports all of the goodies
> (native and legacy tagged queuing, RAID 0/1/10, hot ("live") insertion/removal,
> etc.. but it is probably a bit out of date now.  Last updated a year ago.
> And not in the main tree.

-- 
~Randy
