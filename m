From: Ric Wheeler <ric@emc.com>
Subject: Re: [PATCH] libata: reduce ATA command timeout to 7secs
Date: Sat, 03 Feb 2007 18:34:40 -0500
Message-ID: <45C51C10.3010801@emc.com>
References: <20070202063748.GC1625@htj.dyndns.org>	<45C33BCF.2040506@emc.com>	<45C354CF.1020500@gmail.com>	<20070202153929.33f4a806@localhost.localdomain>	<45C36338.60803@rtr.ca>	<311601c90702020843w16a67db8j5ead05f107161ec9@mail.gmail.com> <20070202184743.1516d1f9@localhost.localdomain>
Reply-To: ric@emc.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mexforward.lss.emc.com ([128.222.32.20]:39142 "EHLO
	mexforward.lss.emc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864AbXBCXet (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 3 Feb 2007 18:34:49 -0500
In-Reply-To: <20070202184743.1516d1f9@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: "Eric D. Mudama" <edmudama@gmail.com>, Mark Lord <liml@rtr.ca>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org



Alan wrote:
>> generic PC market, as opposed to "RAID edition" or "MaxLine" or
>> similar branding from other vendors, where the firmware may have been
>> specifically optimized for quicker command completion, quicker status
>> reporting and less exhaustive error recovery.  Many linux users I
> 
> Is there a way to detect RAID drives with this kind of timing, or does
> someone need to take a baseball bat into the standards committee meeting
> and add an identify field that gives command and "long command" timeouts
> in seconds ?

We figure it out by testing lots & lots of drives ;-)

> 
> If we can detect the "fast fail" drives (initially by say ident string
> components) lets do it and the people who care can buy the right product
> for the job.

I don't think that there is any kind of feature field...

> 
> Alan
> 
