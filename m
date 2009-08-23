From: Frans Pop <elendil@planet.nl>
Subject: Re: 2.6.31-rc6: ACPI handle has no context apparenty from libata during suspend to RAM
Date: Sun, 23 Aug 2009 14:07:37 +0200
Message-ID: <200908231407.38543.elendil@planet.nl>
References: <200908231424.07900.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from Cpsmtpm-eml107.kpnxchange.com ([195.121.3.11]:54120 "EHLO
	CPSMTPM-EML107.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933522AbZHWMHk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 23 Aug 2009 08:07:40 -0400
In-reply-To: <200908231424.07900.arvidjaar@mail.ru>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-ide@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Andrey Borzenkov wrote:
> sd 0:0:0:0: [sda] Synchronizing SCSI cache
> sd 0:0:0:0: [sda] Stopping disk
> ACPI handle has no context!
> sdhci-pci 0000:03:01.1: PME# disabled
> sdhci-pci 0000:03:01.1: PCI INT B disabled
> ACPI handle has no context!
> ata5: port disabled. ignoring.

I have a few of those too. I've been intending to try to investigate them, 
but haven't gotten around to it yet. One problem is that there is no 
context information in the error message itself (what 
driver/function/whatever).

Are they new for you in .31 or have they always been there? I suspect the 
latter, in which case I wouldn't worry about them too much. I at least 
have never noticed any actual negative impact from them.

Cheers,
FJP
