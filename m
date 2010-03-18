From: Ludovico Cavedon <ludovico.cavedon@gmail.com>
Subject: Re: understanding the cause of ATA failures
Date: Thu, 18 Mar 2010 15:13:36 -0700
Message-ID: <4BA2A590.4030505@gmail.com>
References: <4BA2A02F.7040200@gmail.com> <4BA2A27E.9040704@buttersideup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:55753 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704Ab0CRWNk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Mar 2010 18:13:40 -0400
Received: by ey-out-2122.google.com with SMTP id 9so2366eyd.5
        for <linux-ide@vger.kernel.org>; Thu, 18 Mar 2010 15:13:39 -0700 (PDT)
In-Reply-To: <4BA2A27E.9040704@buttersideup.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tim Small <tim@buttersideup.com>
Cc: linux-ide@vger.kernel.org

Tim Small wrote:
> Do the drives have any SMART errors logged?  Any reallocated sectors? 

No SMART errors logged.
No reallocated sector for all the hard drives.

Well, I forgot to mention another weired thing. This is what happneded:
* sdc failed and got removed from the RAID array (I pasted the log in my
previous email)
* sda got removed (no logs available)
* sdb got removed (no logs available)

When I realized tha machine was down, I found that the *sdd* was giving
IO errors. So I had to replace sdd, but sda, sdb and sdc, who were those
drives that "failed" first, are working good.

> Do you run smartd, or any other smart data collection?  I've had a load
> of trouble with WD drives when smart data collection was enabled. 

No smartd running.

> Haven't had time to get to the bottom of it, but I suspect a firmware bug.

SATA controller firmware bug?
Do you think changing the controller mode from "AHCI" to "IDE" in the
BIOS might help to prevent these errors?

Thanks for your answer,
Ludovico
