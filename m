From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] Unbreak build of PMP with ACPI disabled
Date: Fri, 13 Jul 2007 16:09:13 +0900
Message-ID: <46972519.80703@gmail.com>
References: <20070713065600.GB8320@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:6464 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758850AbXGMHJ0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Jul 2007 03:09:26 -0400
Received: by wa-out-1112.google.com with SMTP id v27so478770wah
        for <linux-ide@vger.kernel.org>; Fri, 13 Jul 2007 00:09:26 -0700 (PDT)
In-Reply-To: <20070713065600.GB8320@vana.vc.cvut.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Petr Vandrovec <petr@vandrovec.name>
Cc: linux-ide@vger.kernel.org, Robert Hancock <hancockr@shaw.ca>

Petr Vandrovec wrote:
> Hello,
>   first let me thank you for your PMP code.  Works great.  Though I could not
> built it with ACPI disable - it is possible that I did merge wrong (I'm using
> your tree with current Linus's TOT), though I do not think.  Patch is at
> the end.

It's my screw up.  I will integrate the patch in the next round
(scheduled for later today).

> If you are interested in success report, then my dmesg is attached.  SiI3132,
> with Sans Digital MS4UM, with SiI3726 multiplier.  Multipliers ports 0-3 are
> connected to hotpluggable slots, port 4 is not connected anywhere, and port
> 5 is connected to some well hidden 1.5Gbps device.
> 
> Only problem I've noticed is that smartctl on drives connected to sata_nv
> needs '-T permissive', while if same drive is connected to sata_sil24's PMP,
> it works without problem.  
> 
> Error SMART Status command failed
> Please get assistance from http://smartmontools.sourceforge.net/
> Values from ATA status return descriptor are:
>  00     09 0c 00 00 00 00 00 00  00 00 00 00 00 50
> A mandatory SMART command failed: exiting. To continue, add one or more '-T permissive' options.

Yeah, we seem to have some problem with passing result TF to userland in
sata_nv (cc'ed Robert).

Thanks.

-- 
tejun
