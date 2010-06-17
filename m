From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH 09/12] irq: implement IRQ expecting
Date: Wed, 16 Jun 2010 20:48:54 -0700
Message-ID: <20100616204854.4b036f87@infradead.org>
References: <1276443098-20653-1-git-send-email-tj@kernel.org>
	<1276443098-20653-10-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:52060 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756910Ab0FQDt5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jun 2010 23:49:57 -0400
In-Reply-To: <1276443098-20653-10-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: mingo@elte.hu, tglx@linutronix.de, bphilips@suse.de, yinghai@kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, jeff@garzik.org, linux-ide@vger.kernel.org, stern@rowland.harvard.edu, gregkh@suse.de, khali@linux-fr.org

On Sun, 13 Jun 2010 17:31:35 +0200
Tejun Heo <tj@kernel.org> wrote:
> + */
> +void expect_irq(struct irq_expect *exp)


I would like to suggest an (optional) argument to this with a duration
within which to expect an interrupt....

that way in the backend we can plumb this also into the idle handler
for C state selection...


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
