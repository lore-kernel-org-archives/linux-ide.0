From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH RFC] ahci: implement handoff quirk
Date: Tue, 14 Apr 2009 18:16:16 +0900
Message-ID: <49E45460.8010809@kernel.org>
References: <485882FE.1060409@kernel.org> <49E0CB5B.3070807@garzik.org> <49E0D8B7.8010206@kernel.org> <49E0DB1E.8070701@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55048 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751166AbZDNJRW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 14 Apr 2009 05:17:22 -0400
In-Reply-To: <49E0DB1E.8070701@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, "Zhao, Richard" <Richard.Zhao@amd.com>, shane.huang@amd.com

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Jeff Garzik wrote:
>>> We probably need to do this...
>>>
>>> it's not a controller requirement but a BIOS one, so in theory even an
>>> existing, deployed AHCI 1.2 platform could suddenly require BIOS/OS
>>> handoff, if a BIOS update suddenly starts doing new and weird stuff
>>> in SMI.
>>>
>>> Note that we need to do BIOS/OS handoff upon resume as well as at boot
>>> time.
>>
>> Yeah, probably.  Do you know of any system which makes use of this
>> feature?  I'm a bit uneasy about committing it without any testing.
> 
> I don't.
> 
> But the purpose of the feature is to tell BIOS to cleanup and stop using
> the hardware.  It's a dumb feature, because of compatibility realities,
> but hey, other network and SCSI drivers have been doing this sort of
> synchronization with their on-board firmwares for years.
> 
> IMO the more dangerous route is to continue loading ahci, without first
> telling the BIOS to clean up and get out of our way.

Hmmm.... yeah, I'm just worried a bit about adding a chunk of
completely untested code.  How about adding a big fat warning message
which gets triggered if the handoff thing seems to be active?

Thanks.

-- 
tejun
