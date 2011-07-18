From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Western Digital Scorpio and ICH10R on Debian - NCQ issue?
Date: Mon, 18 Jul 2011 10:41:04 -0600
Message-ID: <CADLC3L04fA8p00LNbj+U_ugo=RtkEoGf5h4f-HeRj=-fqCAF+Q@mail.gmail.com>
References: <C70A636B101FD44999B82525C3E92AFAD8CE5C@otis.burlington.evertz.tv>
	<4E20E675.2010707@gmail.com>
	<C70A636B101FD44999B82525C3E92AFADCE88F@otis.burlington.evertz.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44232 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753310Ab1GRQlF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jul 2011 12:41:05 -0400
Received: by iwn6 with SMTP id 6so3245822iwn.19
        for <linux-ide@vger.kernel.org>; Mon, 18 Jul 2011 09:41:04 -0700 (PDT)
In-Reply-To: <C70A636B101FD44999B82525C3E92AFADCE88F@otis.burlington.evertz.tv>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sandra Escandor <sescandor@evertz.com>
Cc: linux-ide@vger.kernel.org

On Mon, Jul 18, 2011 at 6:42 AM, Sandra Escandor <sescandor@evertz.com> wrote:
> Thanks for the insight Robert. Do you (or anyone else on the list) know
> if there are any utilities that exist that would be able to allow me to
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
>> it helps some, but not others - I'm currently on the way to getting an
>> experimental box setup, but I wanted to confirm if this was a good
> idea.
>
> Not really a solution to anything, at least not likely in this case.
> More of a workaround that might happen to work by chance.
>
>> 2. Are there known issues with the ICH10R + WD7500BPKT-00PK4T0 and the
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
> beefier power supply or spreading the drives out across different cables
>
> from the PSU may help.
>
>
