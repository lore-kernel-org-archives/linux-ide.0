From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 1/3] ata: Allow having a port recovery callback
Date: Wed, 10 Jan 2018 09:53:10 -0800
Message-ID: <2e1642d9-825a-317e-8f35-884b8c341a64@gmail.com>
References: <1515539097-26742-1-git-send-email-f.fainelli@gmail.com>
 <1515539097-26742-2-git-send-email-f.fainelli@gmail.com>
 <20180110142505.GA3668920@devbig577.frc2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:43161 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751503AbeAJRxO (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 10 Jan 2018 12:53:14 -0500
In-Reply-To: <20180110142505.GA3668920@devbig577.frc2.facebook.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: bcm-kernel-feedback-list@broadcom.com, Kishon Vijay Abraham I <kishon@ti.com>, Heiko Stuebner <heiko@sntech.de>, Srinath Mannam <srinath.mannam@broadcom.com>, Krzysztof Kozlowski <krzk@kernel.org>, Vivek Gautam <vivek.gautam@codeaurora.org>, Dan Carpenter <dan.carpenter@oracle.com>, "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" <linux-ide@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On 01/10/2018 06:25 AM, Tejun Heo wrote:
> Hello,
> 
> On Tue, Jan 09, 2018 at 03:04:55PM -0800, Florian Fainelli wrote:
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index 3c09122bf038..921c2813af07 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -2045,6 +2045,8 @@ int ata_dev_read_id(struct ata_device *dev, unsigned int *p_class,
>>  	if (ata_msg_warn(ap))
>>  		ata_dev_warn(dev, "failed to IDENTIFY (%s, err_mask=0x%x)\n",
>>  			     reason, err_mask);
>> +	if (ap->host->ops->port_recovery)
>> +		ap->host->ops->port_recovery(ap);
>>  	return rc;
>>  }
> 
> This is a really weird spot to add a callback named port_recovery().
> Can't the affected driver simply implement its own
> ata_port_operations->read_id() operation which does the recovery if
> necessary?

I did not consider that, but this is actually a great idea, thanks for
the suggestion! I will respin with that being done.
-- 
Florian
