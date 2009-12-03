From: Jeff Garzik <jeff@garzik.org>
Subject: Re: What's in libata-dev.git?
Date: Thu, 03 Dec 2009 14:40:38 -0500
Message-ID: <4B181436.90008@garzik.org>
References: <20091203075653.GA30612@havoc.gtf.org> <200912031647.26342.bzolnier@gmail.com> <4B180E04.5030405@garzik.org> <200912032020.16608.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:35956 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753482AbZLCTkg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Dec 2009 14:40:36 -0500
In-Reply-To: <200912032020.16608.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>

On 12/03/2009 02:20 PM, Bartlomiej Zolnierkiewicz wrote:
> On Thursday 03 December 2009 08:14:12 pm Jeff Garzik wrote:
>> On 12/03/2009 10:47 AM, Bartlomiej Zolnierkiewicz wrote:
>>> ( Jeff, you probably would want to take ide-pci-generic fix to your tree
>>>     as libata-dev tree currently breaks build for IDE tree. )
>>
>> I didn't know that.
>
> You would know if you would be either:
>
> 	a) reading
>
> or
>
> 	b) building
>
> patches that you're applying.

Strange that I do both.

But still...  <looks>  ah, I had disabled the *generic drivers in the 
kernel build, and missed a missing comma.  Fixed and rebased #upstream.

	Jeff



