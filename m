From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] pata_amd: remove contamination added during cable_detect
 conversion
Date: Mon, 23 Apr 2007 02:51:33 +0900
Message-ID: <462BA0A5.2080900@gmail.com>
References: <20070422170438.GK10619@htj.dyndns.org> <20070422184037.537ae748@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.230]:28661 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753296AbXDVRvj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Apr 2007 13:51:39 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1333794wra
        for <linux-ide@vger.kernel.org>; Sun, 22 Apr 2007 10:51:38 -0700 (PDT)
In-Reply-To: <20070422184037.537ae748@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Hello,

Alan Cox wrote:
> On Mon, 23 Apr 2007 02:04:38 +0900
> Tejun Heo <htejun@gmail.com> wrote:
> 
>> This is added by added by cff63dfceb52c564fe1ba5394d50ab7d599a11b9
>>  - pata: cable methods.
> 
> The Cable method fix for the Nvidia hardware if ACPI drivers are present
> and usable is to use the ACPI driver, so its not a "contamination" its a
> fix for the fact the Nvidia code can't do cable detect any other way

But pata_amd modifications should be merged together with pata_acpi not
separately.

Anyways, I've been testing pata_acpi and it doesn't work on my nforce
ultra machine.  Whether the cable is 40c or not, _STM happily sets UDMA
mode above 2 resulting in a series of transfer errors.  EH kicks in
eventually and drops transfer speed.

Also, ata_acpi_gtm() implementation was broken in that it skipped one
level of indirection (acpi_object, please take a look at the last patch
of just posted patchset), so it was basically returning garbage values.

I have patches to update pata_amd to use _STM/_GTM for cable detection
(a lot are taken from pata_acpi) but ACPI cable detection is just as
broken as PCI config one.

Thanks.

-- 
tejun
