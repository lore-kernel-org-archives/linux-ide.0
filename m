From: Albert Lee <albertcc@tw.ibm.com>
Subject: Re: libata machine check on Alpha
Date: Thu, 06 Apr 2006 14:38:39 +0800
Message-ID: <4434B76F.7020206@tw.ibm.com>
References: <2E9B8131C44AF746B1E06BF9B15A434B045D8198@mail.siliconimage.com> <44347713.9000408@tw.ibm.com> <44347A3D.1000609@garzik.org> <44347D9E.8080107@gmail.com>
Reply-To: albertl@mail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:8843 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751136AbWDFGjF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Apr 2006 02:39:05 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e35.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k366cxUE001958
	for <linux-ide@vger.kernel.org>; Thu, 6 Apr 2006 02:38:59 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k366ZcOS250676
	for <linux-ide@vger.kernel.org>; Thu, 6 Apr 2006 00:35:38 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k366cw4A025116
	for <linux-ide@vger.kernel.org>; Thu, 6 Apr 2006 00:38:59 -0600
In-Reply-To: <44347D9E.8080107@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, albertl@mail.com, Carlos Pardo <Carlos.Pardo@siliconimage.com>, Jonathan Blake Benson <airbatica@verizon.net>, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Jeff Garzik wrote:
>=20
>> Albert Lee wrote:
>>
>>> Per Jeff's comment, there is a document on t13
>>> (http://www.t13.org/docs2003/e03131r0.pdf).
>>> The documents reads:
>>> "Eg. =96 Word 50, bit 13: Set to 1 for devices that support DMAIN b=
it
>>> in Features Register for Packet Command".
>>> However, this looks more for the ATAPI device than for the bridge?
>>> Also it looks not a t13 standard yet?
>>> Can we use this word 50 to identify 3611/3811?
>>
>>
>>
>> DMADIR is in my copy of ATA-7...
>>
>=20
> Here's the relavant part from ATA8 draft.  It seems that the bridge i=
s
> supposed to mangle the IDENTIFY PACKET DEVICE result.  It's supposed =
to
> nuke all DMA transfer mode information reported from the original dev=
ice
> and report supported modes from the view point of the bridge in bits
> 10:1 (which, BTW, should be all 1's).
>=20
> The question is whether or not bridges implement this properly. I thi=
nk
> we can add a printk to word 62 and ask Jonathan to test it.
>=20

Ah, thanks for the info. The DMADIR is in my copy ATA-7, too.
I just checked word 50 and overlooked it. :(
I should have checked other part of the spec...

Anyway, will try to make a patch based on the ATA-7 spec.
--
Albert

