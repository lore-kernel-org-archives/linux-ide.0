From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 09/12] irq: implement IRQ expecting
Date: Sat, 19 Jun 2010 11:03:24 +0200
Message-ID: <4C1C87DC.6060405@kernel.org>
References: <1276443098-20653-1-git-send-email-tj@kernel.org> <1276443098-20653-10-git-send-email-tj@kernel.org> <20100616204854.4b036f87@infradead.org> <87zkyro1xl.fsf@basil.nowhere.org> <4C1C830B.5020806@kernel.org> <20100619090031.GE18946@basil.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34496 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754834Ab0FSJEY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 19 Jun 2010 05:04:24 -0400
In-Reply-To: <20100619090031.GE18946@basil.fritz.box>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Arjan van de Ven <arjan@infradead.org>, mingo@elte.hu, tglx@linutronix.de, bphilips@suse.de, yinghai@kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, jeff@garzik.org, linux-ide@vger.kernel.org, stern@rowland.harvard.edu, gregkh@suse.de, khali@linux-fr.org

Hello,

On 06/19/2010 11:00 AM, Andi Kleen wrote:
>> IIUC, it's not to help or optimize polling itself.  It just gives us a
>> way to estimate when the next interrupt would be so that power can be
>> optimized for non polling cases.
> 
> Shouldn't the idle governour estimate this already?

I'm not an expert on the subject.  According to Arjan,

  One of the hard cases right now that the C state code has is that it
  needs to predict the future. While it has a ton of heuristics,
  including some is there IO oustanding" ones, libata is a really good
  case: libata will know generally that within one seek time (5 msec
  on rotating rust, much less on floating electrons) there'll be an
  interrupt (give or take, but this is what we can do heuristics for
  on a per irq level).  So it's a good suggestion of what the future
  will be like, MUCH better than any hint we have right now... all we
  have right now is some history, and when the next timer is....

So, it seems like it would help.

Thanks.

-- 
tejun
