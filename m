From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 11/12] libata: use IRQ expecting
Date: Fri, 25 Jun 2010 11:51:50 +0200
Message-ID: <4C247C36.6040007@kernel.org>
References: <1276443098-20653-1-git-send-email-tj@kernel.org> <1276443098-20653-12-git-send-email-tj@kernel.org> <4C23F6C1.7070603@garzik.org> <4C245E50.7090701@kernel.org> <4C247B54.2050900@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43763 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751896Ab0FYJwf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 25 Jun 2010 05:52:35 -0400
In-Reply-To: <4C247B54.2050900@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: mingo@elte.hu, tglx@linutronix.de, bphilips@suse.de, yinghai@kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, stern@rowland.harvard.edu, gregkh@suse.de, khali@linux-fr.org

Hello,

On 06/25/2010 11:48 AM, Jeff Garzik wrote:
> My basic point is that you are implicitly changing the entire
> ata_qc_complete() API, and associated underlying assumptions.
> 
> The existing assumption, since libata day #0, is that ata_qc_complete()
> works entirely within the scope of a single qc -- thus enabling multiple
> calls for a single controller interrupt.  Your change greatly widens the
> scope to an entire port.

Yeah, I'm changing that and it actually reduces code.

> This isn't just an issue with sata_mv, that was just the easy example I
> remember off the top of my head.  sata_fsl and sata_nv also make the
> same assumption.  And it's a reasonable assumption, IMO.

Yeah, already updating all of them.

> I think an unexpect_irq() call is more appropriate outside
> ata_qc_complete().

The choices we have here are....

1. Update completion API so that libata core layer has enough
   information to decide expect/unexpect events.

2. Add expect/unexpect calls to individual drivers.

I think #1 is much better now and in the long run.  The code actually
looks better too.

Thanks.

-- 
tejun
