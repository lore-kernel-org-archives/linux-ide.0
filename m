From: Tejun Heo <htejun@gmail.com>
Subject: Re: libata FUA revisited
Date: Mon, 12 Feb 2007 00:31:07 -0800
Message-ID: <45D025CB.6070205@gmail.com>
References: <45CFDE27.5030607@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.230]:30078 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933120AbXBLIbY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Feb 2007 03:31:24 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1747174wxd
        for <linux-ide@vger.kernel.org>; Mon, 12 Feb 2007 00:31:23 -0800 (PST)
In-Reply-To: <45CFDE27.5030607@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, edmudama@gmail.com, Nicolas.Mailhot@LaPoste.net

Hello,

Robert Hancock wrote:
[--correct summary snipped--]
> Given the above, what I'm proposing to do is:
> 
> -Remove the blacklisting of Maxtor BANC1G10 firmware for FUA. If we need 
> to FUA-blacklist any drives this should likely be added to the existing 
> "horkage" mechanism we now have. However, at this point I don't think 
> that's needed, considering that I've seen no conclusive evidence that 
> any drive has ever been established to have broken FUA.

Agreed.

> -Add a new port flag ATA_FLAG_NO_FUA to indicate that a controller can't 
> handle FUA commands, and add that flag to sata_sil. Force FUA off on any 
> drive connected to a controller with this bit set.
> 
> There was some talk that sata_mv might have this problem, but I believe 
> the conclusion was that it didn't. The only controllers that would are 
> ones that actually try to interpret the ATA command codes and don't know 
> about WRITE DMA FUA.

I think it would be better to add ATA_FLAG_FUA instead of ATA_FLAG_NO_FUA.

> -Change the fua module option to control FUA enable/disable to have a 
> third value, "enable for NCQ-supporting drives only", which would become 
> the new default. That case seems less likely to cause problems since FUA 
> on NCQ is just another bit in the command whereas FUA on non-NCQ is an 
> entirely different, potentially unsupported command.

Not enabling FUA doesn't result in huge performance hit.  I'm not sure 
whether we should go such far.  Just supporting FUA on known good 
controllers sounds good enough to me.

> Any comments?
> 
> As an aside, I came across a comment that the Silicon Image Windows 
> drivers for NCQ-supporting controllers have some blacklist entries for 
> drives with broken NCQ in their .inf files. We only seem to have one in 
> the libata NCQ blacklist, we may want to add some more of these. The 
> ones in the current SiI3124 and 3132 drivers' .inf files for 
> "DisableSataQueueing" appear to be:
> 
> Model                Firmware
> Maxtor 7B250S0            BANC1B70
> HTS541060G9SA00            MB3OC60D
> HTS541080G9SA00            MB4OC60D
> HTS541010G9SA00            MBZOC60D
> 
> (the latter 3 being Hitachi Travelstar drives)

Yeah, I don't think we need to be too careful about blacklisting NCQ 
considering the sorry state of many early NCQ firmwares.  Please submit 
a patch.  It would be nice if you add a comment why the drives are added 
for documentation.

Thanks.

-- 
tejun
