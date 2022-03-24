Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716E5C433EF
	for <linux-ide@archiver.kernel.org>; Thu, 24 Mar 2022 09:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349345AbiCXJwk (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 24 Mar 2022 05:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239549AbiCXJwj (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 24 Mar 2022 05:52:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6546791565
        for <linux-ide@vger.kernel.org>; Thu, 24 Mar 2022 02:51:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D393B215FF;
        Thu, 24 Mar 2022 09:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648115466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ORW42TZXjCxSHI/6snwUWwCW4aiyyBmjXwrZeX8yJLs=;
        b=EuT0o2v6GcsoWz4U/OAD/aX9/aL98GRKz9hAYCrf/nP4W0/Q9k9I03Kz9eXER7Vy7nE4h3
        CZ/rNXqGT4JcjulXVLXFtaGmYaCWKCILufIojEYqkQ7hBnvswaXFCvn8x2Z+2q1nqeZVGg
        rP+mO5aVHvoB2OZ/5ume0pQYNBvOZzE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648115466;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ORW42TZXjCxSHI/6snwUWwCW4aiyyBmjXwrZeX8yJLs=;
        b=wRUw62y2A1QWMrvU7239xHEOTd5k6FNt8lj5jBMf/n+JRus06uz9CnBylJc7yu3xx+4t3U
        N+AKAEXR78cO+LAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A69B313AA8;
        Thu, 24 Mar 2022 09:50:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FGsAKPg+PGI+QQAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 24 Mar 2022 09:50:48 +0000
Message-ID: <d6d8eeb0-f787-a391-b33a-15f2a219abe9@suse.de>
Date:   Thu, 24 Mar 2022 10:50:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/3] libata: CONFIG_ATA_SYSFS_COMPAT
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Damien LeMoal <damien.lemoal@wdc.com>
Cc:     linux-ide@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>
References: <20220321145659.97150-1-hare@suse.de>
 <20220321145659.97150-3-hare@suse.de>
 <508ecc68-96e4-b587-2d9a-82d73d58871e@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <508ecc68-96e4-b587-2d9a-82d73d58871e@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 3/24/22 10:27, Damien Le Moal wrote:
> On 3/21/22 23:56, Hannes Reinecke wrote:
>> Add a config option 'ATA_SYSFS_COMPAT' to allow the user to select
>> whether the compability 'ata_port' object with the name of 'ata'
>> should be registered with sysfs.
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   drivers/ata/Kconfig            | 10 ++++++++++
>>   drivers/ata/libata-transport.c | 19 ++++++++++++++++---
>>   2 files changed, 26 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
>> index cb54631fd950..fe42a246d21d 100644
>> --- a/drivers/ata/Kconfig
>> +++ b/drivers/ata/Kconfig
>> @@ -51,6 +51,16 @@ config ATA_VERBOSE_ERROR
>>   
>>   	  If unsure, say Y.
>>   
>> +config ATA_SYSFS_COMPAT
>> +	bool "Keep original sysfs layout"
>> +	default y
>> +	help
>> +	  This option retains the original sysfs layout by adding an
>> +	  additional ata_port object with the name of 'ataX' in
>> +	  to the ATA objects like 'ata_port', 'ata_link', and 'ata_device'.
>> +
>> +	  If unsure, say Y.
>> +
>>   config ATA_FORCE
>>   	bool "\"libata.force=\" kernel parameter support" if EXPERT
>>   	default y
>> diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
>> index 5169a5db141d..efca41039d1e 100644
>> --- a/drivers/ata/libata-transport.c
>> +++ b/drivers/ata/libata-transport.c
>> @@ -261,15 +261,21 @@ static int ata_tport_match(struct attribute_container *cont,
>>   void ata_tport_delete(struct ata_port *ap)
>>   {
>>   	struct device *dev = &ap->tdev;
>> +#ifdef CONFIG_ATA_SYSFS_COMPAT
>>   	struct device *cdev = &ap->cdev;
>> +#endif
>>   
>>   	ata_tlink_delete(&ap->link);
>>   
>> +#ifdef CONFIG_ATA_SYSFS_COMPAT
>>   	device_del(cdev);
>> +#endif
>>   	transport_remove_device(dev);
>>   	device_del(dev);
>>   	transport_destroy_device(dev);
>> +#ifdef CONFIG_ATA_SYSFS_COMPAT
>>   	put_device(cdev);
>> +#endif
>>   	put_device(dev);
>>   }
>>   
>> @@ -288,7 +294,9 @@ int ata_tport_add(struct device *parent,
>>   {
>>   	int error;
>>   	struct device *dev = &ap->tdev;
>> +#ifdef CONFIG_ATA_SYSFS_COMPAT
>>   	struct device *cdev = &ap->cdev;
>> +#endif
>>   
>>   	device_initialize(dev);
>>   	dev->type = &ata_port_type;
>> @@ -299,23 +307,24 @@ int ata_tport_add(struct device *parent,
>>   	dev->bus = &ata_bus_type;
>>   	dev_set_name(dev, "port%d", ap->print_id);
>>   
>> +#ifdef CONFIG_ATA_SYSFS_COMPAT
>>   	device_initialize(cdev);
>>   	cdev->parent = get_device(dev);
>>   	cdev->class = &ata_port_class.class;
>>   	dev_set_name(cdev, "ata%d", ap->print_id);
>> -
>> +#endif
>>   	transport_setup_device(dev);
>>   	ata_acpi_bind_port(ap);
>>   	error = device_add(dev);
>>   	if (error) {
>>   		goto tport_err;
>>   	}
>> -
>> +#ifdef CONFIG_ATA_SYSFS_COMPAT
>>   	error = device_add(cdev);
>>   	if (error) {
>>   		goto cdev_err;
>>   	}
>> -
> 
> Instead of adding a device, can't we simply create a symlink ?
> E.g.:
> 
> 	sprintf(symlink_name, "ata%d", ap->print_id);
> 	sysfs_create_link(&parent->kobj, &dev->kobj, symlink_name);
> 
> ? This seems to work, but I have not checked all possible paths to see if
> a symlink or directory name expected to be "ataX" ends up being "portX",
> which could break userspace relying on the old name.
> 
Yeah; tried a similar thing which turned out not to be working.
Let me test your patch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
