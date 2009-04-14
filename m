From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH RFC] ahci: implement handoff quirk
Date: Tue, 14 Apr 2009 05:41:01 -0400
Message-ID: <49E45A2D.8090107@garzik.org>
References: <485882FE.1060409@kernel.org> <49E0CB5B.3070807@garzik.org> <49E0D8B7.8010206@kernel.org> <49E0DB1E.8070701@garzik.org> <49E45460.8010809@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:40232 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755206AbZDNJlF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Apr 2009 05:41:05 -0400
In-Reply-To: <49E45460.8010809@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Zhao, Richard" <Richard.Zhao@amd.com>, shane.huang@amd.com
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> Jeff Garzik wrote:
>> Tejun Heo wrote:
>>> Jeff Garzik wrote:
>>>> We probably need to do this...
>>>>
>>>> it's not a controller requirement but a BIOS one, so in theory even an
>>>> existing, deployed AHCI 1.2 platform could suddenly require BIOS/OS
>>>> handoff, if a BIOS update suddenly starts doing new and weird stuff
>>>> in SMI.
>>>>
>>>> Note that we need to do BIOS/OS handoff upon resume as well as at boot
>>>> time.
>>> Yeah, probably.  Do you know of any system which makes use of this
>>> feature?  I'm a bit uneasy about committing it without any testing.
>> I don't.
>>
>> But the purpose of the feature is to tell BIOS to cleanup and stop using
>> the hardware.  It's a dumb feature, because of compatibility realities,
>> but hey, other network and SCSI drivers have been doing this sort of
>> synchronization with their on-board firmwares for years.
>>
>> IMO the more dangerous route is to continue loading ahci, without first
>> telling the BIOS to clean up and get out of our way.
> 
> Hmmm.... yeah, I'm just worried a bit about adding a chunk of
> completely untested code.  How about adding a big fat warning message
> which gets triggered if the handoff thing seems to be active?

Yeah, printing out something makes a lot of sense, but I would just add 
it to the flags output in ahci_print_info() or similar.   If we don't 
see any further action from ahci (or the system as a whole), we know 
something exploded very early in the AHCI driver load.

Or maybe AMD (I see they're CC'd) could test this for us?  AMD, what say 
you?

	Jeff



