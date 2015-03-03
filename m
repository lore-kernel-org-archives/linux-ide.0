From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] ide_tape: convert jiffies with jiffies_to_msecs
Date: Tue, 03 Mar 2015 03:04:44 -0800
Message-ID: <1425380684.17273.13.camel@perches.com>
References: <1425378228-6095-1-git-send-email-hofrat@osadl.org>
	 <1425379047.17273.11.camel@perches.com>
	 <20150303105701.GA30191@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtprelay0142.hostedemail.com ([216.40.44.142]:58149 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754021AbbCCLEs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Mar 2015 06:04:48 -0500
In-Reply-To: <20150303105701.GA30191@opentech.at>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nicholas Mc Guire <der.herr@hofr.at>
Cc: Nicholas Mc Guire <hofrat@osadl.org>, "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2015-03-03 at 11:57 +0100, Nicholas Mc Guire wrote:
> On Tue, 03 Mar 2015, Joe Perches wrote:
> > On Tue, 2015-03-03 at 05:23 -0500, Nicholas Mc Guire wrote:
> > > Note that this patch will give a checkpatch warning due to "quoted string 
> > > split across lines" but thats not related to this change - not sure if this
> > > should be fixed - looks intentional to me.
> > 
> > It's not.  It'd be better coalesced.
> 
> well it did seem quite systematic in this file, aside from it also needing
> to move over the pr_* so thats going to need a few seperate cleanups.

Sure, no worries, whenever/ifever.

I'm pretty sure there aren't many active users
of ide-tape devices.


