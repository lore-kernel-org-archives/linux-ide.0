From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH] Fixup ahci suspend / resume
Date: Fri, 3 Mar 2006 23:37:16 -0800
Message-ID: <20060303233716.67ffaff6.rdunlap@xenotime.net>
References: <44045FB1.5040408@suse.de>
	<440468DB.5060605@pobox.com>
	<20060228151928.GC24981@suse.de>
	<44046AC2.1060002@pobox.com>
	<20060228152847.GE24981@suse.de>
	<44046DC3.4060508@pobox.com>
	<440472F6.6090905@suse.de>
	<20060228172542.GF24981@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:38587 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751470AbWCDHfz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 4 Mar 2006 02:35:55 -0500
Received: from midway.site ([71.111.157.99]) by xenotime.net for <linux-ide@vger.kernel.org>; Fri, 3 Mar 2006 23:35:53 -0800
In-Reply-To: <20060228172542.GF24981@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: hare@suse.de, jgarzik@pobox.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Tue, 28 Feb 2006 18:25:43 +0100 Jens Axboe wrote:

> On Tue, Feb 28 2006, Hannes Reinecke wrote:
> > Jeff Garzik wrote:
> > > Jens Axboe wrote:
> > >> I'm sure Hannes will regenerate against upstream as well if necessary,
> > >> however that depends on when this should be applied.
> > > 
> > > It's far too late and too intrusive for 2.6.16-rc.
> > > 
> > > It's #upstream or <null>.
> > > 
> > Calm down. Of course I will regenerate is against #upstream.
> > In fact, I've done so initially but wasn't sure what the status of
> > libata-dev is. So I've diffed it against linux-git instead.
> > 
> > Updated patch to follow.
> 
> Thanks Hannes. I wasn't so much worried about it going directly in (I
> have no problem waiting), just that there seemed to be some disagreement
> on where suspend is at and what we can "support".

Hi Hannes,

Did you ever send the updated patch?  I need it to use with the
rest of the ata-acpi objects patchset for #upstream (actually for -mm).

Thanks,
---
~Randy
