From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 11/12] libata: use IRQ expecting
Date: Fri, 02 Jul 2010 16:53:43 +0200
Message-ID: <4C2DFD77.6070005@kernel.org>
References: <1276443098-20653-1-git-send-email-tj@kernel.org> <1276443098-20653-12-git-send-email-tj@kernel.org> <4C23F6C1.7070603@garzik.org> <4C245E50.7090701@kernel.org> <4C2577F2.4030005@garzik.org> <4C25BAD2.4070705@kernel.org> <4C25C551.8000404@garzik.org> <4C25CC18.2070507@kernel.org> <4C2DFAB0.3020703@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39187 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758043Ab0GBOyY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Jul 2010 10:54:24 -0400
In-Reply-To: <4C2DFAB0.3020703@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: mingo@elte.hu, tglx@linutronix.de, bphilips@suse.de, yinghai@kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, stern@rowland.harvard.edu, gregkh@suse.de, khali@linux-fr.org

On 07/02/2010 04:41 PM, Tejun Heo wrote:
> Hello, Jeff.
> 
> So, something like the following.  This should be applied on top of
> the two previous libata patches.  The amount of code in the hot path
> is very small.  Compared to the cpu actually taking an interrupt and
> accessing hardware, it should be negligible, and this will give us
> working and acceptably performing systems in the presence of most
> types of IRQ problems.

The whole tree is available in the following branch.

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git libata-irq-expect

Thanks.

-- 
tejun
