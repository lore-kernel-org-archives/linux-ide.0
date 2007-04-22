From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] pata_amd: remove contamination added during cable_detect
 conversion
Date: Mon, 23 Apr 2007 03:14:31 +0900
Message-ID: <462BA607.5010603@gmail.com>
References: <20070422170438.GK10619@htj.dyndns.org>	<20070422184037.537ae748@the-village.bc.nu>	<462BA0A5.2080900@gmail.com> <20070422185917.5fe14e97@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.234]:51001 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754311AbXDVSOh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Apr 2007 14:14:37 -0400
Received: by nz-out-0506.google.com with SMTP id s1so1110320nze
        for <linux-ide@vger.kernel.org>; Sun, 22 Apr 2007 11:14:37 -0700 (PDT)
In-Reply-To: <20070422185917.5fe14e97@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

Alan Cox wrote:
>> I have patches to update pata_amd to use _STM/_GTM for cable detection
>> (a lot are taken from pata_acpi) but ACPI cable detection is just as
>> broken as PCI config one.
> 
> I'm unclear we can safely mix _STM/_GTM and direct access to the drive in
> a general form. The ACPI documentation seems to be carefully very silent
> on the subject.
> 
> Whatever works in this area is good.

Yeap, definitely.  Can you please retest pata_acpi with ata_acpi_gtm()
fixed?  I have an UDMA2 ODD (HL-DT-ST DVDRAM GSA-H10N) and UDMA4 HDD
(WDC WD153AA) attached to 40c cable and ACPI mode discovery doesn't work
at all.  The only thing I can get working here is storing the BIOS
setting.  :-(

-- 
tejun
