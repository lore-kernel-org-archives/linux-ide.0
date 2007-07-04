From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata_acpi: A different strategy for using ACPI information
Date: Wed, 04 Jul 2007 12:49:19 +0900
Message-ID: <468B18BF.6040207@gmail.com>
References: <20070703155417.11d81c75@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.178]:10271 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755302AbXGDDtZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 3 Jul 2007 23:49:25 -0400
Received: by py-out-1112.google.com with SMTP id u77so3619585pyb
        for <linux-ide@vger.kernel.org>; Tue, 03 Jul 2007 20:49:24 -0700 (PDT)
In-Reply-To: <20070703155417.11d81c75@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jeff@garzik.org

Alan Cox wrote:
> Lots of BIOSen simply return the BIOS set modes via the ACPI methods and
> pass back the values you give it across suspend/resume. Thus instead of
> trying to do clever stuff with this data we instead use it as a way to
> take a sneak peak at cable type information when viable. This should help
> us catch more of the laptops that do weird stuff, the VIA SATA bridges
> and the totally horked Nvidia cable handling.
> 
> For now its only used by the VIA and AMD/NV driver until we get a better
> idea of whether this is a sensible idea or not.
> 
> Opinions ?

If you don't do _STM first, it basically boils down to reading BIOS
setting during boot.  Over suspend/resume cycle, the values are
preserved by libata-acpi.  At this point, I think honoring the BIOS
setting is the right thing to do.  It just took us too long and I'm not
too sure about using ACPI for this.  It's generic so it's certainly
better in some aspect.  It's just a bit obfuscating, IMHO.

-- 
tejun
