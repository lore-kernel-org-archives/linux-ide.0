From: Tejun Heo <htejun@gmail.com>
Subject: Re: Sil3112 bugfix: wich one???
Date: Tue, 17 May 2005 10:21:35 +0900
Message-ID: <4289471F.1050402@gmail.com>
References: <200505041624.44269.kanniball@zmail.pt> <200505170043.28320.kanniball@zmail.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.198]:11190 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261275AbVEQBVl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 May 2005 21:21:41 -0400
Received: by rproxy.gmail.com with SMTP id i8so589456rne
        for <linux-ide@vger.kernel.org>; Mon, 16 May 2005 18:21:41 -0700 (PDT)
In-Reply-To: <200505170043.28320.kanniball@zmail.pt>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kanniball@zmail.pt
Cc: linux-ide@vger.kernel.org

Kanniball wrote:
> Nobody can answer me???
> Jeff, Tejun...
> 
> On Wednesday 04 May 2005 16:24, Kanniball wrote:
> 
>>Hi!
>>
>>There are two patches for fixing the problem with Silicon Image 311x SATA
>>controllers, one from Silicon Image and other from Tejun Heo.
>>Wich one "we" should apply?
>>
>>Thanks for your patience and for your work!
>>
>>Best regards,
>>
>>Paulo Fidalgo, aka Kanniball
>>

  Hi,

  I think I've replied but I'm pretty delusional. :-)

  The two patches are independent.  Just apply both.  AFAIK, the patch 
from Silicon Image applies to only small number of equipments, and if 
you were using the controller okay except for low performance, sil patch 
wouldn't do much for you.  But it can't hurt.

  Thanks.

-- 
tejun
