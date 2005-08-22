From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH libata:upstream] fix atapi_packet_task vs. intr race (take
 2)
Date: Mon, 22 Aug 2005 02:54:41 -0400
Message-ID: <430976B1.5070007@pobox.com>
References: <4308E13E.6070104@gmail.com> <4308E2C9.6040605@pobox.com> <4308E6B1.6030001@gmail.com> <4308F114.9020608@pobox.com> <4308F450.4050402@gmail.com> <4308F943.9090706@pobox.com> <20050821235149.GA14097@htj.dyndns.org> <43091BFA.2020101@pobox.com> <20050822035956.GB28721@htj.dyndns.org> <43095156.7080500@pobox.com> <20050822055924.GA32362@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zeus1.kernel.org ([204.152.191.4]:31370 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751423AbVHVWdV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Aug 2005 18:33:21 -0400
Received: from mail.dvmed.net (mail.dvmed.net [216.237.124.58])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j7M6ssNu006340
	for <linux-ide@vger.kernel.org>; Sun, 21 Aug 2005 23:54:55 -0700
In-Reply-To: <20050822055924.GA32362@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
>  Hello, Jeff.
> 
>  Here's the updated patch.  Though I have a question.  Why always use

Looks OK to me.  Have you tested it?  :)


> spin_lock_irqsave()?  To improve maintainability?

Code is less fragile, since it works regardless of whether the code path 
even gets moved to a different or not.  And I think its more friendly to 
architectures (portable), as it has available a 'cookie' for which 
random arch-specific info can be stored.

	Jeff


