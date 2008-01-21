From: Tejun Heo <htejun@gmail.com>
Subject: Re: ATA device reset, shoud I be concerned?
Date: Mon, 21 Jan 2008 23:31:11 +0900
Message-ID: <4794ACAF.70505@gmail.com>
References: <200801140019.20668.g.chulkov@jacobs-university.de>	<20080115025435.1e21b703.akpm@linux-foundation.org>	<20080115113552.75731bf8@lxorguk.ukuu.org.uk>	<4794501E.90306@gmail.com>	<20080121130256.2443d7c1@lxorguk.ukuu.org.uk>	<47949AA4.9090601@gmail.com> <20080121141425.45aa9c61@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.233]:29368 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754119AbYAUObV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2008 09:31:21 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1087573nze.1
        for <linux-ide@vger.kernel.org>; Mon, 21 Jan 2008 06:31:18 -0800 (PST)
In-Reply-To: <20080121141425.45aa9c61@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, Georgi Chulkov <g.chulkov@jacobs-university.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>

Alan Cox wrote:
>> while IDE thinks that IRQ might be lost and complete the command if the
>> TF status register says so.
> 
> For PATA at least that makes a lot of sense. It would probably make the
> Promise driver a lot more stable too.

Can you elaborate a bit?  I don't really think completing a command
after 30sec timeout contributes a lot to driver stability.

>> It could be that the particular device doesn't raise IRQ on certain
>> error conditions but updates TF registers.  After timeout, IDE completes
>> the command with the indicated error while libata ignores the status and
>> resets the device.
> 
> And loses the important information like media errors
>  
>> libata never touches TF register after timeout because some controllers
>> lock up hard if TF register is read after certain error conditions
>> (event the status register).
> 
> Should that not then be a per host flag ?

Yeah, that would be the best.  The problem is that there are several
different kinds of timeouts and we don't know which controller locks up
after which timeout and investigating them is really difficult.

IMHO, losing media error information is much better than locking up a
machine hard.  We can start white listing known good controllers but I'm
skeptical how much benefit it will bring.

Thanks.

-- 
tejun
