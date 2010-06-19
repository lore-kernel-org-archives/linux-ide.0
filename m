From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 09/12] irq: implement IRQ expecting
Date: Sat, 19 Jun 2010 21:49:37 +0200
Message-ID: <20100619194937.GR18946@basil.fritz.box>
References: <1276443098-20653-1-git-send-email-tj@kernel.org>
 <1276443098-20653-10-git-send-email-tj@kernel.org>
 <20100616204854.4b036f87@infradead.org>
 <87zkyro1xl.fsf@basil.nowhere.org>
 <4C1C830B.5020806@kernel.org>
 <20100619090031.GE18946@basil.fritz.box>
 <20100619075451.48c13589@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:54999 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756735Ab0FSTtj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 19 Jun 2010 15:49:39 -0400
Content-Disposition: inline
In-Reply-To: <20100619075451.48c13589@infradead.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andi Kleen <andi@firstfloor.org>, Tejun Heo <tj@kernel.org>, mingo@elte.hu, tglx@linutronix.de, bphilips@suse.de, yinghai@kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, jeff@garzik.org, linux-ide@vger.kernel.org, stern@rowland.harvard.edu, gregkh@suse.de, khali@linux-fr.org

> Here we have the opportunity to get real good information.. we KNOW
> now an interrupt is coming, and we can even estimate how long it'll
> be...  Even for the first few after a long time, before a pattern
> emerges.

Ok but I thought the driver would just fill in a single number 
likely. Is that really that good information?

Alternatively each driver would need to implement some dynamic
estimation algorithm, but that would be just mostly equivalent
to having it all in the idle governour?

-Andi
-- 
ak@linux.intel.com -- Speaking for myself only.
