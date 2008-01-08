From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: disabling sata_nv ADMA for 2.6.24
Date: Mon, 07 Jan 2008 20:29:18 -0600
Message-ID: <4782DFFE.50301@shaw.ca>
References: <4781F008.9070404@gmail.com> <4782422C.8020202@rtr.ca>
 <4782B73B.8080309@shaw.ca> <4782BC48.4000309@gmail.com>
 <4782C008.3030902@shaw.ca> <4782CB62.7040901@gmail.com>
 <4782CEF9.3040708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:37963 "EHLO
	pd2mo3so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752275AbYAHCa0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Jan 2008 21:30:26 -0500
Received: from pd4mr1so.prod.shaw.ca
 (pd4mr1so-qfe3.prod.shaw.ca [10.0.141.212]) by l-daemon
 (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JUB00DGA08Z21B0@l-daemon> for linux-ide@vger.kernel.org; Mon,
 07 Jan 2008 19:29:23 -0700 (MST)
Received: from pn2ml3so.prod.shaw.ca ([10.0.121.147])
 by pd4mr1so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05 (built Sep
 5 2006)) with ESMTP id <0JUB0043R08ZQ020@pd4mr1so.prod.shaw.ca> for
 linux-ide@vger.kernel.org; Mon, 07 Jan 2008 19:29:24 -0700 (MST)
Received: from [192.168.1.113] ([70.64.130.4])
 by l-daemon (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JUB00G2M08XY350@l-daemon> for linux-ide@vger.kernel.org; Mon,
 07 Jan 2008 19:29:22 -0700 (MST)
In-reply-to: <4782CEF9.3040708@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Mark Lord <liml@rtr.ca>, Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Allen Martin <AMartin@nvidia.com>, Peer Chen <pchen@nvidia.com>, Kuan Luo <kluo@nvidia.com>

Tejun Heo wrote:
> Tejun Heo wrote:
>> Robert Hancock wrote:
>>>>> This has only been reported on one person's MSI board. Apparently
>>>>> another revision of the same board is reported to work, and I can't
>>>>> duplicate the problem on my Asus board, so it could just be some
>>>>> hardware problem on that motherboard.
>>>> IIRC, I have two from suse bug reports and both resolved with adma=0.
>>>> I'm not too sure whether post 2.6.23-rcX changes would have fixed those
>>>> problems tho.  FWIW, I've disabled ADMA mode on all suse products.
>>> A hotplug-related problem? Have a link to the reports?
>> Hmmm... I mis-remembered.  The reporter said it was okay in SL102
>> (2.6.18, no ADMA) but SL103 (2.6.22, ADMA is on) fell apart.  I asked
>> for retest w/ adma=0 but no response yet.
>>
>>   https://bugzilla.novell.com/show_bug.cgi?id=347184
>>
>> I tried to reproduce the problem on my a8n-e but couldn't.
> 
> Okay, just succeeded on the current #upstream-fixes, attaching the log.
>  The machine is a brick after the crash.

I assume the cable got reconnected at 325 seconds? It looks like that 
was during error handling for the previous unplug?

[  314.987885] ata3: timeout waiting for ADMA IDLE, stat=0x400
[  314.993556] ata3: timeout waiting for ADMA LEGACY, stat=0x400
[  315.009915] ata3.00: exception Emask 0x10 SAct 0x1 SErr 0x1910000 
action 0xa frozen
[  315.017708] ata3.00: ADMA status 0x00000402: , hot unplug
[  315.017714] ata3: SError: { PHYRdyChg Dispar LinkSeq TrStaTrns }
[  315.029239] ata3.00: cmd 60/01:00:92:d7:12/00:00:05:00:00/40 tag 0 
ncq 512 in
[  315.029240]          res 40/00:04:92:d7:12/00:04:92:d7:12/40 Emask 
0x10 (ATA bus error)
[  315.029243] ata3.00: status: { DRDY }
[  315.048236] ata3: hard resetting link
[  315.774982] ata3: SATA link down (SStatus 0 SControl 300)
[  315.780498] ata3: failed to recover some devices, retrying in 5 secs
[  320.788427] ata3: hard resetting link
[  325.242220] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)

Not sure if the port would be frozen at this point or not?

It would be useful to add some printks to narrow down at what point the 
lockup happens. If it's a loop, interrupt storm or something then we can 
likely fix it, but if the controller's just locking up then we may be 
out of luck..
