From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 09/12] irq: implement IRQ expecting
Date: Sat, 19 Jun 2010 10:35:02 +0200
Message-ID: <87zkyro1xl.fsf@basil.nowhere.org>
References: <1276443098-20653-1-git-send-email-tj@kernel.org>
	<1276443098-20653-10-git-send-email-tj@kernel.org>
	<20100616204854.4b036f87@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100616204854.4b036f87@infradead.org> (Arjan van de Ven's
	message of "Wed, 16 Jun 2010 20:48:54 -0700")
Sender: linux-kernel-owner@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, mingo@elte.hu, tglx@linutronix.de, bphilips@suse.de, yinghai@kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, jeff@garzik.org, linux-ide@vger.kernel.org, stern@rowland.harvard.edu, gregkh@suse.de, khali@linux-fr.org
List-Id: linux-ide@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> writes:

> On Sun, 13 Jun 2010 17:31:35 +0200
> Tejun Heo <tj@kernel.org> wrote:
>> + */
>> +void expect_irq(struct irq_expect *exp)
>
>
> I would like to suggest an (optional) argument to this with a duration
> within which to expect an interrupt....
>
> that way in the backend we can plumb this also into the idle handler
> for C state selection...

I'm not sure it's really that useful to power optimize
the lost interrupts polling case. It's just a last resort
fallback anyways and will be always less power efficient
because there will be unnecessary polls.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
