From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: ATA device reset, shoud I be concerned?
Date: Wed, 26 Aug 2009 20:40:18 -0600
Message-ID: <4A95F212.5060008@gmail.com>
References: <200801140019.20668.g.chulkov@jacobs-university.de>	<20080115025435.1e21b703.akpm@linux-foundation.org>	<20080115113552.75731bf8@lxorguk.ukuu.org.uk>	<4794501E.90306@gmail.com>	<20080121130256.2443d7c1@lxorguk.ukuu.org.uk>	<47949AA4.9090601@gmail.com> <20080121141425.45aa9c61@lxorguk.ukuu.org.uk> <4794ACAF.70505@gmail.com> <4794AD3F.40309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f184.google.com ([209.85.211.184]:64919 "EHLO
	mail-yw0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754858AbZH0Cqo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Aug 2009 22:46:44 -0400
In-Reply-To: <4794AD3F.40309@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Georgi Chulkov <g.chulkov@jacobs-university.de>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Mark Lord <liml@rtr.ca>

On 01/21/2008 08:33 AM, Tejun Heo wrote:
> Tejun Heo wrote:
>> IMHO, losing media error information is much better than locking up a
>> machine hard.  We can start white listing known good controllers but I'm
>> skeptical how much benefit it will bring.
>
> Just a data point, even ICHs lock up after PHY event if the wrong TF
> register is accessed.  I just don't think tempting with TF regs after
> timeout is worth the cost.

Nvidia CK804 SATA controllers appear to also explode on reading TF 
registers after media errors in certain cases. (They tend to either 
lockup the machine or throw HyperTransport timeout machine check 
exceptions). I suspect those error paths aren't well tested (except that 
it even explodes in Windows with the default Microsoft IDE driver, when 
reading a scratched DVD on a SATA drive, for example.)
