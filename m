From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [PATCH] ide_tape: convert jiffies with jiffies_to_msecs
Date: Tue, 3 Mar 2015 12:35:54 +0100
Message-ID: <20150303113554.GA8142@opentech.at>
References: <1425378228-6095-1-git-send-email-hofrat@osadl.org> <1425379047.17273.11.camel@perches.com> <20150303105701.GA30191@opentech.at> <1425380684.17273.13.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:37223 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752322AbbCCLf4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Mar 2015 06:35:56 -0500
Content-Disposition: inline
In-Reply-To: <1425380684.17273.13.camel@perches.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Nicholas Mc Guire <hofrat@osadl.org>, "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 03 Mar 2015, Joe Perches wrote:

> On Tue, 2015-03-03 at 11:57 +0100, Nicholas Mc Guire wrote:
> > On Tue, 03 Mar 2015, Joe Perches wrote:
> > > On Tue, 2015-03-03 at 05:23 -0500, Nicholas Mc Guire wrote:
> > > > Note that this patch will give a checkpatch warning due to "quoted string 
> > > > split across lines" but thats not related to this change - not sure if this
> > > > should be fixed - looks intentional to me.
> > > 
> > > It's not.  It'd be better coalesced.
> > 
> > well it did seem quite systematic in this file, aside from it also needing
> > to move over the pr_* so thats going to need a few seperate cleanups.
> 
> Sure, no worries, whenever/ifever.
> 
> I'm pretty sure there aren't many active users
> of ide-tape devices.
>
Im sure thats true - the motivation for cleanups though is that what ever
stays in old drivers - even if hardly in use- gets copied into new drivers
at some point...

thx!
hofrat 
