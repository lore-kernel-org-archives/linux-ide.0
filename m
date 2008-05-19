From: Scott Wood <scottwood@freescale.com>
Subject: Re: Oops with PREEMPT-RT on 2.6.25.4
Date: Mon, 19 May 2008 16:11:12 -0500
Message-ID: <4831ECF0.5090101@freescale.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B0469010C@ismail.innsys.innovsys.com>	<4831D527.2020907@freescale.com> <DCEAAC0833DD314AB0B58112AD99B93B04690162@ismail.innsys.innovsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from az33egw01.freescale.net ([192.88.158.102]:52427 "EHLO
	az33egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758559AbYESVKe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 May 2008 17:10:34 -0400
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B04690162@ismail.innsys.innovsys.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rune Torgersen <runet@innovsys.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Rune Torgersen wrote:
> Scott Wood wrote:
>> You're recursively entering lock_timer_base, which does a
>> spin_lock_irqsave().  Either interrupts are enabled when they should
>> not be, or an interrupt was supposed to be threaded that isn't.
> 
> Sort of figured. How do I figure out which one, and how to fix it?

Almost certainly the latter.  Is the disk interrupt shared with any 
other interrupts, that are marked IRQF_NODELAY?  The -rt patch doesn't 
seem to handle mixing the two well.

Oh, and just to be sure: you do have CONFIG_PREEMPT_RT turned on, and 
not just CONFIG_PREEMPT, right?  The non-preempt-rt versions in the -rt 
patch don't look like they disable interrupts, though I may just be 
getting lost in a sea of underscores and ifdefs.

-Scott

