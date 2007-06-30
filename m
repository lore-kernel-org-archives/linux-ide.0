From: Justin Piszcz <jpiszcz@lucidpixels.com>
Subject: Re: device error via SDB FIS
Date: Sat, 30 Jun 2007 17:14:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0706301713370.12260@p34.internal.lan>
References: <46868E82.8010906@dschroeder.info> <Pine.LNX.4.64.0706301311150.2608@p34.internal.lan>
 <4686C733.1080102@dschroeder.info>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lucidpixels.com ([75.144.35.66]:37140 "EHLO lucidpixels.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752500AbXF3VOU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 30 Jun 2007 17:14:20 -0400
In-Reply-To: <4686C733.1080102@dschroeder.info>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Daniel Schroeder <sec@dschroeder.info>
Cc: linux-ide@vger.kernel.org



On Sat, 30 Jun 2007, Daniel Schroeder wrote:

> Justin Piszcz wrote:
>> Run smart tests yet?
>> 
>> 1. smartctl -d ata -t short /dev/sda
>> 2. smartctl -d ata -a /dev/sda (after  few min)
>> 
>> also replace short with long
>> 
>> and then paste the output:
>> 
>> smartctl -d ata -a /dev/sda
>> 
>
> <smartctl>
> smartctl -a -d ata /dev/sdc
>

Your stats look fine, there have been _A LOT_ of SATA driver changes
lately, I would try different kernels, up to the latest 2.6.22-rcX also
try the drive on a different chipset as well.

Justin.

