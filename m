From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 09/12] irq: implement IRQ expecting
Date: Fri, 18 Jun 2010 11:23:14 +0200
Message-ID: <4C1B3B02.2040209@kernel.org>
References: <1276443098-20653-1-git-send-email-tj@kernel.org>	<1276443098-20653-10-git-send-email-tj@kernel.org>	<20100616204854.4b036f87@infradead.org>	<4C19DA64.8000409@kernel.org>	<alpine.LFD.2.00.1006171310560.4290@localhost.localdomain>	<4C1A05AF.5010405@kernel.org>	<20100617124343.5889067c@lxorguk.ukuu.org.uk>	<4C1A4548.3020602@kernel.org>	<20100617090229.543af62c@infradead.org>	<4C1A5197.8060409@kernel.org> <20100617232649.6db5cc55@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100617232649.6db5cc55@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Thomas Gleixner <tglx@linutronix.de>, mingo@elte.hu, bphilips@suse.de, yinghai@kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, jeff@garzik.org, linux-ide@vger.kernel.org, stern@rowland.harvard.edu, gregkh@suse.de, khali@linux-fr.org
List-Id: linux-ide@vger.kernel.org

Hello,

On 06/18/2010 08:26 AM, Arjan van de Ven wrote:
> On Thu, 17 Jun 2010 18:47:19 +0200
> Tejun Heo <tj@kernel.org> wrote:
> 
>>
>> Hmmm... the thing is that there will be many cases which won't fit
>> irq_expect() model (why irq_watch() exists in the first place) and for
>> the time being libata is the only one providing that data.  Would the
>> data still be useful to determine which c-state to use?
> 
> yes absolutely. One of the hard cases right now that the C state code
> has is that it needs to predict the future. While it has a ton of
> heuristics, including some is there IO oustanding" ones, libata is a
> really good case: libata will know generally that within one seek time
> (5 msec on rotating rust, much less on floating electrons) there'll be
> an interrupt (give or take, but this is what we can do heuristics for
> on a per irq level).
> So it's a good suggestion of what the future will be like, MUCH better
> than any hint we have right now... all we have right now is some
> history, and when the next timer is.... 

Cool, good to know.  It shouldn't be difficult to at all to add.  Once
the whole thing gets generally agreed on, I'll work on that.

Thomas, Ingo, through which tree should these patches routed through?
Shall I set up a separate branch?

Thanks.

-- 
tejun
