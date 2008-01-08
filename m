From: Tejun Heo <htejun@gmail.com>
Subject: Re: disabling sata_nv ADMA for 2.6.24
Date: Tue, 08 Jan 2008 11:55:58 +0900
Message-ID: <4782E63E.1000606@gmail.com>
References: <4781F008.9070404@gmail.com> <4782422C.8020202@rtr.ca> <4782B73B.8080309@shaw.ca> <4782BC48.4000309@gmail.com> <4782C008.3030902@shaw.ca> <4782CB62.7040901@gmail.com> <4782CEF9.3040708@gmail.com> <4782DFFE.50301@shaw.ca> <4782E5A8.9010305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ro-out-1112.google.com ([72.14.202.179]:36798 "EHLO
	ro-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768AbYAHC4U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jan 2008 21:56:20 -0500
Received: by ro-out-1112.google.com with SMTP id p4so2192721roc.5
        for <linux-ide@vger.kernel.org>; Mon, 07 Jan 2008 18:56:20 -0800 (PST)
In-Reply-To: <4782E5A8.9010305@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Allen Martin <AMartin@nvidia.com>, Peer Chen <pchen@nvidia.com>, Kuan Luo <kluo@nvidia.com>

Tejun Heo wrote:
> Robert Hancock wrote:
>>> Okay, just succeeded on the current #upstream-fixes, attaching the log.
>>>  The machine is a brick after the crash.
>> I assume the cable got reconnected at 325 seconds? It looks like that
>> was during error handling for the previous unplug?
> 
> I don't remember too well (the console was more than two meters away and
> I was just keeping disconnecting and reconnecting.  I noticed the
> machine was frozen after I came back to console, so...
> 
>> [  314.987885] ata3: timeout waiting for ADMA IDLE, stat=0x400
>> [  314.993556] ata3: timeout waiting for ADMA LEGACY, stat=0x400
>> [  315.009915] ata3.00: exception Emask 0x10 SAct 0x1 SErr 0x1910000
>> action 0xa frozen
>> [  315.017708] ata3.00: ADMA status 0x00000402: , hot unplug
>> [  315.017714] ata3: SError: { PHYRdyChg Dispar LinkSeq TrStaTrns }
>> [  315.029239] ata3.00: cmd 60/01:00:92:d7:12/00:00:05:00:00/40 tag 0
>> ncq 512 in
>> [  315.029240]          res 40/00:04:92:d7:12/00:04:92:d7:12/40 Emask
>> 0x10 (ATA bus error)
>> [  315.029243] ata3.00: status: { DRDY }
>> [  315.048236] ata3: hard resetting link
>> [  315.774982] ata3: SATA link down (SStatus 0 SControl 300)
>> [  315.780498] ata3: failed to recover some devices, retrying in 5 secs
>> [  320.788427] ata3: hard resetting link
>> [  325.242220] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>>
>> Not sure if the port would be frozen at this point or not?
>>
>> It would be useful to add some printks to narrow down at what point the
>> lockup happens. If it's a loop, interrupt storm or something then we can
>> likely fix it, but if the controller's just locking up then we may be
>> out of luck..
> 
> I think it's machine hard lock up.  NMI watchdog doesn't get triggered.
> 

Ah.. another thing.  Sometimes when I swap two drives, sata_nv fails to
detect the new drive.  If I pull out the plug and replug it, it then
recognizes the new drive.

-- 
tejun
