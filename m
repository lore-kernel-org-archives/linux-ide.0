From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 16/22] libata: implement new SCR handling and port on/offline
 functions
Date: Sun, 14 May 2006 08:18:51 +0900
Message-ID: <4466695B.4050204@gmail.com>
References: <1147348791300-git-send-email-htejun@gmail.com> <44665314.4040805@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.239]:21048 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964797AbWEMXS6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 13 May 2006 19:18:58 -0400
Received: by wr-out-0506.google.com with SMTP id i23so585447wra
        for <linux-ide@vger.kernel.org>; Sat, 13 May 2006 16:18:58 -0700 (PDT)
In-Reply-To: <44665314.4040805@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, axboe@suse.de, albertcc@tw.ibm.com, forrest.zhao@intel.com, efalk@google.com, linux-ide@vger.kernel.org

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Implement ata_scr_{valid|read|write|write_flush}() and
>> ata_port_{online|offline}().  These functions replace
>> scr_{read|write}() and sata_dev_present().
>>
>> Major difference between between the new SCR functions and the old
>> ones is that the new ones have a way to signal error to the caller.
>> This makes handling SCR-available and SCR-unavailable cases in the
>> same path easier.  Also, it eases later PM implementation where SCR
>> access can fail due to various reasons.
>>
>> ata_port_{online|offline}() functions return 1 only when they are
>> affirmitive of the condition.  e.g.  if SCR is unaccessible or
>> presence cannot be determined for other reasons, these functions
>> return 0.  So, ata_port_online() != !ata_port_offline().  This
>> distinction is useful in many exception handling cases.
> 
> If its SATA-specific, it should have a "sata_" not "ata_" prefix.
> 

I thought about it but the 'S' in SCR stands for Serial ATA and we also 
need to rename all PM functions to sata_pmp_xxx() - SCR and PMP are 
already SATA specific.  Do you think that's the way to go?

For ata_port_on/offline(), I think it's better to leave them alone for 
hotpluggable IDE hotbays with presence detection.

-- 
tejun
