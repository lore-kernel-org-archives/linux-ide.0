From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata-dev bugreport (Promise TX2plus PATA)
Date: Fri, 13 May 2005 14:09:52 -0400
Message-ID: <4284ED70.7040305@pobox.com>
References: <200504111448.01849.sanarin@nikiet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:25558 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262470AbVEMSKE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 May 2005 14:10:04 -0400
In-Reply-To: <200504111448.01849.sanarin@nikiet.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dmitry Sanarin <sanarin@nikiet.ru>
Cc: linux-ide@vger.kernel.org

Dmitry Sanarin wrote:
>  I have Promise TX2plus controller. This controller has 3 interfaces : 2 SATA 
> and PARA. SATA interfaces works fine. PATA work correctly only with one 
> drive. Adding second PATA drive causes seriuos filesystem damage.
>  Linux kernel 2.6.11 + latest libata-dev patch from  
> http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/.

Thanks for the bug report.

I wonder if this has to do with Dual Master.

	Jeff



