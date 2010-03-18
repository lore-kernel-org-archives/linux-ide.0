From: Stan Hoeppner <stan@hardwarefreak.com>
Subject: Re: understanding the cause of ATA failures
Date: Thu, 18 Mar 2010 17:33:24 -0500
Message-ID: <4BA2AA34.70105@hardwarefreak.com>
References: <4BA2A02F.7040200@gmail.com> <4BA2A27E.9040704@buttersideup.com> <4BA2A590.4030505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mo-65-41-216-221.sta.embarqhsd.net ([65.41.216.221]:45881 "EHLO
	greer.hardwarefreak.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353Ab0CRWdZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Mar 2010 18:33:25 -0400
Received: from [192.168.100.53] (gffx.hardwarefreak.com [192.168.100.53])
	by greer.hardwarefreak.com (Postfix) with ESMTP id E7B926C3D5
	for <linux-ide@vger.kernel.org>; Thu, 18 Mar 2010 17:33:24 -0500 (CDT)
In-Reply-To: <4BA2A590.4030505@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Is there a SATA backplane involved or is each drive cabled directly to the
controller?  If backplane, is it active or passive?  Whose product is it?

Is this a relatively new machine or has it been running for some months
without problems until recently?

-- 
Stan


Ludovico Cavedon put forth on 3/18/2010 5:13 PM:
> Tim Small wrote:
>> Do the drives have any SMART errors logged?  Any reallocated sectors? 
> 
> No SMART errors logged.
> No reallocated sector for all the hard drives.
> 
> Well, I forgot to mention another weired thing. This is what happneded:
> * sdc failed and got removed from the RAID array (I pasted the log in my
> previous email)
> * sda got removed (no logs available)
> * sdb got removed (no logs available)
> 
> When I realized tha machine was down, I found that the *sdd* was giving
> IO errors. So I had to replace sdd, but sda, sdb and sdc, who were those
> drives that "failed" first, are working good.
> 
>> Do you run smartd, or any other smart data collection?  I've had a load
>> of trouble with WD drives when smart data collection was enabled. 
> 
> No smartd running.
> 
>> Haven't had time to get to the bottom of it, but I suspect a firmware bug.
> 
> SATA controller firmware bug?
> Do you think changing the controller mode from "AHCI" to "IDE" in the
> BIOS might help to prevent these errors?
> 
> Thanks for your answer,
> Ludovico
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

