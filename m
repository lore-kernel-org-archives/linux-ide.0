From: "Sandra Escandor" <sescandor@evertz.com>
Subject: RE: Western Digital Scorpio and ICH10R on Debian - NCQ issue?
Date: Tue, 19 Jul 2011 09:20:40 -0400
Message-ID: <C70A636B101FD44999B82525C3E92AFADCEADF@otis.burlington.evertz.tv>
References: <C70A636B101FD44999B82525C3E92AFAD8CE5C@otis.burlington.evertz.tv><4E20E675.2010707@gmail.com><C70A636B101FD44999B82525C3E92AFADCE88F@otis.burlington.evertz.tv> <CADLC3L04fA8p00LNbj+U_ugo=RtkEoGf5h4f-HeRj=-fqCAF+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from router.evertz.com ([204.187.63.106]:4888 "EHLO mail.evertz.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750829Ab1GSNXR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Jul 2011 09:23:17 -0400
Content-class: urn:content-classes:message
In-Reply-To: <CADLC3L04fA8p00LNbj+U_ugo=RtkEoGf5h4f-HeRj=-fqCAF+Q@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-ide@vger.kernel.org

I was just reading over the kernel logs that I sent again, and I am
wondering if this might be a software issue instead, since the kernel
log shows that the drive that seems to time out is supposedly disabled
after disk failure (sdc was disabled by raid10 module, I think):

Jul  8 14:57:19 ecs-1u kernel: [ 8753.699104] sd 2:0:0:0: [sdc]
Unhandled error code
Jul  8 14:57:19 ecs-1u kernel: [ 8753.699107] sd 2:0:0:0: [sdc] Result:
hostbyte=DID_OK driverbyte=DRIVER_TIMEOUT
Jul  8 14:57:19 ecs-1u kernel: [ 8753.699110] sd 2:0:0:0: [sdc] CDB:
Write(10): 2a 00 3e cf 18 00 00 04 00 00
Jul  8 14:57:19 ecs-1u kernel: [ 8753.699117] end_request: I/O error,
dev sdc, sector 1053759488
Jul  8 14:57:19 ecs-1u kernel: [ 8753.699144] raid10: Disk failure on
sdc, disabling device.
Jul  8 14:57:19 ecs-1u kernel: [ 8753.699144] raid10: Operation
continuing on 3 devices.

But then, a whole while later, there is an unhandled error code coming
from sdc - shouldn't we no longer get this now, since it was supposedly
disabled?

Jul  8 14:58:17 ecs-1u kernel: [ 8812.088705] sd 2:0:0:0: [sdc]
Unhandled error code
Jul  8 14:58:17 ecs-1u kernel: [ 8812.088710] sd 2:0:0:0: [sdc] Result:
hostbyte=DID_OK driverbyte=DRIVER_TIMEOUT
Jul  8 14:58:17 ecs-1u kernel: [ 8812.088714] sd 2:0:0:0: [sdc] CDB:
Write(10): 2a 00 3e cf 63 00 00 04 00 00
Jul  8 14:58:17 ecs-1u kernel: [ 8812.088723] end_request: I/O error,
dev sdc, sector 1053778688

Is the [sdc] output coming from libata still?

Thanks for your help on this, I feel like I've been stuck for a bit :)

-----Original Message-----
From: Robert Hancock [mailto:hancockrwd@gmail.com] 
Sent: Monday, July 18, 2011 12:41 PM
To: Sandra Escandor
Cc: linux-ide@vger.kernel.org
Subject: Re: Western Digital Scorpio and ICH10R on Debian - NCQ issue?

On Mon, Jul 18, 2011 at 6:42 AM, Sandra Escandor <sescandor@evertz.com>
wrote:
> Thanks for the insight Robert. Do you (or anyone else on the list)
know
> if there are any utilities that exist that would be able to allow me
to
> observe (and log) the power consumption of the drives during high I/O?

I don't think there's anything that you could do to measure this in
software. A clamp-on ammeter on one of the power supply wires would
give you a measurement, but it might not catch brief current spikes
that could be causing problems.

Usually these kinds of problems get fixed by trial and error (swapping
drives between cables, a different PSU).

>
> -----Original Message-----
> From: Robert Hancock [mailto:hancockrwd@gmail.com]
> Sent: Friday, July 15, 2011 9:17 PM
> To: Sandra Escandor
> Cc: linux-ide@vger.kernel.org
> Subject: Re: Western Digital Scorpio and ICH10R on Debian - NCQ issue?
>
> On 07/12/2011 10:21 AM, Sandra Escandor wrote:
>> The Situation:
>> It appears that a WRITE FPDMA QUEUED failed command causes driver
>> timeouts - this in turn locks up the RAID (which once worked pretty
>> well). This occurred during high I/O.
>>
>> The question:
>> 1. Is it a good idea to turn off NCQ? I've read in different posts
> that
>> it helps some, but not others - I'm currently on the way to getting
an
>> experimental box setup, but I wanted to confirm if this was a good
> idea.
>
> Not really a solution to anything, at least not likely in this case.
> More of a workaround that might happen to work by chance.
>
>> 2. Are there known issues with the ICH10R + WD7500BPKT-00PK4T0 and
the
>> libata driver?
>
> Nothing known, no.
>
>>
>> The System:
>> Four WDC WD7500BPKT-00PK4T0 drives (Western Digital Scorpio) - in
> RAID10
>> array created using mdadm 3.1.4
>> ICH10R sata controller.
>> Kernel 2.6.32-5-amd64
>
> The fact that you have multiple drives and the problem tends to occur
> during heavy I/O may point to a power issue. This has been known to
> happen when some of the drives aren't getting enough power when there
> are spikes in power draw during I/O access. In this case, using a
> beefier power supply or spreading the drives out across different
cables
>
> from the PSU may help.
>
>
