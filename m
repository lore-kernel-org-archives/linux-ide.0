From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 02/12] irq: make spurious poll timer per desc
Date: Tue, 15 Jun 2010 18:34:25 +0200
Message-ID: <4C17AB91.1040207@kernel.org>
References: <1276443098-20653-1-git-send-email-tj@kernel.org> <1276443098-20653-3-git-send-email-tj@kernel.org> <20100615051027.GA8073@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56791 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757527Ab0FOQfC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Jun 2010 12:35:02 -0400
In-Reply-To: <20100615051027.GA8073@phenom.dumpdata.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: mingo@elte.hu, tglx@linutronix.de, bphilips@suse.de, yinghai@kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, jeff@garzik.org, linux-ide@vger.kernel.org, stern@rowland.harvard.edu, gregkh@suse.de, khali@linux-fr.org

On 06/15/2010 07:10 AM, Konrad Rzeszutek Wilk wrote:
>> @@ -169,6 +170,7 @@ struct irq_2_iommu;
>>   * @pending_mask:	pending rebalanced interrupts
>>   * @threads_active:	number of irqaction threads currently running
>>   * @wait_for_threads:	wait queue for sync_irq to wait for threaded handlers
>> + * @poll_timer:		timer for IRQ polling
> 
> I looked over the patches and they all look good to my eyes.
> 
> The only thing that looked out of place was the above comment.
> Would it make sense to move the comment one tab to the left?

When applied, it will show up at the right place.  It's because the
first tab ends next to ':' and the leading '+' ends up pushing it to
the next tab position.

Thanks.

-- 
tejun
