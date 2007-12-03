From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] sata_mv:  Fix broken Marvell 7042 support.
Date: Mon, 03 Dec 2007 18:59:37 -0500
Message-ID: <47549869.2040404@rtr.ca>
References: <4751A2DA.6030403@rtr.ca>	<BD261180E6D35F4D9D32F3E44FD3D9010ADF2E30@EMPBEDEX.empirix.com>	<20071203154749.6lah7pulw8ow0s84@email.syntomax.com>	<47543C58.4040106@rtr.ca>	<475447A0.2010101@rtr.ca>	<47544B2F.5080007@pobox.com>	<47544BAA.1020901@rtr.ca>	<BD261180E6D35F4D9D32F3E44FD3D9010ADF35A5@EMPBEDEX.empirix.com>	<47544DA9.3070702@rtr.ca>	<47544E74.3000608@rtr.ca> <20071203184204.1a2d7e35@the-village.bc.nu> <47545503.2070006@rtr.ca> <475469C1.2080700@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:1710 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751458AbXLCX7k (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 3 Dec 2007 18:59:40 -0500
In-Reply-To: <475469C1.2080700@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Morrison, Tom" <tmorrison@empirix.com>, Jeff Garzik <jgarzik@pobox.com>, hp@syntomax.com, IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@redhat.com>

Mark Lord wrote:
> Mark Lord wrote:
>> Alan Cox wrote:
>>>> Confirmed.  It writes "lgcy" + stuff into the 9th sector of the drive
>>>> (for my "Legacy" drive).
>>>
>>> Thats quite nasty. Given that users putting volumes unpartitioned on
>>> drives may see actual data corruption and loss perhaps we should
>>> blacklist that controller variant with a large warning ?
>> ..
>>
>> Yeah, that's quite obnoxious of Highpoint to just arbitrarily 
>> overwrite data.
>>
>> Some warnings would probably be quite useful here.
>>
>> We could log a WARNING the first few times (after boot)
>> whenever we see software writing to that sector.
>> Do this with a hack in mv_qc_prep or mv_qc_issue ?
>>
>> Or even just fail any write to that sector, so that the error
>> gets propagated all the way back to usermode where it might be visible?
>>
>> Plus some big nasty "awareness" messages at boot regardless.
> ...
> 
> Something like this, perhaps.
> 
> Comments, suggestions ?
..

I'm not convinced that the big sledgehammer (previous patch which snooped
for access to the sector that sometimes is overwritten by BIOS)
is useful or does any good here.

The problem is, just by powering-on with a drive connected to the RocketRAID,
one may have already toasted that sector, long before Linux/sata_mv ever
get to see it or warn about it.

So, at a minimum, we do need to print some kind of disclaimer message
to show that we're at least aware of it.

But beyond that, I don't think there's anything *really* useful to do.
Comments?

I'll cook up a patch for 2.6.24 that detects and warns when a PCIe
RocketRAID is found.  

But do *all* HighPoint "RAID" cards do the same thing?
Anyone out there got hardware other than a 2300/2310 ?

Thanks
