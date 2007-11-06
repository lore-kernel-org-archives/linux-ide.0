From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 06/12] libata: separate out ata_acpi_gtm_xfermask() from
 pacpi_discover_modes()
Date: Tue, 06 Nov 2007 20:00:50 +0900
Message-ID: <47304962.1040006@gmail.com>
References: <1194327550227-git-send-email-htejun@gmail.com>	<11943275511318-git-send-email-htejun@gmail.com> <20071106105401.581eb83a@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.232]:46226 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754560AbXKFLBC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Nov 2007 06:01:02 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1313201nze
        for <linux-ide@vger.kernel.org>; Tue, 06 Nov 2007 03:00:58 -0800 (PST)
In-Reply-To: <20071106105401.581eb83a@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org

Alan Cox wrote:
>> +/* Welcome to ACPI, bring a bucket */
>> +const unsigned int ata_acpi_pio_cycle[7] = {
>> +	600, 383, 240, 180, 120, 100, 80
>> +};
>> +EXPORT_SYMBOL_GPL(ata_acpi_pio_cycle);
>> +
>> +const unsigned int ata_acpi_mwdma_cycle[5] = {
>> +	480, 150, 120, 100, 80
>> +};
>> +EXPORT_SYMBOL_GPL(ata_acpi_mwdma_cycle);
>> +
>> +const unsigned int ata_acpi_udma_cycle[7] = {
>> +	120, 80, 60, 45, 30, 20, 15
>> +};
>> +EXPORT_SYMBOL_GPL(ata_acpi_udma_cycle);
> 
> Do we really need to keep exporting all these things. So far this patch
> set has exported a set of very specific ACPI arrays and a load of
> internal functions. That to me says the splitting up is wrong.
> 
> One option would be to make those tables private and simply make the
> pata_acpi driver use the ata_timing functions

This is mid-step of merging ACPI timing handling into the standard
ata_timing mechanism.  These will go away in later patch.

-- 
tejun
