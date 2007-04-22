From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 07/13] libata-acpi: add ATA_FLAG_ACPI_SATA port flag
Date: Mon, 23 Apr 2007 03:03:08 +0900
Message-ID: <462BA35C.5040702@gmail.com>
References: <11772636651400-git-send-email-htejun@gmail.com>	<11772636662936-git-send-email-htejun@gmail.com> <20070422185351.12adf7d8@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.234]:31993 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754255AbXDVSDQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Apr 2007 14:03:16 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1335525wra
        for <linux-ide@vger.kernel.org>; Sun, 22 Apr 2007 11:03:15 -0700 (PDT)
In-Reply-To: <20070422185351.12adf7d8@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jeff@garzik.org, mjg59@srcf.ucam.org, rdunlap@xenotime.net, trenn@suse.de, forrest.zhao@gmail.com, kristen.c.accardi@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-ide@vger.kernel.org

Alan Cox wrote:
> On Mon, 23 Apr 2007 02:41:06 +0900
> Tejun Heo <htejun@gmail.com> wrote:
> 
>> Whether a controller needs IDE or SATA ACPI hierarchy is determined by
>> the programming interface of the controller not by whether the
>> controller is SATA or PATA
> 
> NAK
> 
> I keep trying to point out that this is not true.
> 
> The ACPI interface to use can only be safely determined one way - and
> that is to see what methods the BIOS has attached to the device and use
> those.
> 
> Take the ACPI handle, go look for _GTF, _SDD etc and believe the
> firmware. Nothing else works.

Actually, that's dangerous.  For example, you must not do _STM/_GTM on
ahci becuase _STM/_GTM access PCI config registers which must not be
accessed in achi modes and some BIOSen supply the same _STM/_GTM nodes
whether the controller is in ata_piix mode or ahci mode.  Also, on ICH8,
the association gets quite weird due to PCI device splitting.

The ACPI spec says the layout is dependent on controller interface and I
 can see reasons why we need to follow that but not the other way
around.  Do you have counter-examples?

-- 
tejun
