From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/3] ide: use MODULE_VERSION()
Date: Wed, 2 Jan 2008 23:45:17 +0100
Message-ID: <200801022345.17529.bzolnier@gmail.com>
References: <200801011840.38757.bzolnier@gmail.com> <1199241156.3300.55.camel@perihelion> <20080102044620.GB10762@auslistsprd01.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:32832 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877AbYABWeU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jan 2008 17:34:20 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2576190ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 02 Jan 2008 14:34:17 -0800 (PST)
In-Reply-To: <20080102044620.GB10762@auslistsprd01.us.dell.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: Jon Masters <jonathan@jonmasters.org>, Adrian Bunk <bunk@kernel.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 02 January 2008, Matt Domsch wrote:
> On Tue, Jan 01, 2008 at 09:32:36PM -0500, Jon Masters wrote:
> > On Tue, 2008-01-01 at 19:33 +0100, Bartlomiej Zolnierkiewicz wrote:
> > 
> > > On the second thought: maybe we will be better off with limiting
> > > MODULE_VERSION() to the device drivers and the IDE core module for now,
> > > and just removing all these private version numbers from host drivers
> > > (with one or two exceptions they are not printed or exported currently,
> > > moreover exceptions are the cases like stale version numbers from 199x)?
> > 
> > Things like checkpatch could help advise people to bump the version
> > number, but it's a bit iffy. Matt D. actually uses the special source
> > version modinfo for DKMS - which is different - but it makes me wonder
> > whether dynamically generating a version based on source SHA1 wouldn't
> > be a better idea in most cases than an outdated hard-coded one.
> 
> We've got that already, it's called 'srcversion', and it's a CRC32

Neat.

> IIRC after some limited parsing to let it ignore whitspace changes and
> comment changes only.  
> 
> $ modinfo dell_rbu | grep version
> version:        3.2
> srcversion:     1D4815D7D6FBEE6612F3C18

Unfortunately 'srcversion' is set only if MODULE_VERSION() is used... :(

Anyway I'm dropping this patch and removing all versions from comments
for now (patch #2 respin in few minutes)...

Thanks,
Bart
