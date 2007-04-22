From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 07/13] libata-acpi: add ATA_FLAG_ACPI_SATA port flag
Date: Mon, 23 Apr 2007 03:09:17 +0900
Message-ID: <462BA4CD.6050502@gmail.com>
References: <11772636651400-git-send-email-htejun@gmail.com>	<11772636662936-git-send-email-htejun@gmail.com>	<20070422185351.12adf7d8@the-village.bc.nu> <20070422190357.0fcae68b@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.225]:49704 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754299AbXDVSJX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Apr 2007 14:09:23 -0400
Received: by nz-out-0506.google.com with SMTP id s1so1109834nze
        for <linux-ide@vger.kernel.org>; Sun, 22 Apr 2007 11:09:23 -0700 (PDT)
In-Reply-To: <20070422190357.0fcae68b@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, mjg59@srcf.ucam.org, rdunlap@xenotime.net, trenn@suse.de, forrest.zhao@gmail.com, kristen.c.accardi@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org

Alan Cox wrote:
>> The ACPI interface to use can only be safely determined one way - and
>> that is to see what methods the BIOS has attached to the device and use
>> those.
>>
>> Take the ACPI handle, go look for _GTF, _SDD etc and believe the
>> firmware. Nothing else works.
> 
> Actually its even worse a mess than I thought 8(
> 
> We have to look at the BIOS method offered and we have to know if we
> changed the mode of the controller.
> 
> If the BIOS mode of an IDE controller is SFF and we flip it into AHCI
> mode then we can no longer use the BIOS provided methods because they are
> the wrong ones.
> 
> For the sane cases (where we don't frob the device) we can ask the BIOS
> what methods it has to guess what to use. If we change the mode of the
> controller we need to look for methods that match our change, and be
> aware we may have totally hosed the ACPI method support by changing the
> chip config.
> 
> Bletch, ACPI, its like openprom crossed with european law, a million
> times larger than needed, and full of holes.

Here are what I've seen till now.

* Many older boards only supply IDE style ACPI nodes and don't bother to
switch them off when the controller is put into ahci mode (whether it's
done by the BIOS itself or by the OS).

* Newer ones have both in their SSDTs.  Probably selects one or the
other according to BIOS setting.  I haven't seen them in action and not
too familiar with asl so dunno.

* Laptops which make heavy use of ATA ACPI features usually locks the
controller into single programming mode and supply the matching ACPI
hierarchy.

So, I think we'll be okay if we follow the spec here.

-- 
tejun
