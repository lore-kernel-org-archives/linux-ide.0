From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 5/6] sata_sil: convert sil_port[] to u16 from unsigned
 long
Date: Sun, 05 Mar 2006 10:50:20 -0500
Message-ID: <440B08BC.5090409@pobox.com>
References: <1141542232248-git-send-email-htejun@gmail.com> <440A969A.5090503@pobox.com> <440A97CD.30404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:3283 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932158AbWCEPuZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Mar 2006 10:50:25 -0500
In-Reply-To: <440A97CD.30404@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Carlos.Pardo@siliconimage.com, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Jeff Garzik wrote:
> 
>> Tejun Heo wrote:
>>
>>> unsigned long is way too big for sil_port[] offsets (currently the
>>> table is 256 bytes on 64bit machines).  Convert sil_port[] to u16.
>>>
>>> Signed-off-by: Tejun Heo <htejun@gmail.com>
>>
>>
>>
>> NAK.  This just forces the compiler to promote these from u16 to 
>> machine int (i.e. unsigned long) at addition time.  Table size is a 
>> very trivial matter.
>>
> 
> Wouldn't that be cheaper than extra cache lines? I'm pretty sure it 
> would be on x86/64.

Actually, when I got this reply, I looked at it again.  sil_port[] is 
only used at startup, therefore performance is not an issue, and we 
don't care (within reason) how big the table is.  So, I would rather 
leave it in native format (machine int -> unsigned long).

	Jeff



