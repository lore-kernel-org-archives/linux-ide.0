From: Tejun Heo <htejun@gmail.com>
Subject: Re: Random libata notes
Date: Fri, 10 Mar 2006 23:33:47 +0900
Message-ID: <44118E4B.9050401@gmail.com>
References: <4409CF74.7030808@garzik.org> <44118B3D.9040103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.199]:57071 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751317AbWCJO4G (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Mar 2006 09:56:06 -0500
Received: by zproxy.gmail.com with SMTP id 14so771088nzn
        for <linux-ide@vger.kernel.org>; Fri, 10 Mar 2006 06:56:06 -0800 (PST)
In-Reply-To: <44118B3D.9040103@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Jens Axboe <axboe@suse.de>, Mark Lord <liml@rtr.ca>

Tejun Heo wrote:
> Jeff Garzik wrote:
> 
>> These are small TODO bits that I didn't want to forget...  Patches 
>> welcome.
>>
>> 1) ATAPI edge case.  Due to adding the padding s/g entry, we must 
>> adjust sg_tablesize to include ' - 1' for each driver
> 
> 
> Isn't this handled by ata_scsi_slave_config()? If the attached device is 
> ATAPI, ata_scsi_slave_config() reduces max_hw_segments by 1. We'll need 
> to increment it back when detaching the device though.
> 
>>
>> 2) ata_scsi_slave_config() hardcodes a call to
>> blk_queue_max_phys_segments(, LIBATA_MAX_PRD), when the value passed
>> should not be so limited on nice hardware like AHCI.

And, AFAICS, we can increase max_phys_segments all we want. This limits 
the number of segments before IOMMU mapping. The only part that's 
affected is the driver (software) and I don't see any limitation in 
libata PIO implementation that puts limitation on the number of sg 
entries. Simply changing LIBATA_MAX_PRD to 65535 should do it.

>>
>> 3) sata_mv: add back SCR_ERR clear?
>>         mv_scr_write(ap, SCR_ERROR, mv_scr_read(ap, SCR_ERROR));
>>
>> 4) sata_mv: set DMA mask
>>

-- 
tejun
