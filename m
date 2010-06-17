From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 09/12] irq: implement IRQ expecting
Date: Thu, 17 Jun 2010 10:18:44 +0200
Message-ID: <4C19DA64.8000409@kernel.org>
References: <1276443098-20653-1-git-send-email-tj@kernel.org>	<1276443098-20653-10-git-send-email-tj@kernel.org> <20100616204854.4b036f87@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100616204854.4b036f87@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: mingo@elte.hu, tglx@linutronix.de, bphilips@suse.de, yinghai@kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, jeff@garzik.org, linux-ide@vger.kernel.org, stern@rowland.harvard.edu, gregkh@suse.de, khali@linux-fr.org
List-Id: linux-ide@vger.kernel.org

Hello, Arjan.

On 06/17/2010 05:48 AM, Arjan van de Ven wrote:
> On Sun, 13 Jun 2010 17:31:35 +0200
> Tejun Heo <tj@kernel.org> wrote:
>> + */
>> +void expect_irq(struct irq_expect *exp)
> 
> I would like to suggest an (optional) argument to this with a duration
> within which to expect an interrupt....
> 
> that way in the backend we can plumb this also into the idle handler
> for C state selection...

Hmmm.... oh, I see.  Wouldn't it be much better to use moving avg of
IRQ durations instead of letting the driver specify it?  Drivers are
most likely to just hard code it and It's never gonna be accurate.

Thanks.

-- 
tejun
