Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C493C433F5
	for <linux-ide@archiver.kernel.org>; Fri, 25 Mar 2022 07:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358503AbiCYHMF (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 25 Mar 2022 03:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244931AbiCYHME (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 25 Mar 2022 03:12:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EDEBD7FA
        for <linux-ide@vger.kernel.org>; Fri, 25 Mar 2022 00:10:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7371F210DE;
        Fri, 25 Mar 2022 07:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648192227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/HuyzDRXzthiHJq8X6NHBxIxcqk5Oq6TqtmVw2NYFSU=;
        b=LIhzgQY68n4bdiewHM3aOot8nekKgnv3cZkSWJT8EebrDwrU9Urg5dHyljh1r4mgYFedCi
        R9IEOEYS73zmIYwp8cI1GWBZpZR1WXXoNGgQQhR4nfz0wrP/Fvnsy6d2rmbutME864u5RV
        lu8Ru5tj8i8yaWqFmL5BtKTv0DwV5aM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648192227;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/HuyzDRXzthiHJq8X6NHBxIxcqk5Oq6TqtmVw2NYFSU=;
        b=gye7RTzm3M2/bWV7mhU7gLeKjw5/LmwFmA864sLnev/vla/fiEw53EoyhKn6IZnX+pPjXn
        6QTeWonxuPTfXbDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 55A3B132E9;
        Fri, 25 Mar 2022 07:10:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oiLUE+NqPWKJTAAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 25 Mar 2022 07:10:27 +0000
Message-ID: <74bc701e-8ac1-a572-0b38-a60c0fe163b7@suse.de>
Date:   Fri, 25 Mar 2022 08:10:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/2] libata: rework sysfs naming
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org
References: <20220324123204.61534-1-hare@suse.de>
 <20220324123204.61534-2-hare@suse.de>
 <62a7433e-d9f4-a95b-818c-0f1d31160ac8@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <62a7433e-d9f4-a95b-818c-0f1d31160ac8@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/25/22 04:05, Damien Le Moal wrote:
> On 3/24/22 21:32, Hannes Reinecke wrote:
>> This patch adds a new dummy bus 'ata', which collects all ata device
>> objects like ata_port, ata_link, and ata_dev, and adds an 'ata' prefix
>> to the message log.
>> To be consistent with the other libata objects the 'ata_port' object name
>> has been changed from 'ata' to 'port'.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/ata/libata-transport.c | 21 +++++++++++--
>>   include/linux/libata.h         | 54 ++++++++++------------------------
>>   2 files changed, 34 insertions(+), 41 deletions(-)
>>
>> diff --git a/drivers/ata/libata-transport.c 
>> b/drivers/ata/libata-transport.c
>> index ca129854a88c..555fe6e2293d 100644
>> --- a/drivers/ata/libata-transport.c
>> +++ b/drivers/ata/libata-transport.c
>> @@ -81,10 +81,13 @@ struct ata_internal {
>>       tdev_to_port((dev)->parent)
>> -/* Device objects are always created whit link objects */
>> +/* Device objects are always created with link objects */
>>   static int ata_tdev_add(struct ata_device *dev);
>>   static void ata_tdev_delete(struct ata_device *dev);
>> +struct bus_type ata_bus_type = {
>> +        .name        = "ata",
>> +};
>>   /*
>>    * Hack to allow attributes of the same name in different objects.
>> @@ -288,7 +291,9 @@ int ata_tport_add(struct device *parent,
>>       dev->parent = parent;
>>       ata_host_get(ap->host);
>>       dev->release = ata_tport_release;
>> -    dev_set_name(dev, "ata%d", ap->print_id);
>> +    dev->bus = &ata_bus_type;
>> +    dev_set_name(dev, "port%d", ap->print_id);
>> +
>>       transport_setup_device(dev);
>>       ata_acpi_bind_port(ap);
>>       error = device_add(dev);
>> @@ -444,6 +449,8 @@ int ata_tlink_add(struct ata_link *link)
>>       device_initialize(dev);
>>       dev->parent = &ap->tdev;
>>       dev->release = ata_tlink_release;
>> +    dev->bus = &ata_bus_type;
>> +
>>       if (ata_is_host_link(link))
>>           dev_set_name(dev, "link%d", ap->print_id);
>>       else
>> @@ -695,8 +702,10 @@ static int ata_tdev_add(struct ata_device *ata_dev)
>>       device_initialize(dev);
>>       dev->parent = &link->tdev;
>>       dev->release = ata_tdev_release;
>> +    dev->bus = &ata_bus_type;
>> +
>>       if (ata_is_host_link(link))
>> -        dev_set_name(dev, "dev%d.%d", ap->print_id,ata_dev->devno);
>> +        dev_set_name(dev, "dev%d.%d", ap->print_id, ata_dev->devno);
>>       else
>>           dev_set_name(dev, "dev%d.%d.0", ap->print_id, link->pmp);
>> @@ -822,8 +831,13 @@ __init int libata_transport_init(void)
>>       error = transport_class_register(&ata_dev_class);
>>       if (error)
>>           goto out_unregister_port;
>> +    error = bus_register(&ata_bus_type);
>> +    if (error)
>> +        goto out_unregister_bus;
> 
> Why is it needed to call bus_unregister() if bus_register() fails ? 
> Shouldn't this be a "goto out_unregister_dev" which does a 
> "transport_class_unregister(&ata_dev_class)" ?
> 
Ah yes. You are right.

>>       return 0;
>> + out_unregister_bus:
>> +    bus_unregister(&ata_bus_type);
>>    out_unregister_port:
>>       transport_class_unregister(&ata_port_class);
>>    out_unregister_link:
>> @@ -835,6 +849,7 @@ __init int libata_transport_init(void)
>>   void __exit libata_transport_exit(void)
>>   {
>> +    bus_unregister(&ata_bus_type);
>>       transport_class_unregister(&ata_link_class);
>>       transport_class_unregister(&ata_port_class);
>>       transport_class_unregister(&ata_dev_class);
>> diff --git a/include/linux/libata.h b/include/linux/libata.h
>> index 0619ae462ecd..b17683b00c90 100644
>> --- a/include/linux/libata.h
>> +++ b/include/linux/libata.h
>> @@ -835,6 +835,7 @@ struct ata_port {
>>       struct ata_host        *host;
>>       struct device         *dev;
>>       struct device        tdev;
>> +    struct device        cdev;
> 
> This one is not used...
> 

Yeah, left-over from previous iteration.
I'll be resending.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
