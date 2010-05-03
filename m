From: Graeme Russ <graeme.russ@gmail.com>
Subject: Re: Using PATA Platform Driver to access Memory Mapped CF Card
Date: Mon, 03 May 2010 11:39:21 +1000
Message-ID: <4BDE2949.6030301@gmail.com>
References: <4BDAE529.20903@gmail.com>	<201005010524.40949.marek.vasut@gmail.com>	<4BDBD4AB.8020200@gmail.com>	<20100501113346.29225519@lxorguk.ukuu.org.uk>	<4BDD6897.7000002@gmail.com> <20100502132913.1e531bfd@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:49082 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752403Ab0ECBj3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 May 2010 21:39:29 -0400
Received: by gwj19 with SMTP id 19so924106gwj.19
        for <linux-ide@vger.kernel.org>; Sun, 02 May 2010 18:39:27 -0700 (PDT)
In-Reply-To: <20100502132913.1e531bfd@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Alan Cox wrote:
>> pata_platform_port_ops (.sff_data_xfer = ata_sff_data_xfer_noirq). So I
>> will need to create custom data_xfer_noirq and data_xfer functions for the
>> 8-bit transfers. Is there an elegant way to override pata_platform's use of
>> ata_sff_data_xfer_noirq or will I need to also write a new version of
>> pata_platform as well?
> 
> Extending pata_platform_info is probably the right thing to do - and
> allow it to override the data_xfer operation if a new data_xfer field is
> non NULL. See include/linux/ata_platform.h.
> 
> So you'll need to tweak pata_platform a spot. Alternatively you could
> write a small libata driver specifically for your device - which may make
> sense if it supports higher speed modes and speed setting stuff.
> 

Thanks Alan,

I've added a data_xfer member to pata_platform_info and added the following
just prior to the call to __pata_platform_probe()

	if (pp_info)
		if (unlikely(pp_info->data_xfer))
			pata_platform_port_ops.sff_data_xfer = pp_info->data_xfer;

and implemented an 8-bit version of ata_sff_data_xfer() in my board
specific code. Should I submit a patch (or is this considered too esoteric
for mainline?)

I now have another problem - My board has two CF slots (one at base address
0x20000000 and one at base address 0x20001000. I would like to be able to
access them both, but if I try to init two pata_platform devices I get:

sysfs: cannot create duplicate filename '/devices/platform/pata_platform'

and

kobject_add_internal failed for pata_platform with -EEXIST, don't try to
register things with the same name in the same directory

Is it possible to register two devices using the pata platform driver?

Regards,

Graeme
