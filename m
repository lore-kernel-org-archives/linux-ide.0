From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 3/3] pata_amd: fix and improve cable detection
Date: Sat, 03 Nov 2007 09:35:03 +0900
Message-ID: <472BC237.8040008@gmail.com>
References: <472B402A.4030009@gmail.com>	<472B4078.90009@gmail.com>	<472B40B0.6010702@gmail.com>	<20071102154406.7596b384@the-village.bc.nu>	<472BA318.7010406@gmail.com> <20071103001018.5a71bfd3@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:1577 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755625AbXKCAfL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2007 20:35:11 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1120441wah
        for <linux-ide@vger.kernel.org>; Fri, 02 Nov 2007 17:35:10 -0700 (PDT)
In-Reply-To: <20071103001018.5a71bfd3@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Alan Cox wrote:
>> all we can use is how the BIOS configured it.  I suppose BIOS does it by
>> issuing trial commands which I don't think adding to libata is a good idea.
> 
> The BIOS does it by asking the hardware somehow. I traced one or two
> BIOSes that far. The info is there but its not documented in the
> slightest so only ACPI makes it visible via the BIOS.

OIC, gawdddddddd... What was so long with just following what those
AMD chips did?

>> Can you please lemme know what you don't like about the current
>> implementation or what other approach you have in mind?  I don't like
>> Nvidia PATA either but there are a lot of people using it out there.
> 
> We seem to be able to trust the drives and BIOS ACPI data for Nvidia (at
> least what I have seen), so I guess we should simply declare the cable
> type unknown, 80 wire if ACPI says it is and then do the drive detect
> side ?

There are machines with broken BIOSen so actually the most reliable
source is the UDMA timing register.  On ASUS A8N-E, ACPI and UDMA
timing register always concur.  I think it's best to look at both not
so much for accuracy but for debugging, so the following printk in the
patch.

+	if (ap->pflags & ATA_PFLAG_INIT_GTM_VALID)
+		snprintf(acpi_str, sizeof(acpi_str), " (%u:%u:0x%x)",
+			 ap->acpi_init_gtm.drive[0].dma,
+			 ap->acpi_init_gtm.drive[1].dma,
+			 ap->acpi_init_gtm.flags);
+
+	ata_port_printk(ap, KERN_DEBUG, "nv_cable_detect: native=%d (0x%x) "
+			"BIOS=%d (0x%x) ACPI=%d%s verdict=%d\n",
+			native_cbl, ata66, bios_cbl, saved_udma, acpi_cbl,
+			acpi_str, verdict);

When cable detection goes wrong, we'll at least know what all those
different sources are telling.

Thanks.

-- 
tejun
