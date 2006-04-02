From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 12/15] libata: use SATA speeding down in ata_drive_probe_reset()
Date: Sun, 02 Apr 2006 10:05:48 +0900
Message-ID: <442F236C.9030908@gmail.com>
References: <11438230992911-git-send-email-htejun@gmail.com> <442EDAD9.9040308@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.192]:10347 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932360AbWDBBF4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 1 Apr 2006 20:05:56 -0500
Received: by zproxy.gmail.com with SMTP id o37so1361564nzf
        for <linux-ide@vger.kernel.org>; Sat, 01 Apr 2006 17:05:55 -0800 (PST)
In-Reply-To: <442EDAD9.9040308@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org, "Eric D. Mudama" <edmudama@gmail.com>

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Make ata_drive_probe_reset() use SATA SPD configuration.  Hardreset
>> will be force if speed renegotiation is necessary.  Also, if a
>> hardreset fails, PHY speed is stepped down and hardreset is retried
>> until the lowest speed is reached.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> Tentative ACK:  I wonder if a naked COMRESET is the best procedure for 
> changing PHY speeds.  We might even power down the phy, change speeds, 
> and then power it up again.  Need to reach my SATA docs, and maybe talk 
> to some device/controller vendors.
> 

AFAICS, SATA doc doesn't say anything about how to change PHY speed. 
FYI, ICH7 AHCI works fine with the current implementation.

I'm a bit skeptical about doing naked COMRESET from libata core layer. I 
think the right direction is to make SATA spd configuration the 
responsibility of hardreset operation.

-- 
tejun
