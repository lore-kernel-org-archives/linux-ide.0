From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Nvidia cable detection problems (was [PATCH] amd74xx: don't configure
 udma mode higher than BIOS did)
Date: Mon, 05 Feb 2007 16:43:24 -0500
Message-ID: <45C7A4FC.6040501@garzik.org>
References: <20070205075836.GG1625@htj.dyndns.org>	<20070205112410.5a3c3182@localhost.localdomain>	<45C72012.7050605@gmail.com>	<20070205132247.6f611e3c@localhost.localdomain>	<45C73A3E.6080700@gmail.com>	<20070205143439.6962c076@localhost.localdomain>	<45C7444F.4070500@gmail.com>	<58cb370e0702050709w1b7682dr5dff9e7ce69465a@mail.gmail.com>	<DBFABB80F7FD3143A911F9E6CFD477B01EC0DD7D@hqemmail02.nvidia.com>	<20070205181224.3319d6c3@localhost.localdomain>	<45C77921.4020808@gmail.com> <20070205191318.39f84ced@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45835 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933484AbXBEVnb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Feb 2007 16:43:31 -0500
In-Reply-To: <20070205191318.39f84ced@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, Allen Martin <AMartin@nvidia.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>

Alan wrote:
>>> Well we can certainly do some of that if ACPI is present and active. In
>>> particular since _GTM will give us current modes allowing for hotplug and
>>> post BIOS boot kexec etc it ought to be safe to do Tejun's hack that way.
>>> We could even probe UDMA3+ capable devices by doing _STM to a high mode
>>> and _GTM to determine the cable type 8)
>> Glad to see the problem getting solved.  Now that we know the solution,
>> any volunteers?  :-)
> 
> I am currently putting together an experimental pata_acpi driver to play
> with this stuff. May take a bit of time while I work out the current acpi
> interface gunge and how to expand it.
> 
> The fact we have to try each mode to see what we can set doesn't make it
> pretty either!

Make sure you take a look at libata-dev.git#acpi which is the origin of 
the libata ACPI support found in -mm

That's pending for an upstream merge.

	Jeff



