From: "Timothy Thelin" <Timothy.Thelin@wdc.com>
Subject: RE: [PATCH 2.6.14]: ide: Enable larger taskfile transfers
Date: Mon, 31 Oct 2005 18:41:12 -0800
Message-ID: <CA45571DE57E1C45BF3552118BA92C9D69BF26@WDSCEXBECL03.sc.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wdscexfe02.sc.wdc.com ([129.253.170.52]:26803 "EHLO
	wdscexfe02.sc.wdc.com") by vger.kernel.org with ESMTP
	id S964936AbVKAClQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 31 Oct 2005 21:41:16 -0500
Content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org


> On Mon, 31 Oct 2005, Timothy Thelin wrote:
> 
> > IDE taskfile passthru was limited to 128K data transfers
> > because of its use of a single kmalloc. This patch makes
> > the passthru use a single __get_free_pages instead so the
> > codepath remains conceptually the same but the data
> > transfer limit is raised to 2MB.  This new limit is
> > needed for firmware updates (download microcode) and
> > extended commands with larger transfers.
> 
> You tested this, with 1-2 MB transfers?  Just want confirmation.

We'll testing was limited to read sectors extended and write
sectors extended, but it does work. I can read and write
4MB of sectors just fine on my x86.  Other archs untested.

> After lots of memory usage, multi-order allocs in Linux
> aren't very much of a sure thing.
> 

True, and I probably should have said "the data transfer limit
is raised to a theoritical 2MB or 4MB depending on architecture"

Even though it can't be guarenteed, the patch at least provides
the possibility of larger transfers. However, is __get_free_pages
less likely to return a valid chunk compared to kmalloc for the
same requested size (so up to 128K)?


> Please read/study kernel CodingStyle so that we can
> review the patch content and functionality instead
> of nit-picking the incorrect style.
> 

Sorry, I'll make sure to fix it.

Regards,
Tim Thelin
