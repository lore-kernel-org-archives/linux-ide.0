From: Mark Lord <liml@rtr.ca>
Subject: Re: CF flash IDE failure to attach with 2.6.20+
Date: Thu, 21 Jun 2007 10:45:43 -0400
Message-ID: <467A8F17.1080608@rtr.ca>
References: <11172839.post@talk.nabble.com>	<46766BD3.4040702@gmail.com> <20070618125742.28a0bc57@the-village.bc.nu> <46770edc.101d640a.4fdf.4eae@mx.google.com> <46776306.5030300@gmail.com> <4679cefc.06d7720a.0280.ffff9cce@mx.google.com> <4679EA43.4040002@gmail.com> <467a2692.17bb720a.5a14.ffffa80c@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:4100 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753678AbXFUOpp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Jun 2007 10:45:45 -0400
In-Reply-To: <467a2692.17bb720a.5a14.ffffa80c@mx.google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Hall <andrew.a.hall@gmail.com>
Cc: 'Tejun Heo' <htejun@gmail.com>, 'Alan Cox' <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, 'Jeff Garzik' <jeff@garzik.org>

Andrew Hall wrote:
>> Does piix driver work?  If so, can you post boot dmesg and the result
>> of
>> 'hdparm -I /dev/hdX'?
> 
> Unfortunately it doesn't seem to be detected at all, although I'm not
> exactly sure which driver you're referring to. I have tried:
> 
> New ATA drivers: 
> Intel ESB, ICH, PIIX3, PIIX4 PATA/SATA support - is detected but fails
> Intel PATA MPIIX support - is not detected at all (which I think is right)
> Intel PATA old PIIX support (Experimental) - is not detected at all (which I
> think is wrong - it should be)
> 
> Old ATA/IDE driver:
> Intel PIIXn chipsets support - is not detected at all (which is right as the
> bus is SATA)

I think Tejun would like you to patch the PCI ID for your ICH8
into the "Old ATA/IDE PIIXn" driver, and then try that.

Cheers
