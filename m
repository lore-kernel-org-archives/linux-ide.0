From: Raman Gupta <rocketraman@fastmail.fm>
Subject: Marvell exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen (was
 Re: [PATCH 0/3] AHCI updates: Marvell AHCI PATA works; pata_marvell fate?)
Date: Sat, 02 Jan 2010 03:44:50 -0500
Message-ID: <4B3F0782.4040207@fastmail.fm>
References: <20090417023949.GA14469@havoc.gtf.org> <loom.20091227T054252-842@post.gmane.org> <4B37D713.4070407@gmail.com> <4B37FB36.1040603@fastmail.fm> <4B3B8B0B.2080805@seoss.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:34653 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752125Ab0ABIow (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 2 Jan 2010 03:44:52 -0500
In-Reply-To: <4B3B8B0B.2080805@seoss.co.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tim Small <tim@seoss.co.uk>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-ide@vger.kernel.org

On 12/30/2009 12:16 PM, Tim Small wrote:
> Raman Gupta wrote:
>> However, note that I can make the "exception Emask 0x0 SAct 0x0 SErr
>> 0x0 action 0x6 frozen" happen even with the RAID array stopped and no
>> filesystems mounted. All I have to do is run the smartctl -a /dev/sdd
>> command (sdd is attached to the Marvell controller) repeatedly until
>> this exception occurs:
>>
>> Dec 27 18:59:30 x kernel: ata6.00: exception Emask 0x0 SAct 0x0 SErr
>> 0x0 action 0x6 frozen
>> Dec 27 18:59:30 x kernel: ata6.00: cmd
>> ec/00:01:00:00:00/00:00:00:00:00/00 tag 0 pio 512 in
>> Dec 27 18:59:30 x kernel: res 40/00:00:00:4f:c2/00:00:00:00:00/40
>> Emask 0x4 (timeout)
>> Dec 27 18:59:30 x kernel: ata6.00: status: { DRDY }
>> Dec 27 18:59:30 x kernel: ata6: hard resetting link
>> Dec 27 18:59:30 x kernel: ata6: SATA link up 3.0 Gbps (SStatus 123
>> SControl 300)
>> Dec 27 18:59:30 x kernel: ata6.00: configured for UDMA/133
>> Dec 27 18:59:30 x kernel: ata6: EH complete
>>
>> Usually 10-15 executions is sufficient to replicate the issue.
>
> Hmm. I wonder what running this script from this bug:
>
> http://bugzilla.kernel.org/show_bug.cgi?id=14831
>
> against drives attached to other controllers would do? It doesn't do
> anything particularly special - just runs smartctl in a loop while also
> writing to the same drive (via fs using dd).

Against a Seagate ST3500418AS on the Marvell controller, the script 
produced the first "smartctl failed" error in 55 seconds. Within about 
8 minutes, everything went to pot and all drives on that controller 
were completely inaccessible (all filesystem writes failed and the 
kernel could not IDENTIFY the drives). As far as I can tell with my 
multimeter, voltages were stable.

> Out of interest have you tried drives from other manufacturers?

Unfortunately, at the moment I don't have any non-Seagate drives 
available.

> Would also be interested to see what happens if you run the script
> against the same drive, but attached to the ICH7?

The problem occurs against any of the three Seagate ST3500418AS drives 
I have attached to the Marvell. Against the same model of drive 
attached to my ICH7 controller, I canceled the script after it ran for 
1.5 hours without any problems. So the problem appears to be exclusive 
to the Marvell -- either the hardware or the driver.

Furthermore, over the last few days, I've had smartd and hddtemp 
turned off for the Marvell drives, and they have been stable and 
error-free.

Cheers,
Raman
