From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH] sata_nv: Don't attempt using ADMA for (READ|SET)_MAX
 commands
Date: Fri, 13 Apr 2007 16:52:38 -0600
Message-ID: <462009B6.4030406@shaw.ca>
References: <20070413170831.GC27674@athena.road.mcmartin.ca>
 <20070413181935.6d60f230@the-village.bc.nu> <461FC892.6020602@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:41041 "EHLO
	pd4mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965657AbXDMWxl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 13 Apr 2007 18:53:41 -0400
Received: from pd2mr6so.prod.shaw.ca (pd2mr6so-qfe3.prod.shaw.ca [10.0.141.9])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JGG009DCKW45500@l-daemon> for linux-ide@vger.kernel.org; Fri,
 13 Apr 2007 16:52:52 -0600 (MDT)
Received: from pn2ml10so.prod.shaw.ca ([10.0.121.80])
 by pd2mr6so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05 (built Sep
 5 2006)) with ESMTP id <0JGG00JVZKW3OIW0@pd2mr6so.prod.shaw.ca> for
 linux-ide@vger.kernel.org; Fri, 13 Apr 2007 16:52:52 -0600 (MDT)
Received: from [192.168.1.113] ([70.64.1.86])
 by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
 with ESMTP id <0JGG00K5GKW2A3Y1@l-daemon> for linux-ide@vger.kernel.org; Fri,
 13 Apr 2007 16:52:51 -0600 (MDT)
In-reply-to: <461FC892.6020602@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Kyle McMartin <kyle@canonical.com>, linux-ide@vger.kernel.org, jgarzik@pobox.com, bcollins@ubuntu.com

Mark Lord wrote:
> Alan Cox wrote:
>> On Fri, 13 Apr 2007 13:08:31 -0400
>> Kyle McMartin <kyle@canonical.com> wrote:
>>
>>> READ_NATIVE_MAX and SET_MAX were causing timeouts on sata_nv 
>>> controllers.
>>> Disabling ADMA helped, but that is quite a large hammer to use. 
>>> Reverting
>>> 382a6652e91b34d5480cfc0ed840c196650493d4 also helped, but we might as 
>>> well
>>> fix it right, instead of disabling the performance gain on cache flushes
>>> by using ADMA mode.
>>
>> Probably not going to make any performance difference to blacklist all
>> non-data commands or all but a few like cache-flush. 
> 
> I agree.  The Pacific Digital ADMA stuff had some quirks for various 
> non-data
> commands as well, and the sensible thing was to just not use ADMA for 
> anything
> other than READs/WRITEs and possible CACHE FLUSHes.

I'm told by NVidia that non-data commands should be fine in ADMA mode, 
except for those that require reading back a result taskfile (which 
can't be done in ADMA mode). The patch in libata-dev which I mentioned 
in another email will ensure that we don't try to use ADMA for such 
commands, so this patch should not be needed.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

