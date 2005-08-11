From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] IDE: don't offer IDE_GENERIC on ia64
Date: Thu, 11 Aug 2005 19:49:12 -0400
Message-ID: <42FBE3F8.1090006@pobox.com>
References: <200508111424.43150.bjorn.helgaas@hp.com> <20050811214807.GA9775@havoc.gtf.org> <42FBC985.4030602@pobox.com> <200508111707.30861.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:20905 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932199AbVHKXtZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 11 Aug 2005 19:49:25 -0400
In-Reply-To: <200508111707.30861.bjorn.helgaas@hp.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>

Bjorn Helgaas wrote:
> You deduce this by the absence of SecO and PriO?  I wonder if lspci
> should be enhanced to notice this, too.  I assume that the IRQ 169
> doesn't correspond to anything in /proc/interrupts.

Correct.


> So the scenario in question (correct me if I'm wrong) is that we
> have a PCI IDE device that is handed off in compatibility mode (and
> may only work in that mode).  In that case, the PCI *device* still
> exists, so shouldn't the IDE PCI code claim that device, notice that
> it's in compatibility mode, and use the legacy ports and IRQs if
> necessary?
> 
> It seems like that all should work even if we don't have IDE_GENERIC.

Yes, you're right.  Thinking more, the PCI IDE code should pick that up, 
not the IDE_GENERIC code.

	Jeff


