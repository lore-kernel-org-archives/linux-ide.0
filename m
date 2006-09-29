From: Jeff Garzik <jeff@garzik.org>
Subject: Re: SATA status reports update
Date: Fri, 29 Sep 2006 06:03:58 -0400
Message-ID: <451CEF8E.2050601@garzik.org>
References: <451CE8EC.1020203@garzik.org> <200609291149.37009.prakash@punnoor.de> <451CED23.1090909@garzik.org> <200609291200.56308.prakash@punnoor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:7842 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932080AbWI2KEA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Sep 2006 06:04:00 -0400
In-Reply-To: <200609291200.56308.prakash@punnoor.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Prakash Punnoor <prakash@punnoor.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Prakash Punnoor wrote:
> Well, how would one debug it w/o hw docs? Or is it possible to compare the 
> patch with a working driver for another chipset?

Well, it is based off of the standard ADMA[1] specification, albeit with 
modifications.  There is pdc_adma.c, which is also based off ADMA.  And 
the author (from NVIDIA) claims that the driver worked at one time, so 
maybe it is simply bit rot that broke the driver.

If I knew the answer, it would be fixed, so the best answer 
unfortunately is "who knows".

I wish I had the time.  But I also wish I had a team of programmers 
working on libata, too ;-)

	Jeff


