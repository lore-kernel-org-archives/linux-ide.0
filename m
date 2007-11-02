From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/3] libata: implement dev->acpi_init_gtm
Date: Sat, 03 Nov 2007 07:08:34 +0900
Message-ID: <472B9FE2.4050203@gmail.com>
References: <472B402A.4030009@gmail.com> <20071102154443.487bf550@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:53794 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082AbXKBWIn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2007 18:08:43 -0400
Received: by rv-out-0910.google.com with SMTP id k20so907922rvb
        for <linux-ide@vger.kernel.org>; Fri, 02 Nov 2007 15:08:43 -0700 (PDT)
In-Reply-To: <20071102154443.487bf550@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Alan Cox wrote:
> On Sat, 03 Nov 2007 00:20:10 +0900
> Tejun Heo <htejun@gmail.com> wrote:
> 
>> Add dev->acpi_init_gtm and store initial GTM values on host
>> initialization.  If the field is valid, ATA_PFLAG_INIT_GTM_VALID flag
>> is set.  This is to remember BIOS/firmware programmed initial timing
>> for later use before reset and mode configuration modify it.
> 
> Don't you need to clear this on a hotplug event ?

It just says the GTM value loaded on driver initialization is valid.
The rest is upto the user.

-- 
tejun
