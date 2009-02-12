From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [patch for 2.6.29? 2/4] pata_amd: program FIFO
Date: Wed, 11 Feb 2009 22:10:10 -0600
Message-ID: <4993A122.7040807@gmail.com>
References: <200902112108.n1BL8gT6005295@imap1.linux-foundation.org> <49933FAE.1090006@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:29618 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751215AbZBLEKP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Feb 2009 23:10:15 -0500
Received: by yw-out-2324.google.com with SMTP id 5so292169ywh.1
        for <linux-ide@vger.kernel.org>; Wed, 11 Feb 2009 20:10:13 -0800 (PST)
In-Reply-To: <49933FAE.1090006@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: akpm@linux-foundation.org, linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Jeff Garzik wrote:
> akpm@linux-foundation.org wrote:
>> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>>
>> With 32bit PIO we can use the posted write buffers, but only for 32bit 
>> I/O
>> cycles.  This means we must disable the FIFO for ATAPI where a final 
>> 16bit
>> cycle may occur.
>>
>> Rework the FIFO logic so that we disable the FIFO then selectively
>> re-enable it when we set the timings on AMD devices.  Also fix a case
>> where we scribbled on PCI config 0x41 of Nvidia chips when we shouldn't.
>>
>> Signed-off-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> 
> Pinged Alan on 2/2, no response.
> 
> This seems necessary... but too instrusive and not yet well tested 
> enough for 2.6.29-rc?

I think we either need this patch or turn 32-bit PIO off for this driver 
for 2.6.29. Without either, things may break.
