From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 12/12] usb: use IRQ watching
Date: Tue, 15 Jun 2010 19:36:12 +0200
Message-ID: <4C17BA0C.4010208@kernel.org>
References: <1276443098-20653-1-git-send-email-tj@kernel.org> 	<1276443098-20653-13-git-send-email-tj@kernel.org> <20100614214122.GA21064@suse.de> 	<4C16A48A.2070404@kernel.org> <4C16AAEE.5090204@kernel.org> 	<AANLkTilG1KAVOe5DcpLEFAJ-37PQJCgVT-jLZhr1e6tC@mail.gmail.com> 	<4C176206.90305@kernel.org> <AANLkTinVL4UuF70E1dR1vbYYkVRTBDh5su5D9k0h-vVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40644 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752324Ab0FORhV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Jun 2010 13:37:21 -0400
In-Reply-To: <AANLkTinVL4UuF70E1dR1vbYYkVRTBDh5su5D9k0h-vVA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Greg KH <gregkh@suse.de>, mingo@elte.hu, tglx@linutronix.de, bphilips@suse.de, yinghai@kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, jeff@garzik.org, linux-ide@vger.kernel.org, stern@rowland.harvard.edu, khali@linux-fr.org

Hello,

On 06/15/2010 03:36 PM, Kay Sievers wrote:
> Yeah, I'm pretty sure that's not what we want. We want structured
> data, and a generic channel to pass all sort of errors through, and a
> userspace part to handle it in a sane way. Many error sources may also
> not have a device path in /sys, and therefore no uevent to send.
> Uevents/udev just seem so convinient because it's already there, but I
> think, has too many limitations to provide the needed functionality.
> Besides the fact that nothing listens to these events in userspace
> today -- it's a lot more to think through and work on than passing
> things through uevents, especially some generic classification and
> structured data passing, which is needed, instead of the current
> free-text 'dmsg' or the property-based stuff in uevents. I'm very sure
> it's the wrong facility to use.

Yeah, well, if you say so.  It would be very nice to have report this
type of critical events in somewhat formatted way so that they can be
processed automatically and presented to the user in more accessible
manner.  I doubt requiring strict structure would work in the long
run.  It'll likely end up being able to cover only portion of what's
originally designed and and stagnate in time.  I think control
information including identification and severity + free form string
would be much more manageable.

It would really be great to have something like that.  I can easily
think of several libata events the user should be notified of from the
top of my head but currently are buried in dmesg.

Thanks.

-- 
tejun
