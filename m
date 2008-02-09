From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 4/9] libata: normalize port_info, port_operations and
 sht tables
Date: Sat, 09 Feb 2008 10:57:46 +0900
Message-ID: <47AD089A.8050302@gmail.com>
References: <12016853433196-git-send-email-htejun@gmail.com> <12016853433225-git-send-email-htejun@gmail.com> <47A38533.7020806@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:15694 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755704AbYBIB5y (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Feb 2008 20:57:54 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2708937rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 08 Feb 2008 17:57:53 -0800 (PST)
In-Reply-To: <47A38533.7020806@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, liml@rtr.ca, alan@lxorguk.ukuu.org.uk, kngregertsen@norway.atmel.com, sonic.adi@gmail.com, rmk@dyn-67.arm.linux.org.uk, alessandro.zummo@towertech.it, domen.puncer@telargo.com, akira2.iguchi@toshiba.co.jp, leoli@freescale.com

Jeff Garzik wrote:
> Tejun Heo wrote:
>> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>> index 07dcaf6..08301ca 100644
>> --- a/drivers/ata/ahci.c
>> +++ b/drivers/ata/ahci.c
>> @@ -351,6 +351,8 @@ static const struct ata_port_operations
>> ahci_vt8251_ops = {
>>      .port_suspend        = ahci_port_suspend,
>>      .port_resume        = ahci_port_resume,
>>  #endif
>> +    .enable_pm        = ahci_enable_alpm,
>> +    .disable_pm        = ahci_disable_alpm,
>>  
>>      .port_start        = ahci_port_start,
>>      .port_stop        = ahci_port_stop,
>> @@ -385,6 +387,8 @@ static const struct ata_port_operations
>> ahci_p5wdh_ops = {
>>      .port_suspend        = ahci_port_suspend,
>>      .port_resume        = ahci_port_resume,
>>  #endif
>> +    .enable_pm        = ahci_enable_alpm,
>> +    .disable_pm        = ahci_disable_alpm,
>>  
>>      .port_start        = ahci_port_start,
>>      .port_stop        = ahci_port_stop,
> 
> The last one is probably OK, but I didn't think vt8521 could do this?

I don't know.  Those should be determined by CAP bits and if vt8251 lies
about it, it should be blacklisted by clearing CAP bit as other features.

-- 
tejun
