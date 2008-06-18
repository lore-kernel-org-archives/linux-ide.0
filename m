From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [patch 2/2] BAST: Remove old IDE driver
Date: Wed, 18 Jun 2008 23:33:41 +0200
Message-ID: <200806182333.42085.bzolnier@gmail.com>
References: <20080616111625.145158959@fluff.org.uk> <200806162130.43166.bzolnier@gmail.com> <20080618114137.GI10351@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:38909 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754016AbYFRVem (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Jun 2008 17:34:42 -0400
Received: by yw-out-2324.google.com with SMTP id 9so256904ywe.1
        for <linux-ide@vger.kernel.org>; Wed, 18 Jun 2008 14:34:41 -0700 (PDT)
In-Reply-To: <20080618114137.GI10351@trinity.fluff.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: linux-ide@vger.kernel.org, jgarzik@pobox.com

On Wednesday 18 June 2008, Ben Dooks wrote:
> On Mon, Jun 16, 2008 at 09:30:43PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Monday 16 June 2008, Ben Dooks wrote:
> > > Remove the old BAST IDE driver, as we are now using the platform-pata
> > > support.
> > > 
> > > Signed-off-by: Ben Dooks <ben-linux@fluff.org>
> > 
> > ide_platform a.k.a. CONFIG_BLK_DEV_PLATFORM doesn't have "depends on"
> > limitation so I wonder if it is possible to use it "out-of-the-box" on
> > ANUBIS now?
> 
> I'll have a look.
>  
> > [ so I could apply this patch without waiting for patch #1/2 ]
> 
> I'd prefer to see the kconfig changes done, we're testing with libata
> as the default, however it is _possible_ to select either with a bit
> of pain. CONFIG_EMBEDDED isn't really what we want, but at least we get
> a working system.
> 
> So, short answer, enqueue this, I'm sure we'll manage either way.

ok, I applied it to IDE tree but will wait with pushing it to Linus until
patch #1/2 goes in (or there is some confirmation w.r.t. ide_platform)

Thanks,
Bart
