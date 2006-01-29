From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFC/PATCHSET] libata: new reset mechanism
Date: Sun, 29 Jan 2006 00:20:52 -0500
Message-ID: <43DC50B4.6040902@pobox.com>
References: <20051218133305.GA31571@htj.dyndns.org> <43A64334.7010500@pobox.com> <43A64D42.2080700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:33999 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750826AbWA2FVA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Jan 2006 00:21:00 -0500
In-Reply-To: <43A64D42.2080700@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: albertcc@tw.ibm.com, liml@rtr.ca, linux-ide@vger.kernel.org

Tejun Heo wrote:
> Jeff Garzik wrote:
>> Hard and soft reset should be implemented as
>>
>>     qc = ata_qc_new_init()
>>     qc->tf.protocol = ATA_PROT_HARD_RESET;
>>     ... ata_qc_issue() ...
>>
>> which automatically takes advantage of the ability to specify a 
>> behavior using the qc_prep/qc_issue driver hooks.  The ATA passthru 
>> CDB supports this method of programming (hard and soft reset are 
>> specified protocols), and this is very similar to how the SiI 3124 
>> behaves.  Other FIS-based controllers will implement qc_issue/qc_prep 
>> such that they send two Control FIS's.  Taskfile-based controllers use 
>> the currently implemented method.
> 
> 
> I don't really agree with you.  IMHO, resets are too different from 
> standard qc execution (ie. standard ATA command execution) to be a qc 
> protocol.  Also, how are we gonna represent host reset with qc?  I like 
> the "everything via qc" idea but I think making resets protocols of qc 
> is pushing too far.  Please consider...
> 
> * If we go with qc_prep/issue, we don't have context while executing 
> resets.  Even though SATA is pretty much event-driven, many controllers 
> still need quite some amount of polling during resets.  Even though a 
> controller can be reset using interrupts/events, the code will be much 
> more complex.  I think it's MUCH better to perform resets with context.
> 
> * If we perform resets with context, we can use ata_exec_internal() 
> while performing resets.  If a controller can perform resets by issuing 
> qc's or wants to do some post-reset configuration commands, it can do so 
> by simply invoking ata_exec_internal().  If resets become qc protocols, 
> we'll need to dance _really_ hard to do anything similar.  Please 
> consider the state of IDE driver regarding resets / reconfiguration.
> 
> * Resets must be followed by a series of configuration commands.  i.e. 
> we need context after performing reset anyway.  So, the context needs to 
> be there whether or not resets are performed with contexts.

That's fine, we can do without it for now.  I definitely want to see 
that portion of the ATA passthru SCSI command supported.  The spec lists 
soft and hard reset among the protocols.  You could just hard-code a 
call to the libata reset machinery for those two protocols.  Handle it 
in the simulator.

	Jeff


