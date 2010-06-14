From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 12/12] usb: use IRQ watching
Date: Tue, 15 Jun 2010 00:19:26 +0200
Message-ID: <4C16AAEE.5090204@kernel.org>
References: <1276443098-20653-1-git-send-email-tj@kernel.org> <1276443098-20653-13-git-send-email-tj@kernel.org> <20100614214122.GA21064@suse.de> <4C16A48A.2070404@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58919 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756955Ab0FNWU2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 14 Jun 2010 18:20:28 -0400
In-Reply-To: <4C16A48A.2070404@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: mingo@elte.hu, tglx@linutronix.de, bphilips@suse.de, yinghai@kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, jeff@garzik.org, linux-ide@vger.kernel.org, stern@rowland.harvard.edu, khali@linux-fr.org, Kay Sievers <kay.sievers@vrfy.org>

cc'ing Kay, hi.

On 06/14/2010 11:52 PM, Tejun Heo wrote:
> Hello,
> 
> On 06/14/2010 11:41 PM, Greg KH wrote:
>> So if there's a routing problem, it turns into a polled interrupt?  Do
>> we really want that?
> 
> Oh yeah, I really want that for libata.  Routing is only part of the
> problem and flaky IRQ is something we have to learn to cope with.
> 
>> I wonder how long people will run without realizing that there are
>> problems with their system if their devices still work.
> 
> I think things would be better this way.  If the drives (both cd and
> hard) / input devices are not accessible, most people would simply
> give up rather than reporting, and many cases are transient problems
> which happen only once in the blue moon.
> 
> It would be great if some kind of automatic reporting can be used
> (similar to kerneloops?).  Hmm... maybe make the warnings scarier?

Hmm... maybe what we can do is generating an uevent when an IRQ is
confirmed to be bad and then let udev notify the user.  That way we'll
probably have better chance of getting bug reports and users have
whiny but working system.

Thanks.

-- 
tejun
