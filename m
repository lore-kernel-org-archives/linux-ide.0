From: Tomas Lund <tlund@nxs.se>
Subject: Re: Need help understanding SATA error message.
Date: Fri, 28 Mar 2008 15:28:26 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0803281519550.5510@envy.nxs.se>
References: <Pine.LNX.4.61.0803271554050.5510@envy.nxs.se> <47ECF555.6050000@garzik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from envy.nxs.se ([212.247.200.182]:47035 "EHLO envy.nxs.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751027AbYC1O2j (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Mar 2008 10:28:39 -0400
In-Reply-To: <47ECF555.6050000@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

On Fri, 28 Mar 2008, Jeff Garzik wrote:

> Tomas Lund wrote:
>> 
>> I have a SuperMicro X7SBi with ICH9R SATA running 64bit linux 2.6.24.4. 
>> I have 4 1TB disks connected to the motherboard, and one of the disks 
>> is logging an error message. Everything is brand new, and hooked up 
>> just a few weeks ago.
>> 
>> S.M.A.R.T. shows no errors (see output from "smartctl -a" at the bottom 
>> of this email) after running both a short and long offline selftest, 
>> and my question is if its possible to tell from this error message what 
>> the problem is. The result "51/04:00:0a:24:f9" is a bit crypting to me, 
>> and it would be nice to know what the problem actually is before 
>> returning the disk.
>
> What a coincidence :)  The ata wiki, just created yesterday, had a new 
> page added yesterday:
>
> 	http://ata.wiki.kernel.org/index.php/Libata_error_messages

Heh, yeah, now I know that the controller sent the command "ea" to the 
disk, and that the disk has indicated a device error, but I am afraid it 
doesnt really tell me alot more than i already knew, ie: not alot. :)

All arguments to this "ea" command seems to have been 0? And the error has 
"status = 0x51" listing som LBA location on the disk where the error 
occured?

Sorry, but I dont know enough about the protocol to understand most of 
this, could you please help me decode it futher?

Best regards,
Tomas
