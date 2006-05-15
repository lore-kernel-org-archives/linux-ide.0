From: Tejun Heo <htejun@gmail.com>
Subject: Re: question about boot time drive initialization
Date: Mon, 15 May 2006 10:50:29 +0900
Message-ID: <4467DE65.7000701@gmail.com>
References: <4466DE81.2040006@gmail.com> <311601c90605140929s5fe919efk69c59bd5f61fee7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0102.google.com ([66.249.82.198]:37072 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751383AbWEOBuf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 14 May 2006 21:50:35 -0400
Received: by wx-out-0102.google.com with SMTP id i28so21674wxd
        for <linux-ide@vger.kernel.org>; Sun, 14 May 2006 18:50:35 -0700 (PDT)
In-Reply-To: <311601c90605140929s5fe919efk69c59bd5f61fee7d@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Eric D. Mudama" <edmudama@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

[CC'ing jeff and linux-ide, hope you don't mind]

Hello, Eric D. Mudama.

Eric D. Mudama wrote:
> Immediately following POR (power on reset) it takes our hardware a few
> milliseconds to initialize and test our own hardware.  Near the end of
> that window, our drive will respond to COMRESET with a COMINIT.
> 
> The FIS34 won't be generated until after the drive has spun up
> successfully and loaded it's code from the media.  This is expected to
> take anywhere from 3-7 seconds for desktop drives with 1-4 platters.
> Notebooks spin up significantly faster.

I see.

> Is power always active in this infrastructure, and will the host
> respond to COMINIT with either a COMRESET or a COMWAKE?  If so, I'd
> just wait for the FIS34.  If you don't see a FIS34 within say 10
> seconds, I'd hit the drive with a COMRESET.

The problem I'm having is that not all controllers can catch the initial 
FIS34 reliably after hotplugging.  sil3112/4 family seems to always 
catch the FIS thus reliably clearing ATA_BUSY (they seem to set ATA_BUSY 
automatically when PHY status changes then clears it on the reception of 
ATA_BUSY).

But for more complex controllers, it's not always the case.  sil3124/32 
actually doesn't have single TF image.  TF images are tied to commands. 
  No command, no TF regs.  So, the controller doesn't provide indication 
for the first FIS.  Fortunately, issuing SRST makes the controller wait 
for ATA_BUSY reliably.  I don't know whether the controller waits for 
!ATA_BUSY before issuing SRST (unlikely), or the drive handles SRST 
okay, or the controller simply ignores R_ERR on SRST issue and thinks 
SRST completed when it actually receives the first FIS34.

ATM, AHCI seems a little bit worse.  Unlike sil3124/32, it can wait for 
the first FIS34 but it fails more often than not.  The drives are 
transmitting FIS34 (thus 3112/4 works) but AHCI sometimes choose to 
ignore it (nothing appears in the FIS reception area) and eventually 
times out.  Adding delays here and there seems to make things work but 
it seems like a lousy solution.  Argghhh...

This problem becomes more evident with PM.  PM spec omits the 'waiting 
for the first FIS34' part in the initialization sequence because 
controllers might not be able to handle the FIS.  Actually, when a new 
device gets plugged the port's X bit is turned on and all FIS 
transmissions are blocked.  So, there's no way for the host controller 
to tell whether the device is ready for command or not and has no other 
way than issuing SRST blindly after resuming the link.

On EH case (transient link failure), this is okay as the drive can 
handle the SRST okay, but it seems to cause problems on hotplug case. 
What happens is the controller issues SRST before the drive transmits 
the first FIS34.  As said above, this is the spec-sanctioned enumeration 
sequence.

I'm getting a lot of timeouts on the first reset after hotplug and still 
diddling with delays.  Any thoughts on how this should be solved?  Can 
drives handle SRST before it enters idle state after POR?

Thanks a lot and you're right on spot.

-- 
tejun
