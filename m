From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH libata-dev#upstream-fixes] libata: force PIO on IOMEGA
 ZIP 250 ATAPI
Date: Mon, 11 Jun 2007 14:07:38 +0900
Message-ID: <466CD89A.8040003@gmail.com>
References: <20070610055236.GI29122@htj.dyndns.org> <466CD6D2.403@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:6627 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbXFKFHo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Jun 2007 01:07:44 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1961454wah
        for <linux-ide@vger.kernel.org>; Sun, 10 Jun 2007 22:07:44 -0700 (PDT)
In-Reply-To: <466CD6D2.403@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, calvin.walton@gmail.com, alan@lxorguk.ukuu.org.uk

Jeff Garzik wrote:
> Tejun Heo wrote:
>> @@ -3769,6 +3769,7 @@ static const struct ata_blacklist_entry
>> ata_device_blacklist [] = {
>>      { "_NEC DV5800A",     NULL,        ATA_HORKAGE_NODMA },
>>      { "SAMSUNG CD-ROM SN-124","N001",    ATA_HORKAGE_NODMA },
>>      { "Seagate STT20000A", NULL,        ATA_HORKAGE_NODMA },
>> +    { "IOMEGA  ZIP 250       ATAPI", NULL,    ATA_HORKAGE_NODMA }, /*
>> temporary fix */
> 
> applied, after adding the "temporary fix" comment based on Alan's comments

Thanks.

-- 
tejun
