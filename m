From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [Build Failure] 2.6.25-rc5-mm1 Build fails with allmodconfig probe_4drives undefined
Date: Tue, 11 Mar 2008 20:36:07 +0100
Message-ID: <200803112036.08007.bzolnier@gmail.com>
References: <20080311011434.ad8c8d7d.akpm@linux-foundation.org> <47D68126.40109@linux.vnet.ibm.com> <20080311111958.c0d3188d.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:58993 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617AbYCKTXs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 11 Mar 2008 15:23:48 -0400
Received: by fg-out-1718.google.com with SMTP id e21so2528615fga.17
        for <linux-ide@vger.kernel.org>; Tue, 11 Mar 2008 12:23:47 -0700 (PDT)
In-Reply-To: <20080311111958.c0d3188d.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, apw@shadowen.org

On Tuesday 11 March 2008, Andrew Morton wrote:
> On Tue, 11 Mar 2008 18:25:02 +0530
> Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> wrote:
> 
> >   MODPOST 2279 modules
> > ERROR: "probe_4drives" [drivers/ide/ide-core.ko] undefined!
> 
> Caused by ide-mm-ide-add-ide-4drives-host-driver-take-3.patch.  Applying
> that patch alone to current mainline causes the above error after i386
> `make allmodconfig'.
> 
> Just exporting the symbol doesn't fix it, so something funny is going on.

toolchain?  [ standard F7 system w/ updates here ]

> probe_4drives should not be initialised to zero.
> 
> probe_4drives should not be declared extern in drivers/ide/ide.c - please
> declare it in a header which is included by the definition site and by all
> users.

I was aware of the warnings and this was only temporary (it is already fixed
by to-be-posted-today patch which removes deprecated "idex=" kernel parameters
and makes _all_ probe_* variables static).

Thanks,
Bart
