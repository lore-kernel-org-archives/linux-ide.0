From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH resend regression?] AHCI: Fix threaded interrupt setup
Date: Thu, 13 Nov 2014 10:06:33 +0000
Message-ID: <546482A9.20803@arm.com>
References: <1415871882-634-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:50686 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932176AbaKMKGj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Nov 2014 05:06:39 -0500
In-Reply-To: <1415871882-634-1-git-send-email-hdegoede@redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hi Hans,

On 13/11/14 09:44, Hans de Goede wrote:
> Hi Tejun,
> 
> Since this patch mentioned sunxi it gained my attention, but as it touches
> ahci core code I was expecting you to pick it up, which seems to not have
> happened, so hence this resend.
> 
> FWIW I've tried to reproduce the problem, but it does not reproduce for me,
> that does not mean it is not a real problem though. I'm afraid I'm to
> unfamiliar with the ahci interrupt handling to say anything more sensible
> about this.

I can reproduce it about once every 5 boots or so. You can also notice
that the interrupt rate is much higher with the threaded interrupt code,
which is a sign that something is very fishy (the level interrupt is
never masked...).

> It looks like this is a 3.18 regression, so if this is a real issue, we
> should probably get this patch in for 3.18 .

I think the real fix should be to revert the whole threaded interrupt
thing. Adding the IRQF_ONESHOT breaks some Intel platforms in a rather
bad way in case of a shared interrupt (for gory details, see
http://www.gossamer-threads.com/lists/linux/kernel/2043506).

Tejun did prepare a set of patches to revert this, but I haven't seen it
being pulled in yet. It would be good to get something into 3.18.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...

