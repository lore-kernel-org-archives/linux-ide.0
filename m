From: Tony Battersby <tonyb@cybernetics.com>
Subject: Re: [stable] [PATCH] ide: fix serverworks.c UDMA regression
Date: Wed, 14 Nov 2007 09:34:47 -0500
Message-ID: <473B0787.1010805@cybernetics.com>
References: <4713B9FA.8050803@cybernetics.com> <200710162125.41987.bzolnier@gmail.com> <20071113232859.GB10338@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from host06.cybernetics.com ([206.246.200.22]:2135 "EHLO
	mail.cybernetics.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1754218AbXKNOep (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Nov 2007 09:34:45 -0500
In-Reply-To: <20071113232859.GB10338@kroah.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, stable@kernel.org

Greg KH wrote:
> On Tue, Oct 16, 2007 at 09:25:41PM +0200, Bartlomiej Zolnierkiewicz wrote:
>   
>> On Monday 15 October 2007, Tony Battersby wrote:
>>     
>>> The patch described by the following excerpt from ChangeLog-2.6.22 makes
>>> it impossible to use UDMA on a Tyan S2707 motherboard (SvrWks CSB5):
>>>
>>> commit 2d5eaa6dd744a641e75503232a01f52d0768884c
>>> Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>>> Date:   Thu May 10 00:01:08 2007 +0200
>>>
>>>     ide: rework the code for selecting the best DMA transfer mode (v3)
>>>
>>>     ...
>>>
>>> This one-line patch against 2.6.23 fixes the problem.
>>>       
>> Thanks!! (and sorry for the bug)
>>
>>     
>>> Signed-off-by: Tony Battersby <tonyb@cybernetics.com>
>>>       
>> applied
>>
>> Greg/Chris: this is a perfect candidate for 2.6.23.2
>>     
>
> Thanks, got it now.
>
> greg k-h
>
>   

Also applies to 2.6.22, if you are still maintaining that stable branch.

Thanks,
Tony

