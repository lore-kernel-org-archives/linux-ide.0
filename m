From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/1] libata: rearrange dmesg info to add full ATA revision
Date: Wed, 31 Jan 2007 13:54:15 +0900
Message-ID: <45C020F7.7000305@gmail.com>
References: <20070131021051.GA3403@bounceswoosh.org> <45C013B8.8030600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.238]:14275 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143AbXAaEy0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Jan 2007 23:54:26 -0500
Received: by wx-out-0506.google.com with SMTP id h31so90634wxd
        for <linux-ide@vger.kernel.org>; Tue, 30 Jan 2007 20:54:26 -0800 (PST)
In-Reply-To: <45C013B8.8030600@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Eric D. Mudama" <edmudama@gmail.com>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

[The previous replay mysteriously didn't include Eric in To:, sorry,
quoting whole message here.]

Tejun Heo wrote:
> Hello, Eric.
> 
> Eric D. Mudama wrote:
>> Per Jeff's suggestion, this patch rearranges the info printed for ATA
>> drives into dmesg to add the full ATA firmware revision and model
>> information, while keeping the output to 2 lines.
>>
>> Signed-off-by: Eric D. Mudama <edmudama@gmail.com>
> 
> The patch is formatted and applies perfectly.  I'm glad to see this
> change.  Just a few nits below.
> 
>>  	char revbuf[7];		/* XYZ-99\0 */
>> +	char fwrevbuf[9];
>> +	char modelbuf[41];
> 
> Please use ATA_ID_FW_REV_LEN + 1 and ATA_ID_PROD_LEN + 1.

This depends on to which version this patch applies.  For
#upstream-fixes (2.6.20-rc6), you have to use raw numbers as you did.
For #upstream, there are above two constants to use.  I think this patch
is good for 2.6.20 as it's safe && will help us analyzing bug reports
for 2.6.20.  So, ignore this part of the comment.

Jeff, if it gets merged into #upstream through #upstream-fixes, please
don't forget to change above constants.

>> @@ -1680,13 +1692,18 @@ int ata_dev_configure(struct ata_device *dev)
>>  			ata_dev_config_ncq(dev, ncq_desc, sizeof(ncq_desc));
>>  
>>  			/* print device info to dmesg */
>> -			if (ata_msg_drv(ap) && print_info)
>> -				ata_dev_printk(dev, KERN_INFO, "%s, "
>> -					"max %s, %Lu sectors: %s %s\n",
>> +			if (ata_msg_drv(ap) && print_info) {
>> +				ata_dev_printk(dev, KERN_INFO,
>> +					"%s: %s, %s, max %s\n",
>>  					revbuf,
>> -					ata_mode_string(xfer_mask),
>> +					modelbuf, fwrevbuf,
> 
> Please merge the above line with the line above it.
> 
>> +					ata_mode_string(xfer_mask));
>> +				ata_dev_printk(dev, KERN_INFO,
>> +					"%Lu sectors, multi %u: %s %s\n",
>>  					(unsigned long long)dev->n_sectors,
>> +					dev->multi_count,
>>  					lba_desc, ncq_desc);
> 
> Ditto.
> 
>> +			}
>>  		} else {
>>  			/* CHS */
>>  
>> @@ -1703,22 +1720,19 @@ int ata_dev_configure(struct ata_device *dev)
>>  			}
>>  
>>  			/* print device info to dmesg */
>> -			if (ata_msg_drv(ap) && print_info)
>> -				ata_dev_printk(dev, KERN_INFO, "%s, "
>> -					"max %s, %Lu sectors: CHS %u/%u/%u\n",
>> +			if (ata_msg_drv(ap) && print_info) {
>> +				ata_dev_printk(dev, KERN_INFO,
>> +					"%s: %s, %s, max %s\n",
>>  					revbuf,
>> -					ata_mode_string(xfer_mask),
>> +					modelbuf, fwrevbuf,
> 
> Ditto.
> 
>> +					ata_mode_string(xfer_mask));
>> +				ata_dev_printk(dev, KERN_INFO, 
>> +					"%Lu sectors, multi %u, CHS %u/%u/%u\n",
>>  					(unsigned long long)dev->n_sectors,
>> +					dev->multi_count,
>>  					dev->cylinders, dev->heads,
>>  					dev->sectors);
> 
> I would prefer
> 
> dev->multi_count, dev->cylinders,
> dev->heads, dev->sectors
> 
> Other than these,
> 
> Acked-by: Tejun Heo <htejun@gmail.com>
> 

-- 
tejun
