From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [git patches] libata hibernation fixes
Date: Mon, 05 Jan 2009 03:34:22 -0500
Message-ID: <4961C60E.9030506@garzik.org>
References: <20081104062734.GA4420@havoc.gtf.org> <495D7DC9.8070101@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:42372 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751464AbZAEIee (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Jan 2009 03:34:34 -0500
In-Reply-To: <495D7DC9.8070101@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Tejun Heo wrote:
> Jeff Garzik wrote:
>> This adds code at a late stage (heading towards -rc4), but does
>> eliminate a particular spin-up overcycling behavior associated with
>> hibernation.
>>
>> Rafael's extended description below...  Separated to make it easier to
>> pull-or-not, separate from the other libata fixes.  There shouldn't be
>> any merge trouble between the two.
>>
>> SATA: Blacklist systems that spin off disks during ACPI power off
> 
> Jeff, I think this should be merged into 2.6.29 unless Linus still
> objects.  Linus, as discussed in this thread, this is workaround for a
> hardware / firmware problem and vanilla windows also suffers the
> problem, so as ugly as it is, we need this to prevent double spin down
> on the machine.

(Just returned from New Year's holiday)

Yes, I definitely want to put it in as well.

	Jeff



