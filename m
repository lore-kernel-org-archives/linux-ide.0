From: Edward Falk <efalk@google.com>
Subject: Re: [PATCH linux-2.6.13-rc3] SATA: rewritten sil24 driver
Date: Thu, 04 Aug 2005 11:46:51 -0700
Message-ID: <42F2629B.70407@google.com>
References: <20050728013622.GA14026@htj.dyndns.org> <42E93FB9.6090800@pobox.com> <20050730081734.GA14242@htj.dyndns.org> <42EFFA05.8010003@google.com> <42F04361.4020001@pobox.com> <20050803142812.GA25446@htj.dyndns.org> <20050804022025.GA19237@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 216-239-45-4.google.com ([216.239.45.4]:18371 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S262596AbVHDSsq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 4 Aug 2005 14:48:46 -0400
In-Reply-To: <20050804022025.GA19237@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Carlos Pardo <Carlos.Pardo@siliconimage.com>


>  I agree that above code should clear both.  Just wanna verify.  Have
> you tested it and/or do you have any information confirming this?  If
> we don't have any further info, I think we should read PORT_SLOT_STAT
> before clearing PORT_IRQ_STAT to be on the safe side.

I've implemented the clear_irq() function to clear all interrupts as you 
said, but haven't had time to test this thoroughly.  Ultimately, we 
don't know if it works until we experience real errors and see how the 
system responds.

I don't think it matters in which order you do things, as long as you 
allow for the fact that reading PORT_SLOT_STAT will clear the command 
completion interrupt flag.

	-ed
