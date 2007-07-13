From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH 1/3] Make the IDE DMA timeout modifiable
Date: Fri, 13 Jul 2007 16:54:55 -0400
Message-ID: <4697E69F.4030509@rtr.ca>
References: <20070221011922.GA1777@freefall.freebsd.org>	<200702210342.20775.bzolnier@gmail.com>	<466EEFD6.9030001@ru.mvista.com>	<200706160123.55636.bzolnier@gmail.com>	<4693D9B6.4090408@ru.mvista.com> <20070713161612.2f2ebb0b@the-village.bc.nu> <46979652.6040201@rtr.ca> <4697987E.3040406@ru.mvista.com> <4697D425.7000300@rtr.ca> <4697DBB2.7020507@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:2072 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756265AbXGMUy4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 13 Jul 2007 16:54:56 -0400
In-Reply-To: <4697DBB2.7020507@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Suleiman Souhlal <ssouhlal@freebsd.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Sergei Shtylyov wrote:
> Mark Lord wrote:
..
>> When a drive is in standby, we don't send it anything special to wake up.
> 
>    Wait, aren't we sending IDLE on resume step 2 -- looking at 
> ide-io.cide_start_power_step()?

Sure, for RESUME.

But now for a drive that just happens to have put itself into standby
due to expiration of the standby timer (hdparm -S).

Cheers
