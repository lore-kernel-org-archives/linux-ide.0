From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Western Digital Scorpio and ICH10R on Debian - NCQ issue?
Date: Fri, 15 Jul 2011 19:16:37 -0600
Message-ID: <4E20E675.2010707@gmail.com>
References: <C70A636B101FD44999B82525C3E92AFAD8CE5C@otis.burlington.evertz.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41242 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751883Ab1GPBQl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Jul 2011 21:16:41 -0400
Received: by iwn6 with SMTP id 6so1596478iwn.19
        for <linux-ide@vger.kernel.org>; Fri, 15 Jul 2011 18:16:40 -0700 (PDT)
In-Reply-To: <C70A636B101FD44999B82525C3E92AFAD8CE5C@otis.burlington.evertz.tv>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sandra Escandor <sescandor@evertz.com>
Cc: linux-ide@vger.kernel.org

On 07/12/2011 10:21 AM, Sandra Escandor wrote:
> The Situation:
> It appears that a WRITE FPDMA QUEUED failed command causes driver
> timeouts - this in turn locks up the RAID (which once worked pretty
> well). This occurred during high I/O.
>
> The question:
> 1. Is it a good idea to turn off NCQ? I've read in different posts that
> it helps some, but not others - I'm currently on the way to getting an
> experimental box setup, but I wanted to confirm if this was a good idea.

Not really a solution to anything, at least not likely in this case. 
More of a workaround that might happen to work by chance.

> 2. Are there known issues with the ICH10R + WD7500BPKT-00PK4T0 and the
> libata driver?

Nothing known, no.

>
> The System:
> Four WDC WD7500BPKT-00PK4T0 drives (Western Digital Scorpio) - in RAID10
> array created using mdadm 3.1.4
> ICH10R sata controller.
> Kernel 2.6.32-5-amd64

The fact that you have multiple drives and the problem tends to occur 
during heavy I/O may point to a power issue. This has been known to 
happen when some of the drives aren't getting enough power when there 
are spikes in power draw during I/O access. In this case, using a 
beefier power supply or spreading the drives out across different cables 
from the PSU may help.

