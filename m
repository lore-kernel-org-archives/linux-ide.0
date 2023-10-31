Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA69C4332F
	for <linux-ide@archiver.kernel.org>; Tue, 31 Oct 2023 05:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjJaFUf (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 31 Oct 2023 01:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjJaFUf (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 31 Oct 2023 01:20:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC95B7
        for <linux-ide@vger.kernel.org>; Mon, 30 Oct 2023 22:20:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 534A9C433C7;
        Tue, 31 Oct 2023 05:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698729631;
        bh=cVygx/+XylX0rYAs2Ba5MzS/yhq7TKwc4ar+gkEngjw=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=CAlsyv9EUoNBocLd1qjKJambyz3XiAY8snZCB/5XSbw5JKa37hANKiSiGVxkqa7ha
         Kzen+RbKOV0xfYULUsKXh8xOO0+FNs6y/QsKrPSQYCetNnxzMnX8g+VXRbhSGOh+C9
         dCiNEolKWI5tOwiFP3ceD/FVA2qMvtcYCJLOU0BNv4LBSCyKdPy9EcgZd95AOl+OzO
         eQcAzCQBREPtxIkOltVCaP0EPmn0HyxqgLYkMn4XnWVsVFQfeltIxwKX+miN5lifFd
         TJ92F3vM62Yk7YxgRZT5wP7Lx/pVLIIrFsPpbK5sPxizfE/iBwmrMdlDR0DwRnFSom
         df7GWesjue4kg==
Message-ID: <3a5495de-8ef9-4362-aa26-86a31c6aa315@kernel.org>
Date:   Tue, 31 Oct 2023 14:20:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pata_isapnp: Add check for devm_ioport_map
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Chen Ni <nichen@iscas.ac.cn>, s.shtylyov@omp.ru, jeff@garzik.org
Cc:     linux-ide@vger.kernel.org
References: <20231031040007.2498659-1-nichen@iscas.ac.cn>
 <4916b09e-ec4b-4106-bd1a-1b86827d8901@kernel.org>
Organization: Western Digital Research
In-Reply-To: <4916b09e-ec4b-4106-bd1a-1b86827d8901@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 10/31/23 14:13, Damien Le Moal wrote:
> On 10/31/23 13:00, Chen Ni wrote:
>> Add check for devm_ioport_map() and return the error if it fails in
>> order to guarantee the success of devm_ioport_map().
>>
>> Fixes: 0d5ff566779f ("libata: convert to iomap")
> 
> This is the wrong patch. That patch was using pcim_iomap_regions(), not
> devm_ioport_map().

Please ignore. I did not read that patch properly. This is fine.
The fixes tag is not really needed anyway.

> 
>> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
>> ---
>>  drivers/ata/pata_isapnp.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/ata/pata_isapnp.c b/drivers/ata/pata_isapnp.c
>> index 25a63d043c8e..0f77e0424066 100644
>> --- a/drivers/ata/pata_isapnp.c
>> +++ b/drivers/ata/pata_isapnp.c
>> @@ -82,6 +82,9 @@ static int isapnp_init_one(struct pnp_dev *idev, const struct pnp_device_id *dev
>>  	if (pnp_port_valid(idev, 1)) {
>>  		ctl_addr = devm_ioport_map(&idev->dev,
>>  					   pnp_port_start(idev, 1), 1);
>> +		if (!ctl_addr)
>> +			return -ENOMEM;
>> +
>>  		ap->ioaddr.altstatus_addr = ctl_addr;
>>  		ap->ioaddr.ctl_addr = ctl_addr;
>>  		ap->ops = &isapnp_port_ops;
> 

-- 
Damien Le Moal
Western Digital Research

