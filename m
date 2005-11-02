From: thomas schorpp <t.schorpp@gmx.de>
Subject: Re: [usb-storage] [Merging ATA passthru] on integrating SMART/ATA-Security
 in usb-storage driver
Date: Thu, 03 Nov 2005 00:22:32 +0100
Message-ID: <43694A38.2060908@gmx.de>
References: <CA45571DE57E1C45BF3552118BA92C9D69BF3A@WDSCEXBECL03.sc.wdc.com>
Reply-To: t.schorpp@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from imap.gmx.net ([213.165.64.20]:35723 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965335AbVKBXWh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Nov 2005 18:22:37 -0500
In-Reply-To: <CA45571DE57E1C45BF3552118BA92C9D69BF3A@WDSCEXBECL03.sc.wdc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Timothy Thelin <Timothy.Thelin@wdc.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, usb-storage@lists.one-eyed-alien.net, linux-ide@vger.kernel.org

Timothy Thelin wrote:
> 
>>>>They aren't ATA read/write commands; they are SCSI commands.  
>>>>If there is 
>>>>a version of SMART that runs over SCSI, you might be able to use it.
>>>>
>>>>
>>>>
>>>>>and sata is short of smart support. both use scsi-emu(?).
>>>>>
>>>>>i dont think theres a hardware problem.
>>>>
>>>>Yes there is.  The USB interface on the drive won't recognize 
>>>>an ATA SMART
>>>>command and won't pass it on to the drive controller.
>>>>
>>>
>>>
>>>To expand on this, its really the USB device firmware which needs
>>>the passthru mechanism implmented, since (as stated) it expects
>>>to be getting scsi commands.  Now there are many vendor specific
>>>ways to embed ATA commands inside of scsi cdbs, and then there are
>>>two public methods that I'm aware of: SAT and the At2lp (cypress
>>>bridge board, docs on their website).
>>>
>>>And to send these commands, user-space already has SG_IO.
>>>

hmm, sg_mod is not loaded here on usb2 disk init...

sd_mod                 16144  0
usb_storage            63360  0
scsi_mod              130856  2 sd_mod,usb_storage

trying manual loading...

>>
>>so sg3_utils and sdparm could be used for commands(?)
>> 
> 
> 
> If those utilites understood the ATACB and SAT cdb specifications,
> they could be made to do security / smart commands by using SG_IO.
> My current understanding is that those utilities only think in
> terms of scsi, and not in terms of ATA passthru.

yes.

> 
> I have hands on experience using SG_IO to send ATACB cdbs to usb
> devices to do various things.  ATACB allows you to do most ATA
> commands, and it works pretty well.

great.

> 
> The biggest issue is that because USB device are exported to
> SCSI core as scsi2 devices, SCSI core adds LUN info into the
> cdb which messes up the ATACB signature and causes the bridge
> to reject the command (this will be a SAT passthru issue
> as well). When wanting to do ATACB I had to patch the kernel
> to stop this behavior so that the cdb would pass through the
> system unmangled.
> 
> If you had time to spare, instead of touching usb-storage,
> it might be better spent resurecting SG_FLAG_LUN_INHIBIT to
> stop the above behavior so that SG_IO cdbs can be passed
> through untouched.
> (SG_FLAG_FUN_INHIBIT was a flag SG_IO used to support a long
> time ago, and I have no idea why it was dropped, but it was)
> 

as you said, no need to touch usb-storage.

thx for the advise :)

ill try on resurecting SG_FLAG_LUN_INHIBIT if no one vetos (dont want to
break other stuff maybe using this behaviour).

> 
> Regards,
> Tim Thelin

y
tom

