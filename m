From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/3] libata: implement dev->acpi_init_gtm
Date: Sat, 03 Nov 2007 07:12:38 +0900
Message-ID: <472BA0D6.3050607@gmail.com>
References: <472B402A.4030009@gmail.com> <472B43E6.2020402@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:59103 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753680AbXKBWMq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2007 18:12:46 -0400
Received: by rv-out-0910.google.com with SMTP id k20so908632rvb
        for <linux-ide@vger.kernel.org>; Fri, 02 Nov 2007 15:12:45 -0700 (PDT)
In-Reply-To: <472B43E6.2020402@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Add dev->acpi_init_gtm and store initial GTM values on host
>> initialization.  If the field is valid, ATA_PFLAG_INIT_GTM_VALID flag
>> is set.  This is to remember BIOS/firmware programmed initial timing
>> for later use before reset and mode configuration modify it.
>>
>> Signed-off-by: Tejun Heo <htejun@gmail.com>
> 
> It sounds like pata_via and pata_amd need a foo_save_initial_config()
> much like AHCI, during which they would fill ppriv->init_gtm rather than
> ap->init_gtm.  Thoughts?  Both drivers are calling ata_acpi_cbl()
> themselves, permitting the possibility of ppriv->init_gtm.
> 
> This avoids forcing everyone else to bear the memory cost in ata_port
> for just these two drivers.

The memory overhead is pretty small and more importantly there isn't a
good place to load initial GTM.  ACPI is associated with the host during
host registration after all private host initialization is complete.
When the EH gets invoked, the first thing which is done is forcing PIO0
before initial reset.

Unless we add another hook, the only place to put this is in private
->error_handler().  A driver can check whether it's being called for the
first time and record it in private structure, which isn't too pretty,
so I thought doing it this way was fair tradeoff.

Thanks.

-- 
tejun
