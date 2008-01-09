From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata and starting/stopping ATAPI floppy devices
Date: Wed, 09 Jan 2008 11:41:16 +0900
Message-ID: <4784344C.5060208@gmail.com>
References: <200801051647.58866.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:50940 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152AbYAIClW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Jan 2008 21:41:22 -0500
Received: by rv-out-0910.google.com with SMTP id k20so59301rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 08 Jan 2008 18:41:22 -0800 (PST)
In-Reply-To: <200801051647.58866.linux@rainbow-software.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>

Ondrej Zary wrote:
> Hello,
> I switched to libata drivers for my onboard PATA controller (PIIX4) recently. 
> Everything works fine except that kernel tries to start not only my hard 
> drive (sda) but also LS-120 floppy drive (sdb) which does not like it:
> 
> sd 0:0:0:0: [sda] Starting disk
> ata1.00: configured for UDMA/33
> sd 0:0:0:0: [sda] 58633344 512-byte hardware sectors (30020 MB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support 
> DPO or FUA
> sd 1:0:1:0: [sdb] Starting disk
> ata2.00: configured for UDMA/33
> ata2.01: configured for PIO2
> sd 1:0:1:0: [sdb] Result: hostbyte=0x00 driverbyte=0x08
> sd 1:0:1:0: [sdb] Sense Key : 0x2 [current]
> sd 1:0:1:0: [sdb] ASC=0x3a ASCQ=0x0
> 
> 
> The question is: is it correct? Or a patch like this should be applied?

Yeah, looks good to me.  Please reformat the message w/ S-O-B.

Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
