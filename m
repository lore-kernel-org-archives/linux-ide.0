From: Jeff Garzik <jeff@garzik.org>
Subject: Re: ATA device reset, shoud I be concerned?
Date: Wed, 26 Aug 2009 23:07:01 -0400
Message-ID: <4A95F855.5010706@garzik.org>
References: <200801140019.20668.g.chulkov@jacobs-university.de>	<20080115025435.1e21b703.akpm@linux-foundation.org>	<20080115113552.75731bf8@lxorguk.ukuu.org.uk>	<4794501E.90306@gmail.com>	<20080121130256.2443d7c1@lxorguk.ukuu.org.uk>	<47949AA4.9090601@gmail.com> <20080121141425.45aa9c61@lxorguk.ukuu.org.uk> <4794ACAF.70505@gmail.com> <4794AD3F.40309@gmail.com> <4A95F212.5060008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:54933 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751045AbZH0DHN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 26 Aug 2009 23:07:13 -0400
In-Reply-To: <4A95F212.5060008@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Georgi Chulkov <g.chulkov@jacobs-university.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>

On 08/26/2009 10:40 PM, Robert Hancock wrote:
> On 01/21/2008 08:33 AM, Tejun Heo wrote:
>> Tejun Heo wrote:
>>> IMHO, losing media error information is much better than locking up a
>>> machine hard. We can start white listing known good controllers but I'm
>>> skeptical how much benefit it will bring.
>>
>> Just a data point, even ICHs lock up after PHY event if the wrong TF
>> register is accessed. I just don't think tempting with TF regs after
>> timeout is worth the cost.
>
> Nvidia CK804 SATA controllers appear to also explode on reading TF
> registers after media errors in certain cases. (They tend to either
> lockup the machine or throw HyperTransport timeout machine check
> exceptions). I suspect those error paths aren't well tested (except that
> it even explodes in Windows with the default Microsoft IDE driver, when
> reading a scratched DVD on a SATA drive, for example.)

Well, reading TF when DMA or other operation is enabled is a big 
no-no...  according to spec.  If we are touching TF before data xfer 
operation is completed, and host controller has a chance to receive D2H 
FIS, TF is undefined (except Status, in some cases).

	Jeff




