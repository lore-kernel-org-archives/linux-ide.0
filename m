From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Re: no DRQ after issuing MULTWRITE_EXT ?
Date: Thu, 01 Feb 2007 14:33:12 +0100
Message-ID: <45C1EC18.5040802@imc-berlin.de>
References: <45C1B079.3080704@imc-berlin.de> <45C1E5CD.8010707@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:56712 "EHLO
	mx1.imc-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422867AbXBANdQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Feb 2007 08:33:16 -0500
In-Reply-To: <45C1E5CD.8010707@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

Hi,

>> I am seeing kernel messages like
> 
>> [ 1284.480000] hda: status timeout: status=0xd0 { Busy }
>> [ 1284.480000] ide: failed opcode was: unknown
>> [ 1284.480000] hda: no DRQ after issuing MULTWRITE_EXT
>> [ 1284.490000] ide0: unexpected interrupt, status=0x80, count=1
>> [ 1284.830000] ide0: reset: success
> 
>    Looks like a spurious interrupt... Is your IDE IRQ shared with other
> devices?
No.

But IIUC then first the HDD times out, the ide driver handles this and then
an irq occurs which is probably the irq the driver was waiting for. And
since the driver already handled the timeout that (delayed) irq is of course
"unexpected" ... (Just a guess)

>    Doubt it. The old ATA standard specified the maximum DRQ assertion
> time of 20 ms.
I know.

>> And will the request issued again after the reset of the drive?
> 
>    It should be.
Thanks.

Steven
