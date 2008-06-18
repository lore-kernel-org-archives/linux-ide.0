From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [patch 2/2] BAST: Remove old IDE driver
Date: Wed, 18 Jun 2008 12:41:37 +0100
Message-ID: <20080618114137.GI10351@trinity.fluff.org>
References: <20080616111625.145158959@fluff.org.uk> <20080616112453.008960070@fluff.org.uk> <200806162130.43166.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.145.97.151]:57024 "EHLO
	trinity.fluff.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbYFRMYE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jun 2008 08:24:04 -0400
Content-Disposition: inline
In-Reply-To: <200806162130.43166.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Ben Dooks <ben-linux@fluff.org>, linux-ide@vger.kernel.org, jgarzik@pobox.com

On Mon, Jun 16, 2008 at 09:30:43PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Monday 16 June 2008, Ben Dooks wrote:
> > Remove the old BAST IDE driver, as we are now using the platform-pata
> > support.
> > 
> > Signed-off-by: Ben Dooks <ben-linux@fluff.org>
> 
> ide_platform a.k.a. CONFIG_BLK_DEV_PLATFORM doesn't have "depends on"
> limitation so I wonder if it is possible to use it "out-of-the-box" on
> ANUBIS now?

I'll have a look.
 
> [ so I could apply this patch without waiting for patch #1/2 ]

I'd prefer to see the kconfig changes done, we're testing with libata
as the default, however it is _possible_ to select either with a bit
of pain. CONFIG_EMBEDDED isn't really what we want, but at least we get
a working system.

So, short answer, enqueue this, I'm sure we'll manage either way.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

