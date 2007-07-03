From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git patches] libata fixes
Date: Tue, 3 Jul 2007 09:21:29 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0707030919391.9434@woody.linux-foundation.org>
References: <20070703155238.GA7344@havoc.gtf.org>
 <20070703170734.5a25b9c5@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55785 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755799AbXGCQWS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 12:22:18 -0400
In-Reply-To: <20070703170734.5a25b9c5@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>



On Tue, 3 Jul 2007, Alan Cox wrote:
>
> > Chuck Ebbert (1):
> >       pata_ali: fix UDMA settings
> 
> Could you please fix your git tree to have the proper credits for patches
> you pull from bugzilla. 
> 
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=242472

I don't think it is Jeff who needs to fix anything: it seems that it is 
Chuck Ebbert you should talk to. He's the one that dropped the 
attribution. Probably because of some insane system he uses (he has a 
comment in that bugzilla about "patch from comment #14 is in CVS now.".

CVS? What kind if insane setup do you have there at Red Hat?

			Linus
