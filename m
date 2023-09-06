Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CAAEB8FA5
	for <linux-ide@archiver.kernel.org>; Wed,  6 Sep 2023 07:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjIFH7m (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 6 Sep 2023 03:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjIFH7l (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 6 Sep 2023 03:59:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DFBCF
        for <linux-ide@vger.kernel.org>; Wed,  6 Sep 2023 00:59:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C370C433C7;
        Wed,  6 Sep 2023 07:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693987177;
        bh=eApZ/gxYAVJvYlh0rCNB6vlYoBqPdp8tWa9s/pXwUas=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=P88KiSm4bFRtpenUhLe74a/es3hIZcQHlbYiTrNl/Qt8fArVu4Z1qR9JTjJ4QHXQ1
         kMj2sf5urmimUvuin8roPE6SA8gdai0m2mZk8wRmNkVVFaMHoZ+oKC1yEa2B/r0/BL
         fTwG1H87iPL62xesByj89b/Yg31IQlZrj5hfrvE5i2WChgxTHyhObjPAJPf6NEY3Zb
         JOghYPGOFkOzLyrSqk62ulCWWaDDCm3WXMMU0crNXlXNkD7XHLHdW/hQsYumxH44Qa
         h5OBgBnn8eS6eEUXF4UqyFZEE7l0wuc8zWjkzbTjOOAUOvXJgzx/SdKcFnl5JGuEpS
         GlPDAzHpQGnxQ==
Message-ID: <7a6a28c4-219e-e2aa-ea91-cb0622af62ac@kernel.org>
Date:   Wed, 6 Sep 2023 16:59:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ata: ahci: print the lpm policy on boot
Content-Language: en-US
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Niklas Cassel <nks@flawful.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <20230905124909.3334046-1-nks@flawful.org>
 <be820ba7-7aa8-6338-7bee-201443aae5c1@kernel.org>
 <ZPgwRm6X7JhR4Jlc@x1-carbon>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZPgwRm6X7JhR4Jlc@x1-carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 9/6/23 16:54, Niklas Cassel wrote:
> Hello Damien,
> 
> On Wed, Sep 06, 2023 at 03:48:02PM +0900, Damien Le Moal wrote:
>> On 9/5/23 21:49, Niklas Cassel wrote:
>>> From: Niklas Cassel <niklas.cassel@wdc.com>
>>>
>>> The target LPM policy can be set using either a Kconfig or a kernel module
>>> parameter.
>>>
>>> However, if the board type is set to anything but board_ahci_low_power,
>>> then the LPM policy will overridden and set to ATA_LPM_UNKNOWN.
>>>
>>> Additionally, if the default suspend is suspend to idle, depending on the
>>> hardware capabilities of the HBA, ahci_update_initial_lpm_policy() might
>>> override the LPM policy to either ATA_LPM_MIN_POWER_WITH_PARTIAL or
>>> ATA_LPM_MIN_POWER.
>>>
>>> All this means that it is very hard to know which LPM policy a user will
>>> actually be using on a given system.
>>>
>>> In order to make it easier to debug LPM related issues, print the LPM
>>> policy on boot.
>>>
>>> One common LPM related issue is that the device fails to link up.
>>> Because of that, we cannot add this print to ata_dev_configure(), as that
>>> function is only called after a successful link up. Instead, add the info
>>> using ata_port_desc(). The port description is printed once during boot.
>>>
>>> Before changes:
>>> ata1: SATA max UDMA/133 abar m524288@0xa5780000 port 0xa5780100 irq 170
>>> ata2: SATA max UDMA/133 abar m524288@0xa5780000 port 0xa5780180 irq 170
>>>
>>> After changes:
>>> ata1: SATA max UDMA/133 abar m524288@0xa5780000 port 0xa5780100 lpm-pol 4 irq 170
>>> ata2: SATA max UDMA/133 abar m524288@0xa5780000 port 0xa5780180 lpm-pol 4 irq 170
>>
>> Looks good, but maybe print the lpm-pol value at the end, after the IRQ number,
>> to preserve the beginning of the message as it was before.
>>
>> Or even better: why not print the LPM modes supported by the port and the target
>> lpm policy (lpm-pol) as a new ata_port_info() message right after the port desc
>> message ?
> 
> This print already exists:
> [    1.515960] ahci 10000:e0:17.0: AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
> [    1.515963] ahci 10000:e0:17.0: flags: 64bit ncq sntf pm clo only pio slum part deso sadm sds
> 
> Which prints the capabilities of the HBA.

Right.

> 
> The only LPM capability per port, that seems to be able to differ from the
> global HBA capability, is PxDEVSLP.DSP:
> 
> "
> Device Sleep Present (DSP): If set to ‘1’, the platform supports Device Sleep
> on this port. If cleared to ‘0’, the platform does not support Device Sleep on
> this port. This bit may only be set to ‘1’ if CAP2.SDS is set to ‘1’.
> "
> 
> E.g. on my machine, the HBA has support for DevSleep (supported features print
> includes "sds"), but none of the ports seem to have support for DevSleep.
> 
> Would you like PxDEVSLP.DSP printed?

We could.

> What would be interesting is to be able to know which features the connected
> device supports, as e.g. DevSleep needs support both in HBA and the device,
> but as the problem is that we usually don't get link up, this is information
> is still unknown at this time.

Yes. And if the link up is OK, devsleep capability is reported if supported by
the device.

OK. So let's just keep the lpm-pol message addition, but maybe move it at the
end of the message, after the IRQ info.

> 
> 
> Kind regards,
> Niklas
> 
>>
>>>
>>> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
>>> ---
>>>  drivers/ata/ahci.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>>> index abb5911c9d09..541f6ec7f395 100644
>>> --- a/drivers/ata/ahci.c
>>> +++ b/drivers/ata/ahci.c
>>> @@ -1898,6 +1898,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>>>  			ap->em_message_type = hpriv->em_msg_type;
>>>  
>>>  		ahci_update_initial_lpm_policy(ap, hpriv);
>>> +		ata_port_desc(ap, "lpm-pol %d", ap->target_lpm_policy);
>>>  
>>>  		/* disabled/not-implemented port */
>>>  		if (!(hpriv->port_map & (1 << i)))
>>
>> -- 
>> Damien Le Moal
>> Western Digital Research

-- 
Damien Le Moal
Western Digital Research

