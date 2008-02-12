From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 00/18] ide: warm-plug support for IDE devices and other goodies
Date: Tue, 12 Feb 2008 22:54:39 +0100
Message-ID: <200802122254.39663.bzolnier@gmail.com>
References: <20080208004421.17746.32557.sendpatchset@localhost.localdomain> <1202460043.7079.157.camel@pasglop> <1202850247.7410.24.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.187]:45026 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959AbYBLVls (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Feb 2008 16:41:48 -0500
Received: by ti-out-0910.google.com with SMTP id 28so570246tif.23
        for <linux-ide@vger.kernel.org>; Tue, 12 Feb 2008 13:41:46 -0800 (PST)
In-Reply-To: <1202850247.7410.24.camel@pasglop>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: benh@kernel.crashing.org
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org

On Tuesday 12 February 2008, Benjamin Herrenschmidt wrote:
> 
> On Fri, 2008-02-08 at 19:40 +1100, Benjamin Herrenschmidt wrote:
> > On Fri, 2008-02-08 at 01:44 +0100, Bartlomiej Zolnierkiewicz wrote:
> > > - couple of fixes and preparatory patches
> > > 
> > > - rework of PowerMac media-bay support ([un]register IDE devices instead of
> > >   [un]registering IDE interface) [ it is the main reason for spamming PPC ML ]
> > 
> > Interesting... I was thinking about doing a full remove of the device at
> > a higher level instead but I suppose what you propose is easier.
> > 
> > I'll have a look & test next week hopefully.
> 
> Also, the above would have the advantage of not relying on drivers/ide
> infrastructure, and thus working with libata (once somebody has ported
> pmac ide to libata).

Neither of these things exist at the moment so lets stick to the existing
code which is scheduled for 2.6.26 and which finally allows removal of ppc
specific ide hacks from arch/{powerpc,ppc} (500 LOC gone, patches to be
posted this week), not to mention other nice changes in the future...

Thanks,
Bart
