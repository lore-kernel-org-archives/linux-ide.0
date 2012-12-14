From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH v2 2/4] pata_octeon_cf: perform host detach, removal on
 exit
Date: Fri, 14 Dec 2012 09:37:20 -0500
Message-ID: <50CB39A0.2050102@pobox.com>
References: <1354559682-30965-1-git-send-email-computersforpeace@gmail.com> <1354559682-30965-2-git-send-email-computersforpeace@gmail.com> <50BD4331.6010904@gmail.com> <CAN8TOE_Zmd8ek-OXqHKiuQ57aUF7BdLFX2KOD-20tt8EBDhg+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:47948 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754116Ab2LNOhY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Dec 2012 09:37:24 -0500
Received: by mail-vb0-f46.google.com with SMTP id b13so3949185vby.19
        for <linux-ide@vger.kernel.org>; Fri, 14 Dec 2012 06:37:24 -0800 (PST)
In-Reply-To: <CAN8TOE_Zmd8ek-OXqHKiuQ57aUF7BdLFX2KOD-20tt8EBDhg+Q@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: David Daney <ddaney.cavm@gmail.com>, linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>, David Daney <david.daney@cavium.com>

On 12/04/2012 01:10 AM, Brian Norris wrote:
>> >I can seem to find it.  Without knowing what that does, I would be inclined
>> >to NACK the whole thing.
> A NACK is probably the right thing. I was mostly converting a few
> other drivers which used some simple, common patterns to use my new
> common code, but this driver was missing it altogether. It looks like
> there may be bigger issues, though, as you point out.
>
>> >How did you test the patch?
> I didn't; I don't have a cavium-octeon system.
>
>> >This patch is likely to be incomplete as the driver is also missing the
>> >module_exit() things.
>> >
>> >It might be simpler to just make the driver "bool" instead of "tristate" in
>> >the Kconfig.
> As noted earlier, I don't have much interest in this driver. I agree
> that there are some other issues with the driver; I think it leaks
> memory if it is ever allowed to unload, for one. Feel free to submit
> an alternative patch to prevent this driver from being built as a
> module.

reverted


