From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: STANDBY IMMEDIATE failed on NVIDIA MCP5x controllers when system
 suspend
Date: Tue, 12 Mar 2013 10:34:44 +0800
Message-ID: <513E9444.1090104@intel.com>
References: <513D52BE.7040307@intel.com> <1363032071.4669.9.camel@donpedro.P-2601HN-F1>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:31357 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754993Ab3CLCdj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 Mar 2013 22:33:39 -0400
In-Reply-To: <1363032071.4669.9.camel@donpedro.P-2601HN-F1>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Peter Dons Tychsen <donpedro@tdcadsl.dk>
Cc: bladud@gmail.com, Joe Sapp <nixphoeni+kernel@gmail.com>, Alberto Mattea <support.intranet@libero.it>, Robert Hancock <hancockrwd@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Jeff Garzik <jgarzik@pobox.com>

Hi Peter,

On 03/12/2013 04:01 AM, Peter Dons Tychsen wrote:
> Hello, 
> 
> Sorry that i have not had time to investigate further.

Never mind, I just want to show the problem to all affected people and
think perhaps we can get some ideas :-)

> 
> However, it would seem that the logs provided by bladud shows (as i see
> it) the problem (the logs Aaron requested).
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=48951
> 
> 1) When running without async suspend, the disks are suspended *after*
> the sata_nv module. That makes sense, as we cannot expect the controller
> to handle commands after it has been suspended.
> 
> 2) when running with async suspended, the disks are suspended *before*
> the sata_nv module. This does not make much sense. This would also
> explain certain strangeness (different outcome) in the bug, as
> effectively the disks are racing against their own controller!

I don't see this is the case.

The device that is responsible for PM operations for the disk is named
something like sd X:0:0:0, where X is the host number, and is normally
attached under the ata port number+1. So sd 2:0:0:0 is attached to ata
port 3(if there are USB disks, things may change). And the ata port
device is reponsible for ata port level PM operations like power off the
port etc., and its device is named as atax, where x is its port number.
So you can see from the log, only after sd 4:0:0:0 and sd 2:0:0:0 failed
in their ->suspend function, ata5 and ata3's suspend functions start to
run, and then sata_nv 0000:00:05.1 starts to run.

And Bladud,
Please attach the *full* dmesg into the bugzilla page, not just the PM
part, that would make it easier for us to decide which port belongs to
which controller, thanks.

> 
> Hmmmm how is this supposed to work? Even though async suspend is
> enabled, the kernel must still have some dependencies that describe in
> which order things can be suspended. What is the correct way of telling
> the kernel (PM) that sata_nv cannot be suspended before all child disks
> are suspended? How do other drivers handle this?

PM core ensure that when a device's suspend function is to run, all its
children devices' suspend callback functions will have to be completed,
or it will wait.

And here is a simplified device relationship:

    ata_host_controller* (named sata_nv xxx)
	    |
	ata_port* (named atax, while "ata_port atax" is another device)
	/	\
scsi_host	ata_link
    |		   |
scsi_target	ata_device
    |
scsi_device* (named sd x:x:x:x)

With the devices that have actual PM operation functions defined have
the asterisk next to it.

Thanks,
Aaron

> 
> Any comments?
> 
> /pedro
> 
> 
> On Mon, 2013-03-11 at 11:42 +0800, Aaron Lu wrote:
>> Hi all,
>>
>> I've seen some reports on STANDBY IMMEDIATE failed on NVIDIA MCP5x
>> controllers when system goes to suspend(this command is sent by scsi sd
>> driver on system suspend as a SCSI STOP command, which is translated to
>> STANDBY IMMEDIATE ATA command). I've no idea of why this happened, so
>> I wrote this email in hope of getting some new idea.
>>
>> The related bug report:
>> https://bugzilla.kernel.org/show_bug.cgi?id=48951
>>
>> And google search showed that Peter reported a similar problem here:
>> http://marc.info/?l=linux-ide&m=133534061316338&w=2
>>
>> And bladud has found that, disable asyn suspend for the scsi target
>> device can work around this problem.
>>
>> Please feel free to suggest what can possibly be the cause, thanks.
>>
>> -Aaron
>>
> 
> 

