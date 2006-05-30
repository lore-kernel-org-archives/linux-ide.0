From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 02/13] libata-hp: implement hotplug
Date: Tue, 30 May 2006 13:44:21 +0900
Message-ID: <447BCDA5.2040607@gmail.com>
References: <1148884735930-git-send-email-htejun@gmail.com> <447BC7A6.2070500@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.224]:54500 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932135AbWE3Eo2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 May 2006 00:44:28 -0400
Received: by wr-out-0506.google.com with SMTP id i7so1023551wra
        for <linux-ide@vger.kernel.org>; Mon, 29 May 2006 21:44:27 -0700 (PDT)
In-Reply-To: <447BC7A6.2070500@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: mlord@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, axboe@suse.de, forrest.zhao@intel.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
> \> +        } else if (dev->class == ATA_DEV_UNKNOWN &&
>> +               ehc->tries[dev->devno] &&
>> +               ata_class_enabled(ehc->classes[dev->devno])) {
>> +            dev->class = ehc->classes[dev->devno];
>> +
>> +            rc = ata_dev_read_id(dev, &dev->class, 1, dev->id);
>> +            if (rc == 0)
>> +                rc = ata_dev_configure(dev, 1);
>> +
>> +            if (rc) {
>> +                dev->class = ATA_DEV_UNKNOWN;
>> +                break;
>> +            }
> 
> ACK, with a comment:  It seems like this small snippet of logic appears 
> in more than one place, and could be made common
> 

If you're referring to ata_bus_probe(), it will be removed as soon as 
all drivers are converted to new EH with a lot of other codes, so I 
don't think factoring above part is necessary.

-- 
tejun
