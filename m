From: "Andrew Hall" <andrew.a.hall@gmail.com>
Subject: RE: CF flash IDE failure to attach with 2.6.20+
Date: Fri, 22 Jun 2007 01:09:55 +1000
Message-ID: <467a94cf.43f0220a.3e19.3ceb@mx.google.com>
References: <11172839.post@talk.nabble.com>	<46766BD3.4040702@gmail.com> <20070618125742.28a0bc57@the-village.bc.nu> <46770edc.101d640a.4fdf.4eae@mx.google.com> <46776306.5030300@gmail.com> <4679cefc.06d7720a.0280.ffff9cce@mx.google.com> <4679EA43.4040002@gmail.com> <467a2692.17bb720a.5a14.ffffa80c@mx.google.com> <467A8F17.1080608@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:28093 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756128AbXFUPKL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 Jun 2007 11:10:11 -0400
Received: by py-out-1112.google.com with SMTP id a29so1026004pyi
        for <linux-ide@vger.kernel.org>; Thu, 21 Jun 2007 08:10:10 -0700 (PDT)
In-Reply-To: <467A8F17.1080608@rtr.ca>
Content-Language: en-au
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Mark Lord' <liml@rtr.ca>
Cc: 'Tejun Heo' <htejun@gmail.com>, 'Alan Cox' <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, 'Jeff Garzik' <jeff@garzik.org>

 
> I think Tejun would like you to patch the PCI ID for your ICH8
> into the "Old ATA/IDE PIIXn" driver, and then try that.

Maybe I'm a bit slow on the uptake, but how exactly do I do this "patch the
PCI ID into the driver"? I run a monolithic kernel will all these drivers
compiled in. None of them are found by the hardware except the newer libATA
driver (CONFIG_ATA_PIIX) for Intel ESB, ICH, PIIX3, PIIX4 PATA/SATA. If I
have removed each driver in turn and none of the others are detected. 

