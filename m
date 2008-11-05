From: Tejun Heo <tj@kernel.org>
Subject: Re: [git patches] libata hibernation fixes
Date: Wed, 05 Nov 2008 11:17:31 +0900
Message-ID: <4911023B.20901@kernel.org>
References: <20081104062734.GA4420@havoc.gtf.org> <200811041753.53342.rjw@sisk.pl> <49107F76.60107@rtr.ca> <200811041807.17183.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:36473 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753937AbYKECSg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Nov 2008 21:18:36 -0500
In-Reply-To: <200811041807.17183.rjw@sisk.pl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Mark Lord <liml@rtr.ca>, Linus Torvalds <torvalds@linux-foundation.org>, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Rafael J. Wysocki wrote:
>> So, what happens if we just don't ever spin them down from the kernel?
>> Presumably they still spin-down normally (HP or otherwise) when the BIOS
>> actually cuts the power at the end of all of this?
>>
>> Just curious..
> 
> Well, I'll let Tejun answer that. :-)

The BIOSen on the affected HP ones will spin the drives down during
power off or hibernation, so there won't be any problem (that's what the
patch does, BTW).  For all other machines, the drive will do emergency
head unload which usually sounds a bit differently and shortens the
lifespan of the drive.

Thanks.

-- 
tejun
