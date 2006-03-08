From: Bill Davidsen <tmrbill@tmr.com>
Subject: Re: LibPATA code issues / 2.6.15.4
Date: Wed, 8 Mar 2006 10:37:04 -0500 (EST)
Message-ID: <Pine.LNX.4.44.0603081034540.31895-100000@firewall2.tmr.com>
References: <440E4803.7070808@rtr.ca>
Reply-To: davidsen@tmr.com
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.tmr.com ([64.65.253.246]:55050 "EHLO firewall2.tmr.com")
	by vger.kernel.org with ESMTP id S1750883AbWCHPhs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Mar 2006 10:37:48 -0500
In-Reply-To: <440E4803.7070808@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Bill Davidsen <davidsen@tmr.com>, Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>, axboe@suse.de, albertcc@tw.ibm.com

On Tue, 7 Mar 2006, Mark Lord wrote:

> Bill Davidsen wrote:
> >
> > Is there a version of that which will build on x86? I grabbed the 
> > version offered at freshmeat, but it won't compile on any x86 distro or 
> > gcc version to which I have access. RH8, RH9, FC1, FC3, FC4, ubuntu... 
> > with or without using the suggested alternate header.
> 
> hdparm-6.5 is the current version now.  Both it, and 6.4,
> build/install/run cleanly on Ubunutu-5.10, Debian-Sarge,
> and SLES9-SP3.
> 
> You seem to be having trouble on only Redhat distros..
> I guess they've done something unfriendly again.
> 
> Care to be more specific about what Redhat is doing?

I'll mail you the first few hundred errors from the compiler after I go 
find 6.5 and try that. My ubuntu tester reported similar results, so I'm 
not sure what we are doing.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
Doing interesting things with little computers since 1979

