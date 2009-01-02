From: Tejun Heo <tj@kernel.org>
Subject: Re: [git patches] libata hibernation fixes
Date: Fri, 02 Jan 2009 11:36:57 +0900
Message-ID: <495D7DC9.8070101@kernel.org>
References: <20081104062734.GA4420@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49460 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755483AbZABChd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 1 Jan 2009 21:37:33 -0500
In-Reply-To: <20081104062734.GA4420@havoc.gtf.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Jeff Garzik wrote:
> This adds code at a late stage (heading towards -rc4), but does
> eliminate a particular spin-up overcycling behavior associated with
> hibernation.
> 
> Rafael's extended description below...  Separated to make it easier to
> pull-or-not, separate from the other libata fixes.  There shouldn't be
> any merge trouble between the two.
> 
> SATA: Blacklist systems that spin off disks during ACPI power off

Jeff, I think this should be merged into 2.6.29 unless Linus still
objects.  Linus, as discussed in this thread, this is workaround for a
hardware / firmware problem and vanilla windows also suffers the
problem, so as ugly as it is, we need this to prevent double spin down
on the machine.

Thanks and happy new year.

-- 
tejun
