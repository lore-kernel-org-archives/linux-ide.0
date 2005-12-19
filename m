From: Tejun Heo <htejun@gmail.com>
Subject: Re: [RFC/PATCHSET] libata: new reset mechanism
Date: Mon, 19 Dec 2005 15:03:46 +0900
Message-ID: <43A64D42.2080700@gmail.com>
References: <20051218133305.GA31571@htj.dyndns.org> <43A64334.7010500@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.205]:12131 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030269AbVLSGDx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Dec 2005 01:03:53 -0500
Received: by zproxy.gmail.com with SMTP id 13so1226334nzn
        for <linux-ide@vger.kernel.org>; Sun, 18 Dec 2005 22:03:52 -0800 (PST)
In-Reply-To: <43A64334.7010500@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: albertcc@tw.ibm.com, liml@rtr.ca, linux-ide@vger.kernel.org


Hello, Jeff.

Jeff Garzik wrote:
> Tejun Heo wrote:
> 
>> Hello, all.
>>
>> Currently libata uses ->phy_reset to reset ports.  However,
>> ->phy_reset is tightly woven into probing process (directly
>> manipulating device[]->class and disabling ports on failure) and thus
>> awkward to use for error handling or other purposes.
>>
>> Another problem with the current scheme is that libata doesn't have
>> much control over reset process, which isn't very nice for both
>> initialization and error handling.
>>
>> This patchset implements new reset mechanism.  The new mechanism can
>> peacefully live side-by-side with ->phy_reset mechanism and low level
>> drivers can be converted gradually.  This patchset converts sata_sil,
>> sata_sil24, ata_piix and ahci as a start.
>>
>> This patchset is composed of the following 14 patches.
>>
>> #01-03    : implement new reset mechanism and standard callbacks
>> #04    : preparation for low level driver conversion
>> #05    : convert sata_sil
>> #06-07    : convert sata_sil24 and add hardreset
>> #08-09    : convert ata_piix
>> #10-14    : convert ahci and add softreset
> 
> 
> Hard and soft reset should be implemented as
> 
>     qc = ata_qc_new_init()
>     qc->tf.protocol = ATA_PROT_HARD_RESET;
>     ... ata_qc_issue() ...
> 
> which automatically takes advantage of the ability to specify a behavior 
> using the qc_prep/qc_issue driver hooks.  The ATA passthru CDB supports 
> this method of programming (hard and soft reset are specified 
> protocols), and this is very similar to how the SiI 3124 behaves.  Other 
> FIS-based controllers will implement qc_issue/qc_prep such that they 
> send two Control FIS's.  Taskfile-based controllers use the currently 
> implemented method.

I don't really agree with you.  IMHO, resets are too different from 
standard qc execution (ie. standard ATA command execution) to be a qc 
protocol.  Also, how are we gonna represent host reset with qc?  I like 
the "everything via qc" idea but I think making resets protocols of qc 
is pushing too far.  Please consider...

* If we go with qc_prep/issue, we don't have context while executing 
resets.  Even though SATA is pretty much event-driven, many controllers 
still need quite some amount of polling during resets.  Even though a 
controller can be reset using interrupts/events, the code will be much 
more complex.  I think it's MUCH better to perform resets with context.

* If we perform resets with context, we can use ata_exec_internal() 
while performing resets.  If a controller can perform resets by issuing 
qc's or wants to do some post-reset configuration commands, it can do so 
by simply invoking ata_exec_internal().  If resets become qc protocols, 
we'll need to dance _really_ hard to do anything similar.  Please 
consider the state of IDE driver regarding resets / reconfiguration.

* Resets must be followed by a series of configuration commands.  i.e. 
we need context after performing reset anyway.  So, the context needs to 
be there whether or not resets are performed with contexts.

> On a separate note, E.D.D. support can probably be dropped.  No driver 
> uses it AFAIK.  It was only used during development and in the early 
> libata days.

Cool.

> Further, we should lean towards avoiding hard reset, and issuing SRST 
> most of the time, even for drivers currently doing hard reset (COMRESET).

That's what this patchset does.  It issues COMRESET only if SRST fails. 
  I'll talk about this in another reply.

Thanks for reviewing this.

-- 
tejun
