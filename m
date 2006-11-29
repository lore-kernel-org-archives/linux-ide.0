From: Mark Lord <liml@rtr.ca>
Subject: Re: Scary Intel SATA problem: "frozen"
Date: Wed, 29 Nov 2006 09:11:43 -0500
Message-ID: <456D951F.8000903@rtr.ca>
References: <456CB72A.3010004@local.se> <456CDB06.40806@gmail.com> <456D3370.5050003@local.se> <456D36BF.1060809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:11013 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S934614AbWK2OLq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Nov 2006 09:11:46 -0500
In-Reply-To: <456D36BF.1060809@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jonas@local.se, linux-ide@vger.kernel.org, torvalds@osdl.org

Tejun Heo wrote:
>
> You pushed your box really hard and the kernel can't get the memory it 
> wants.  Not really relevant to SATA problem.

...unless the slowdown is due to extraordinarily high swap activity,
because of the low-memory situation..

