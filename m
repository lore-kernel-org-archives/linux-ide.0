From: Tejun Heo <tj@kernel.org>
Subject: Re: "SCR access via SIDPR is available but doesn't work"
Date: Thu, 09 Oct 2008 06:50:27 +0900
Message-ID: <48ED2B23.8000209@kernel.org>
References: <3D76E016F4A2A749A1EB1A3FD83E22BC01D6E466@uk-email.terastack.bluearc.com> <48E6D8F4.2080207@gmail.com> <3D76E016F4A2A749A1EB1A3FD83E22BC01E0D723@uk-email.terastack.bluearc.com> <48ED2AB6.4010905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34811 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752602AbYJHVwA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 8 Oct 2008 17:52:00 -0400
In-Reply-To: <48ED2AB6.4010905@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rob Whitton <rwhitton@bluearc.com>
Cc: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Rob Whitton wrote:
>> I have run this test and I can confirm that NumLock does still work,
>> although unreliably. What I mean by this is that once we get to this
>> point often it takes a number of presses of numlock to get the state of
>> the LED to change. Before we get to this point it seems to behave fine.
>> Ctrl-alt-sysrq-t doesn't appear to dump anything to the console. After
>> doing ctrl-alt-sysrq-t numlock no longer functions at all.
>>
>> Something I forgot to mention in my original email is that using
>> "noapic" at boot is also a work around for the problem. It isn't an
>> option for us as we are going to be using advanced features such as MSI
>> that are only available via the APIC route.
> 
> I don't think MSI has anything to do with noapic.  Can you please post
> the result of "lspci -nn"?  Also, what kind of motherboard is it?

Oh.. and one more thing, can you please confirm that commenting out
PIIX_FLAG_SIDPR settings in piix_port_info structures fix the problem?

Thanks.

-- 
tejun
