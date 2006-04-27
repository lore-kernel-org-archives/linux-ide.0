From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 07/13] libata-hp: implement ap->orig_sata_spd_limit
Date: Thu, 27 Apr 2006 19:18:05 +0900
Message-ID: <44509A5D.8030606@gmail.com>
References: <114476438172-git-send-email-htejun@gmail.com> <44508CB8.7030903@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.203]:1903 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965078AbWD0KRq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 Apr 2006 06:17:46 -0400
Received: by nz-out-0102.google.com with SMTP id n1so1901079nzf
        for <linux-ide@vger.kernel.org>; Thu, 27 Apr 2006 03:17:45 -0700 (PDT)
In-Reply-To: <44508CB8.7030903@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, lkosewsk@gmail.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Add ap->orig_sata_spd_limit and initialize it once during the boot
>> initialization (or driver load initialization).  ap->sata_spd_limit is
>> reset to ap->orig_sata_spd_limit on hotplug.  This prevents limits
>> introduced by earlier devices from affecting new devices.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> Rather than "orig_" call it "hw_" or similar.  This is similar to the 
> block layer's max_sectors and max_hw_sectors situation.
> 

Sure.  I'll choose one of hw_sata_spd_limit or phy_sata_spd_limit.

-- 
tejun
