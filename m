From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: libata machine check on Alpha
Date: Thu, 06 Apr 2006 15:14:59 +0800
Message-ID: <4434BFF3.3080005@tw.ibm.com>
References: <2E9B8131C44AF746B1E06BF9B15A434B045D8198@mail.siliconimage.com> <44347713.9000408@tw.ibm.com> <44347A3D.1000609@garzik.org> <44347D9E.8080107@gmail.com> <200604060644.k366i0O6007713@falcon30.maxeymade.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:1002 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932120AbWDFHPN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Apr 2006 03:15:13 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e33.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k367F801026981
	for <linux-ide@vger.kernel.org>; Thu, 6 Apr 2006 03:15:08 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k367BkOS263550
	for <linux-ide@vger.kernel.org>; Thu, 6 Apr 2006 01:11:46 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k367F63G030218
	for <linux-ide@vger.kernel.org>; Thu, 6 Apr 2006 01:15:07 -0600
In-Reply-To: <200604060644.k366i0O6007713@falcon30.maxeymade.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Doug Maxey <dwm@falcon30.maxeymade.com>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, albertl@mail.com, Carlos Pardo <Carlos.Pardo@siliconimage.com>, Jonathan Blake Benson <airbatica@verizon.net>, linux-ide@vger.kernel.org

Doug Maxey wrote:
> On Thu, 06 Apr 2006 14:38:39 +0800, Albert Lee wrote:
> 
>>Tejun Heo wrote:
>>
>>>Jeff Garzik wrote:
>>>
>>>>DMADIR is in my copy of ATA-7...
>>>>
>>>
>>>Here's the relavant part from ATA8 draft.  It seems that the bridge is
>>>supposed to mangle the IDENTIFY PACKET DEVICE result.  It's supposed to
>>>nuke all DMA transfer mode information reported from the original device
>>>and report supported modes from the view point of the bridge in bits
>>>10:1 (which, BTW, should be all 1's).
>>>
>>>The question is whether or not bridges implement this properly. I think
>>>we can add a printk to word 62 and ask Jonathan to test it.
>>>
>>
>>Ah, thanks for the info. The DMADIR is in my copy ATA-7, too.
>>I just checked word 50 and overlooked it. :(
>>I should have checked other part of the spec...
>>
>>Anyway, will try to make a patch based on the ATA-7 spec.
> 
> 
> Do we have any devices to test your patch with?  Perhaps in Rochester?
> 

Yes, we have some Marvell bridges in Rochester to test.
I'll also test the JMicron bridge, once the auto enable DMADIR patch is ready.
We have no SiI 3611 at hand, so, need Jonathan's help.

--
Albert


