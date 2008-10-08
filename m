From: Tejun Heo <htejun@gmail.com>
Subject: Re: "SCR access via SIDPR is available but doesn't work"
Date: Thu, 09 Oct 2008 06:48:38 +0900
Message-ID: <48ED2AB6.4010905@gmail.com>
References: <3D76E016F4A2A749A1EB1A3FD83E22BC01D6E466@uk-email.terastack.bluearc.com> <48E6D8F4.2080207@gmail.com> <3D76E016F4A2A749A1EB1A3FD83E22BC01E0D723@uk-email.terastack.bluearc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.186]:53388 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752788AbYJHVuM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Oct 2008 17:50:12 -0400
Received: by ti-out-0910.google.com with SMTP id b6so2370128tic.23
        for <linux-ide@vger.kernel.org>; Wed, 08 Oct 2008 14:50:09 -0700 (PDT)
In-Reply-To: <3D76E016F4A2A749A1EB1A3FD83E22BC01E0D723@uk-email.terastack.bluearc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rob Whitton <rwhitton@bluearc.com>
Cc: linux-ide@vger.kernel.org

Rob Whitton wrote:
> I have run this test and I can confirm that NumLock does still work,
> although unreliably. What I mean by this is that once we get to this
> point often it takes a number of presses of numlock to get the state of
> the LED to change. Before we get to this point it seems to behave fine.
> Ctrl-alt-sysrq-t doesn't appear to dump anything to the console. After
> doing ctrl-alt-sysrq-t numlock no longer functions at all.
> 
> Something I forgot to mention in my original email is that using
> "noapic" at boot is also a work around for the problem. It isn't an
> option for us as we are going to be using advanced features such as MSI
> that are only available via the APIC route.

I don't think MSI has anything to do with noapic.  Can you please post
the result of "lspci -nn"?  Also, what kind of motherboard is it?

Thanks.

-- 
tejun
