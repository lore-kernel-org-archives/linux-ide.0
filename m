From: "Maciej Rutecki" <maciej.rutecki@gmail.com>
Subject: Re: Linux 2.6.24-rc4
Date: Tue, 4 Dec 2007 21:51:38 +0100
Message-ID: <8db1092f0712041251w71768544o6f922454e2bb6758@mail.gmail.com>
References: <alpine.LFD.0.9999.0712032055080.2981@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:65474 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbXLDUvk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Dec 2007 15:51:40 -0500
Received: by wa-out-1112.google.com with SMTP id v27so6451726wah
        for <linux-ide@vger.kernel.org>; Tue, 04 Dec 2007 12:51:39 -0800 (PST)
In-Reply-To: <alpine.LFD.0.9999.0712032055080.2981@woody.linux-foundation.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-ide@vger.kernel.org

ata1: SATA max UDMA/133 irq_stat 0x00400040, connection status changed irq 220
ata2: SATA max UDMA/133 abar m1024@0xe8585000 port 0xe8585180 irq 220
ata3: SATA max UDMA/133 abar m1024@0xe8585000 port 0xe8585200 irq 220
ata4: SATA max UDMA/133 abar m1024@0xe8585000 port 0xe8585280 irq 220
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ACPI cmd b1/c1:00:00:00:00:a0 failed (Emask=0x1 Stat=0x51 Err=0x04)
ata1: failed to recover some devices, retrying in 5 secs
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ACPI cmd b1/c1:00:00:00:00:a0 failed (Emask=0x1 Stat=0x51 Err=0x04)
ata1.00: ACPI on devcfg failed the second time, disabling (errno=-5)
ata1.00: revalidation failed (errno=1)
ata1: failed to recover some devices, retrying in 5 secs
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/133

dmesg, lspci, hdparm:
http://www.unixy.pl/maciek/download/kernel/2.6.24-rc4/


-- 
Maciej Rutecki
http://www.maciek.unixy.pl
