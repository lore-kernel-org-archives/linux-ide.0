From: Aaron Lu <aaron.lwe@gmail.com>
Subject: Re: [PATCH v2] ahci: implement aggressive SATA device sleep support
Date: Fri, 24 Aug 2012 08:49:19 +0800
Message-ID: <5036CF8F.6050500@gmail.com>
References: <1345761072-2123-1-git-send-email-shane.huang@amd.com> <503647B3.6050706@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:59660 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006Ab2HXAto (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Aug 2012 20:49:44 -0400
Received: by pbbrr13 with SMTP id rr13so2443571pbb.19
        for <linux-ide@vger.kernel.org>; Thu, 23 Aug 2012 17:49:44 -0700 (PDT)
In-Reply-To: <503647B3.6050706@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, Shane Huang <shane.huang@amd.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-ide@vger.kernel.org

On 08/23/2012 11:09 PM, Jeff Garzik wrote:
> On 08/23/2012 06:31 PM, Shane Huang wrote:
>> This patch enables Aggressive Device Sleep only if both host controller
>> and device support it.
> [...]
> 
>> @@ -2323,6 +2324,26 @@ int ata_dev_configure(struct ata_device *dev)
>>   			}
>>   		}
>>
>> +		if (ata_id_has_devslp(dev->id)) {
>> +			err_mask = ata_dev_set_feature(dev,
>> +						       SETFEATURES_SATA_ENABLE,
>> +						       SATA_DEVSLP);
>> +			if (err_mask)
>> +				ata_dev_err(dev,
>> +					    "failed to enable DEVSLP (err_mask=0x%x)\n",
>> +					    err_mask);
>> +			else {
>> +				dev->flags |= ATA_DFLAG_DEVSLP;
>> +				err_mask = ata_read_log_page(dev,
>> +						ATA_LOG_SATA_SETTINGS,
>> +						dev->sata_settings,
>> +						1);
>> +				if (err_mask)
>> +					ata_dev_warn(dev,
>> +						     "failed to get Identify Device Data\n");
>> +			}
>> +		}
>> +
>>   		dev->cdb_len = 16;
>>   	}
>>
> 
> 1) Contra the patch description (quoted above), you are enabling 
> SATA_DEVSLP on the device regardless of power policy or host controller 
> support.
> 
> I'm not sure about the ata_dev_configure() change.  If the power policy 
> is not enabling aggressive sleep, we should not send this command to the 
> device.

My understanding is that the devslp link power state will only be
entered when the host asserts the devslp signal(an out of band signal),
this may be done autonomously by the host or manually programmed by
software, while this patch cares about the former one.

The prerequisite for this would be the device's devslp feature being
already enabled, but enabling this feature for the device doesn't mean
the device wants to initiate a link power state transition.

So I think we can simply enable this feature while configuring this
device and the enter/exit of devslp is taken care of by ahci_set_lpm,
does this make sense?

Please correct me if I'm wrong, thanks.

-Aaron
