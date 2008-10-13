From: Tejun Heo <tj@kernel.org>
Subject: Re: "SCR access via SIDPR is available but doesn't work"
Date: Mon, 13 Oct 2008 16:28:14 +0900
Message-ID: <48F2F88E.5070504@kernel.org>
References: <3D76E016F4A2A749A1EB1A3FD83E22BC01D6E466@uk-email.terastack.bluearc.com> <48E6D8F4.2080207@gmail.com> <3D76E016F4A2A749A1EB1A3FD83E22BC01E0D723@uk-email.terastack.bluearc.com> <48ED2AB6.4010905@gmail.com> <48ED2B23.8000209@kernel.org> <3D76E016F4A2A749A1EB1A3FD83E22BC01E0D94C@uk-email.terastack.bluearc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40460 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753602AbYJMH3q (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 13 Oct 2008 03:29:46 -0400
In-Reply-To: <3D76E016F4A2A749A1EB1A3FD83E22BC01E0D94C@uk-email.terastack.bluearc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rob Whitton <rwhitton@bluearc.com>
Cc: linux-ide@vger.kernel.org

Hello,

Rob Whitton wrote:
> We experience the same problem with two different motherboards (the only
> motherboards we have tried in this system):
> 
>   TYAN S5211
>   Intel S3210SHLC
> 
> The original boot logs were from the Tyan motherboard which is what we
> have been working with almost exclusively. However, in the lab we
> currently have the Intel board in use and as such I've recreated the
> failing and succeeding boot logs on the Intel board so that the boots
> logs are consistent with the output of "lspci -nn" which is also
> attached.
> 
> With regard to changing piix_port_info structures this will have to wait
> for the moment. Our kernel building expert is currently on vacation. But
> maybe this step will be unnecessary - see below.

I think that will be an easy way to rule out whether the SIDPR is the
offending piece or not.

> I note that in the Intel boot logs whilst booting stops at the same
> point it doesn't display the message which started this thread and
> tended to point the finger of suspicion at the PIIX driver (probably
> should change the subject line of the email). Maybe it is a more
> fundamental kernel problem? I'm still very surprised that simply moving
> the SATA disk between ports causes this problem. Maybe it relates to
> interrupt routing or similar. I assume that the two SATA controllers in
> the Intel chipset use different interrupts.

Yes, they use different IRQs but IRQ lock ups are usually a bit more
verbose.  The last two ports on ICH9 seem to have rather obscure
problems (PMP detection failure for one) and this might be one of
those.  Anyways, please confirm whether SIDPR is the offending piece
or not.

Thanks.

-- 
tejun
