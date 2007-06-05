From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 8587] New: disk on promise pdc20378 disabled
 at boot
Date: Tue, 5 Jun 2007 10:12:17 -0700
Message-ID: <20070605101217.2d466b9e.akpm@linux-foundation.org>
References: <200706051330.l55DUqVW020898@fire-2.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:52016 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754878AbXFERMl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 Jun 2007 13:12:41 -0400
In-Reply-To: <200706051330.l55DUqVW020898@fire-2.osdl.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Tejun Heo <htejun@gmail.com>, Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-ide@vger.kernel.org, "bugme-daemon@kernel-bugs.osdl.org" <bugme-daemon@kernel-bugs.osdl.org>, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, jean.luc.coulon@gmail.com

On Tue, 5 Jun 2007 06:30:52 -0700
bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=8587
> 
>            Summary: disk on promise pdc20378 disabled at boot
>     Kernel Version: 2.6.22-rc4
>             Status: NEW
>           Severity: normal
>              Owner: greg@kroah.com
>          Submitter: jean.luc.coulon@gmail.com
> 
> 
> Most recent kernel where this bug did *NOT* occur: 2.6.22-rc3-git7
> Distribution: Debian sid X86_64
> Hardware Environment: PDC20378 in ASUS A8V Deluxe, Athlon64 3600+
> Software Environment: sata_promise
> Problem Description: disk is disabled
> 
> Steps to reproduce: boot the system
> 

If Jean really meant 2.6.22-rc3-git7 then this is a very recent regression.
