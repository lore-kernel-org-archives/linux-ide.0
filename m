From: Doug Maxey <dwm@falcon30.maxeymade.com>
Subject: Re: libata machine check on Alpha
Date: Thu, 06 Apr 2006 01:44:00 -0500
Message-ID: <200604060644.k366i0O6007713@falcon30.maxeymade.com>
References: <2E9B8131C44AF746B1E06BF9B15A434B045D8198@mail.siliconimage.com> <44347713.9000408@tw.ibm.com> <44347A3D.1000609@garzik.org> <44347D9E.8080107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from falcon30.maxeymade.com ([24.173.215.190]:9144 "EHLO
	falcon30.maxeymade.com") by vger.kernel.org with ESMTP
	id S1750963AbWDFGov convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Apr 2006 02:44:51 -0400
In-reply-to: <4434B76F.7020206@tw.ibm.com> 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, albertl@mail.com, Carlos Pardo <Carlos.Pardo@siliconimage.com>, Jonathan Blake Benson <airbatica@verizon.net>, linux-ide@vger.kernel.org


On Thu, 06 Apr 2006 14:38:39 +0800, Albert Lee wrote:
>Tejun Heo wrote:
>> Jeff Garzik wrote:
>>=20
>>> Albert Lee wrote:
>>>
>>>> Per Jeff's comment, there is a document on t13
>>>> (http://www.t13.org/docs2003/e03131r0.pdf).
>>>> The documents reads:
>>>> "Eg. =96 Word 50, bit 13: Set to 1 for devices that support DMAIN =
bit
>>>> in Features Register for Packet Command".
>>>> However, this looks more for the ATAPI device than for the bridge?
>>>> Also it looks not a t13 standard yet?
>>>> Can we use this word 50 to identify 3611/3811?
>>>
>>>
>>>
>>> DMADIR is in my copy of ATA-7...
>>>
>>=20
>> Here's the relavant part from ATA8 draft.  It seems that the bridge =
is
>> supposed to mangle the IDENTIFY PACKET DEVICE result.  It's supposed=
 to
>> nuke all DMA transfer mode information reported from the original de=
vice
>> and report supported modes from the view point of the bridge in bits
>> 10:1 (which, BTW, should be all 1's).
>>=20
>> The question is whether or not bridges implement this properly. I th=
ink
>> we can add a printk to word 62 and ask Jonathan to test it.
>>=20
>
>Ah, thanks for the info. The DMADIR is in my copy ATA-7, too.
>I just checked word 50 and overlooked it. :(
>I should have checked other part of the spec...
>
>Anyway, will try to make a patch based on the ATA-7 spec.

Do we have any devices to test your patch with?  Perhaps in Rochester?

++doug

