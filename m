From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: [PATCHSET] implement and use port_task
Date: Thu, 09 Mar 2006 16:39:50 +0800
Message-ID: <440FE9D6.9040006@tw.ibm.com>
References: <11415401073423-git-send-email-htejun@gmail.com> <440D2497.7050504@tw.ibm.com> <440D3465.1040203@pobox.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:29589 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750740AbWCIIkC
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 9 Mar 2006 03:40:02 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k298duBr014302
	for <linux-ide@vger.kernel.org>; Thu, 9 Mar 2006 03:39:56 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k298gkR7178706
	for <linux-ide@vger.kernel.org>; Thu, 9 Mar 2006 01:42:46 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k298dtdE024499
	for <linux-ide@vger.kernel.org>; Thu, 9 Mar 2006 01:39:55 -0700
In-Reply-To: <440D3465.1040203@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: albertl@mail.com, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> 
> 
> Polling DMA support with nIEN=1 is theoretically invalid.  You are not
> supposed to touch the ATA shadow register set until after receiving an
> irq event.
> 
> On chipsets where nIEN=0 and the chip's IntrMask is also zero, its doable.
> 
> I'm satisfied with simply never doing polling DMA, and change our mind
> only if a critical need arises.
> 
> 

Understand. After checking the code, polling DMA looks bad idea.
Thanks for the advice.

BTW, Tejun's proposal of pseudo periodic interrupts reminds me
of some patches to integrate the polling pio with irq-pio.
Will submit the patches for your review later.

Albert

