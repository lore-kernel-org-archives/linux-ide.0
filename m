From: "Andrew Hall" <andrew.a.hall@gmail.com>
Subject: RE: CF flash IDE failure to attach with 2.6.20+
Date: Thu, 21 Jun 2007 17:19:26 +1000
Message-ID: <467a2692.17bb720a.5a14.ffffa80c@mx.google.com>
References: <11172839.post@talk.nabble.com>	<46766BD3.4040702@gmail.com> <20070618125742.28a0bc57@the-village.bc.nu> <46770edc.101d640a.4fdf.4eae@mx.google.com> <46776306.5030300@gmail.com> <4679cefc.06d7720a.0280.ffff9cce@mx.google.com> <4679EA43.4040002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:32496 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752584AbXFUHTt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Jun 2007 03:19:49 -0400
Received: by wa-out-1112.google.com with SMTP id v27so213934wah
        for <linux-ide@vger.kernel.org>; Thu, 21 Jun 2007 00:19:49 -0700 (PDT)
In-Reply-To: <4679EA43.4040002@gmail.com>
Content-Language: en-au
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Tejun Heo' <htejun@gmail.com>
Cc: 'Alan Cox' <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, 'Jeff Garzik' <jeff@garzik.org>

> 
> Does piix driver work?  If so, can you post boot dmesg and the result
> of
> 'hdparm -I /dev/hdX'?

Unfortunately it doesn't seem to be detected at all, although I'm not
exactly sure which driver you're referring to. I have tried:

New ATA drivers: 
Intel ESB, ICH, PIIX3, PIIX4 PATA/SATA support - is detected but fails
Intel PATA MPIIX support - is not detected at all (which I think is right)
Intel PATA old PIIX support (Experimental) - is not detected at all (which I
think is wrong - it should be)

Old ATA/IDE driver:
Intel PIIXn chipsets support - is not detected at all (which is right as the
bus is SATA)

Thanks,


