From: Tejun Heo <htejun@gmail.com>
Subject: Re: sda
Date: Sun, 13 Apr 2008 11:26:28 +0900
Message-ID: <48016F54.5070405@gmail.com>
References: <dd18b0c30804021244k1d44a48hc05ea88552104a71@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:39776 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752788AbYDMC0r (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Apr 2008 22:26:47 -0400
Received: by wa-out-1112.google.com with SMTP id m16so1392877waf.23
        for <linux-ide@vger.kernel.org>; Sat, 12 Apr 2008 19:26:46 -0700 (PDT)
In-Reply-To: <dd18b0c30804021244k1d44a48hc05ea88552104a71@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Justin Mattock <justinmattock@gmail.com>
Cc: linux-ide@vger.kernel.org

Justin Mattock wrote:
> Hello; hopefully this is the correct e-mail for libata.  I compiled
> 2.6.25-rc8 on a macbook pro 15' ati chipset using nubuntu. when
> performing
> echo mem > /sys/power/state simultaneously I'm noticing on the third time:
> 
> [ 2332.951249] sd 2:0:1:0: [sda] Starting disk
> [ 2313.224530] ata1.00: ACPI cmd ef/03:0c:00:00:00:a0 filtered out
> [ 2313.224532] ata1.00: ACPI cmd ef/03:44:00:00:00:a0 filtered out
> [ 2313.391129] ata1.00: configured for UDMA/66
> [ 2314.187258] ata3.01: NODEV after polling detection
> [ 2314.187262] ata3.01: revalidation failed (errno=-2)
> [ 2314.187266] ata3: failed to recover some devices, retrying in 5 secs
> [ 2319.368648] ata3.01: ACPI cmd ef/03:0c:00:00:00:b0 filtered out
> [ 2319.368654] ata3.01: ACPI cmd ef/03:45:00:00:00:b0 filtered out
> [ 2319.382275] ata3.01: configured for UDMA/100
> [ 2319.400505] sd 2:0:1:0: [sda] 234441648 512-byte hardware sectors (120034 MB)
> [ 2319.400505] sd 2:0:1:0: [sda] Write Protect is off
> [ 2319.400505] sd 2:0:1:0: [sda] Mode Sense: 00 3a 00 00
> [ 2319.400505] sd 2:0:1:0: [sda] Write cache: enabled, read cache:
> enabled, doesn't support DPO or FUA
> 
> revalidation error=-2
> attached is dmesg from the test

Can you please post the result of "lspci -nn".  The error per-se is 
okay.  The drive failed to respond to IDENTIFY at the first try but on 
retrial it responded okay.

-- 
tejun
