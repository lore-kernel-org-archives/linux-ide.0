From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 09/12] irq: implement IRQ expecting
Date: Mon, 14 Jun 2010 11:21:59 +0200
Message-ID: <4C15F4B7.5040601@gmail.com>
References: <1276443098-20653-1-git-send-email-tj@kernel.org> <1276443098-20653-10-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56323 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755783Ab0FNJWD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Jun 2010 05:22:03 -0400
In-Reply-To: <1276443098-20653-10-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: mingo@elte.hu, tglx@linutronix.de, bphilips@suse.de, yinghai@kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, jeff@garzik.org, linux-ide@vger.kernel.org, stern@rowland.harvard.edu, gregkh@suse.de, khali@linux-fr.org

On 06/13/2010 05:31 PM, Tejun Heo wrote:
> --- a/kernel/irq/spurious.c
> +++ b/kernel/irq/spurious.c
...

> @@ -25,9 +26,43 @@ enum {
>  	/* IRQ polling common parameters */
>  	IRQ_POLL_SLOW_INTV		= 3 * HZ,	/* not too slow for ppl, slow enough for machine */
>  	IRQ_POLL_INTV			= HZ / 100,	/* from the good ol' 100HZ tick */
> +	IRQ_POLL_QUICK_INTV		= HZ / 1000,	/* pretty quick but not too taxing */
>  
>  	IRQ_POLL_SLOW_SLACK		= HZ,
>  	IRQ_POLL_SLACK			= HZ / 1000,	/* 10% slack */
> +	IRQ_POLL_QUICK_SLACK		= HZ / 10000,	/* 10% slack */

Hi. These are zeros on most systems (assuming distros set HZ=100 and
250), what is their purpose then?

regards,
-- 
js
