From: Mark Lord <kernel@teksavvy.com>
Subject: Re: 3.2.14: Marvell 88SE9123 PCIe SATA 6.0 Gb/s controller not working
Date: Sat, 14 Apr 2012 08:45:06 -0400
Message-ID: <4F897152.6030100@teksavvy.com>
References: <4F888C09.5000408@fold.natur.cuni.cz> <4F896FEB.3090303@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport-out.teksavvy.com ([206.248.143.162]:2478 "EHLO
	ironport-out.teksavvy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161Ab2DNMpI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Apr 2012 08:45:08 -0400
In-Reply-To: <4F896FEB.3090303@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On 12-04-14 08:39 AM, Mark Lord wrote:
> On 12-04-13 04:26 PM, Martin Mokrejs wrote:
>> Hi,
>>   I am looking for an Express Card to plug into my laptop to provide additional
>> eSATA port. I just tried two cards, incidentally having same chipset. One was
>> from Axago ECS-6S (1x eSATA port) and the other was Kouwell EK-113 (2x eSATA).
>> Both cards have just one/two eSATA ports but kernel tries to assign many ata ports
>> (see the logs). And this was probably fatal issue:
> 
> I have/use this single-port card with port-multipliers and single drives,
> and it works very well under all kernels from the past couple of years:
> 
>    http://www.dealextreme.com/p/1-port-esata-expresscard-34mm-expansion-card-for-laptops-3gbps-28899
>    0d:00.0 SATA controller: JMicron Technology Corp. JMB360 AHCI Controller (rev 02)
> 
> There is also a 2-port version, which probably works just as well,
> but I don't have one (yet -- on order).
> 
>   http://www.dealextreme.com/p/54mm-express-card-to-2-port-esata-raid-card-for-notebook-48004
> 
> Do NOT get any of the combo USB3/eSATA cards, because the eSATA ports on those
> are really just USB3 internally.  So they work with port multipliers,
> but they don't provide raw drive access.  I have one of those here as well.

Correction:  the USB3/eSATA combo cards do NOT work with port-multipliers on the "eSATA" port.
They do work with USB3 based port multiplers plugged into the USB3 port.

Cheers
