From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 09/12] irq: implement IRQ expecting
Date: Sat, 19 Jun 2010 10:42:51 +0200
Message-ID: <4C1C830B.5020806@kernel.org>
References: <1276443098-20653-1-git-send-email-tj@kernel.org>	<1276443098-20653-10-git-send-email-tj@kernel.org>	<20100616204854.4b036f87@infradead.org> <87zkyro1xl.fsf@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46592 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751143Ab0FSIoF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 Jun 2010 04:44:05 -0400
In-Reply-To: <87zkyro1xl.fsf@basil.nowhere.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Arjan van de Ven <arjan@infradead.org>, mingo@elte.hu, tglx@linutronix.de, bphilips@suse.de, yinghai@kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, jeff@garzik.org, linux-ide@vger.kernel.org, stern@rowland.harvard.edu, gregkh@suse.de, khali@linux-fr.org

Hello,

On 06/19/2010 10:35 AM, Andi Kleen wrote:
>> I would like to suggest an (optional) argument to this with a duration
>> within which to expect an interrupt....
>>
>> that way in the backend we can plumb this also into the idle handler
>> for C state selection...
> 
> I'm not sure it's really that useful to power optimize
> the lost interrupts polling case. It's just a last resort
> fallback anyways and will be always less power efficient
> because there will be unnecessary polls.

IIUC, it's not to help or optimize polling itself.  It just gives us a
way to estimate when the next interrupt would be so that power can be
optimized for non polling cases.

Thanks.

-- 
tejun
