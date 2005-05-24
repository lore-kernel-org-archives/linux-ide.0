From: Andrew Morton <akpm@osdl.org>
Subject: Re: enable-reads-on-plextor-712-sa-on-26115.patch added to -mm tree
Date: Mon, 23 May 2005 17:34:20 -0700
Message-ID: <20050523173420.22281325.akpm@osdl.org>
References: <200505232245.j4NMjtk4024089@shell0.pdx.osdl.net>
	<4292628E.4090209@pobox.com>
	<4292743C.4040409@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fire.osdl.org ([65.172.181.4]:45461 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261224AbVEXAdf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 May 2005 20:33:35 -0400
In-Reply-To: <4292743C.4040409@comcast.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andy Stewart <andystewart@comcast.net>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Andy Stewart <andystewart@comcast.net> wrote:
>
> > 
> > Good show.
> 
> Aw, come on, Jeff.  I gave it a shot,

You did, and that's very much appreciated, thanks.

> If you believe this patch is
> inappropriate, then please ask Andrew Morton to remove it

I already have removed it, but only because it appears that the patch might
cause regressions in other areas.

Basically it goes like this:

- Someone sends a patch

- Patch gets ignored.

- I merge it, without even looking at the thing.

I do this as a reminder to myself and to other developers that there is
some kernel bug or shortcoming.  Basically, it's a bug-tracking system. 
Periodically I'll spam the maintainer with the patch and eventually he'll
tell me to drop the thing because the problem is fixed, or he'll tell the
originator why the patch will never be merged.

Either way, the patch (and the problem which caused you to write the patch)
gets some sort of definite dispositive handling, rather than falling
through a crack.
