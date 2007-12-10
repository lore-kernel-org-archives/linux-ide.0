From: Tejun Heo <htejun@gmail.com>
Subject: Re: Failure with SATA DVD-RW
Date: Mon, 10 Dec 2007 18:45:16 +0900
Message-ID: <475D0AAC.3030408@gmail.com>
References: <cd32a0620712041608o7733db74xf4975dec44925730@mail.gmail.com>	<loom.20071206T012459-620@post.gmane.org> <20071206164043.589290f4.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:56950 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035AbXLJJpd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Dec 2007 04:45:33 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3247544wah
        for <linux-ide@vger.kernel.org>; Mon, 10 Dec 2007 01:45:33 -0800 (PST)
In-Reply-To: <20071206164043.589290f4.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Parag Warudkar <parag.warudkar@gmail.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Tom Lanyon <tomlanyon@gmail.com>

Andrew Morton wrote:
> (argh, shit, resent.  Please don't massage the cc list.  Do reply-to-all)
> 
> On Thu, 6 Dec 2007 01:33:16 +0000 (UTC)
> Parag Warudkar <parag.warudkar@gmail.com> wrote:
> 
>> Tom Lanyon <tomlanyon <at> gmail.com> writes:
>>
>>> scsi4: ahci
>>> ata5: SATA link up at 1.5 Gbps (SStatus 113 SControl 300)
>>> ata5.00: ATAPI, max UDMA/66
>>> ata5.00: qc timeout (cmd 0xef)
>>> ata5.00: failed to set xfermode (err_mask=0x104)
>>> ata5.00: limiting speed to UDMA/44
>>> ata5: failed to recover some devices, retrying in 5 secs
>>> ata5: port is slow to respond, please be patient (Status 0x80)
>>> ata5: port failed to respond (30 secs, status 0x80)
>>> ata5: COMRESET failed (device not ready)
>>> ata5: hardreset failed, retrying in 5 secs
>>> ata5: SATA link up at 1.5 Gbps (SStatus 113 SControl 300)
>>> ata5.00: ATAPI, max UDMA/66
>>> ata5.00: qc timeout (cmd 0xef)
>>> ata5.00: failed to set xfermode (err_mask=0x104)
>>> ata5.00: limiting speed to PIO0
>>> ata5: failed to recover some devices, retrying in 5 secs
>>> ata5: port is slow to respond, please be patient (Status 0x80)
>>> ata5: port failed to respond (30 secs, status 0x80)
>>> ata5: COMRESET failed (device not ready)
>>> ata5: hardreset failed, retrying in 5 secs
>>> ata5.00: ATAPI, max UDMA/66
>>> ata5.00: qc timeout (cmd 0xef)
>>> ata5.00: failed to set xfermode (err_mask=0x104)
>>> ata5.00: disabled
>>>
>> Looks like it is trying to set transfer mode to UDMA/66 and failing. After 
>> that it tried UDMA/44 and failed again. Next UDMA/66 again with unsurprising 
>> result - failed. After that PIO0 which seems to cause some kind of trouble, 
>> then it tries UDMA/66 again, and I am not stating the result again :) ! 
>>
>>> Any ideas what to try to get it working under AHCI?
>>>
>> I recall reading somewhere - the Pioneer drive needs UDMA/33 which it did not 
>> try in your case - need to some how have it try UDMA/33 but I don't find a 
>> boot parameter which will do that. So may be adding a quirk for this device to 
>> limit the xfer mode to 33 may work. 
>>
>> What does your dmesg output for the drives look like when you run in IDE 
>> compat mode? (Particularly the DMA for this drive?)
>>

Also, does irqpoll help?

-- 
tejun
