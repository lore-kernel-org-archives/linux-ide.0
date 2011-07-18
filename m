From: "Sandra Escandor" <sescandor@evertz.com>
Subject: RE: Western Digital Scorpio and ICH10R on Debian - NCQ issue?
Date: Mon, 18 Jul 2011 08:42:21 -0400
Message-ID: <C70A636B101FD44999B82525C3E92AFADCE88F@otis.burlington.evertz.tv>
References: <C70A636B101FD44999B82525C3E92AFAD8CE5C@otis.burlington.evertz.tv> <4E20E675.2010707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from router.evertz.com ([204.187.63.106]:31354 "EHLO mail.evertz.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751642Ab1GRMpA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jul 2011 08:45:00 -0400
Content-class: urn:content-classes:message
In-Reply-To: <4E20E675.2010707@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-ide@vger.kernel.org

Thanks for the insight Robert. Do you (or anyone else on the list) know
if there are any utilities that exist that would be able to allow me to
observe (and log) the power consumption of the drives during high I/O?

-----Original Message-----
From: Robert Hancock [mailto:hancockrwd@gmail.com] 
Sent: Friday, July 15, 2011 9:17 PM
To: Sandra Escandor
Cc: linux-ide@vger.kernel.org
Subject: Re: Western Digital Scorpio and ICH10R on Debian - NCQ issue?

On 07/12/2011 10:21 AM, Sandra Escandor wrote:
> The Situation:
> It appears that a WRITE FPDMA QUEUED failed command causes driver
> timeouts - this in turn locks up the RAID (which once worked pretty
> well). This occurred during high I/O.
>
> The question:
> 1. Is it a good idea to turn off NCQ? I've read in different posts
that
> it helps some, but not others - I'm currently on the way to getting an
> experimental box setup, but I wanted to confirm if this was a good
idea.

Not really a solution to anything, at least not likely in this case. 
More of a workaround that might happen to work by chance.

> 2. Are there known issues with the ICH10R + WD7500BPKT-00PK4T0 and the
> libata driver?

Nothing known, no.

>
> The System:
> Four WDC WD7500BPKT-00PK4T0 drives (Western Digital Scorpio) - in
RAID10
> array created using mdadm 3.1.4
> ICH10R sata controller.
> Kernel 2.6.32-5-amd64

The fact that you have multiple drives and the problem tends to occur 
during heavy I/O may point to a power issue. This has been known to 
happen when some of the drives aren't getting enough power when there 
are spikes in power draw during I/O access. In this case, using a 
beefier power supply or spreading the drives out across different cables

from the PSU may help.

