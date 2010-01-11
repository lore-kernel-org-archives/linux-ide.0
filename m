From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: MSI broken in libata?
Date: Sun, 10 Jan 2010 19:39:38 -0600
Message-ID: <4B4A815A.60503@gmail.com>
References: <64bb37e0912250122n4e0e1842q88c0dad7e99ec6a7@mail.gmail.com>	 <4B484829.6060405@kernel.org> <64bb37e1001092033r1f0b4defw46c1a07101bb2d1b@mail.gmail.com> <4B4A7BC7.6060106@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:35408 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786Ab0AKBjl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 10 Jan 2010 20:39:41 -0500
In-Reply-To: <4B4A7BC7.6060106@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Torsten Kaiser <just.for.lkml@googlemail.com>, linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

On 01/10/2010 07:15 PM, Tejun Heo wrote:
> On 01/10/2010 01:33 PM, Torsten Kaiser wrote:
>> I did try the patch from Robert Hancock in
>> http://lkml.org/lkml/2010/1/6/417 ,but without success.
>>
>> if you need any more information, or have something for me to try,
>> please just ask. I did look at the code and the documentation about
>> enabling MSI, but did not see anything (obvious) wrong, so I don't
>> know what to try next.
>
> Can you please try the attached patch?
>
> Thanks.
>

It'd be interesting to see if it makes a difference, but I don't think 
the patch is quite right. According to the datasheet, doing the MSI ack 
while the interrupt source is still pending will cause a new MSI to be 
sent, so if you do it before handling the interrupt you'll generate a 
spurious interrupt after every real one.

Though, apparently my patch that did the MSI ack after the handling 
didn't help, so either that's wrong or the problem is unrelated. (I tend 
to suspect the latter, given that sata_nv is also failing in the same way.)
