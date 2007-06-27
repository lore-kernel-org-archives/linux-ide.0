From: "Andrew Hall" <andrew.a.hall@gmail.com>
Subject: RE: CF flash PATA on libata failure to attach
Date: Thu, 28 Jun 2007 09:49:38 +1000
Message-ID: <4682f7a3.15538c0a.2e12.ffff8676@mx.google.com>
References: <11172839.post@talk.nabble.com>	<46766BD3.4040702@gmail.com> <20070618125742.28a0bc57@the-village.bc.nu> <46770edc.101d640a.4fdf.4eae@mx.google.com> <46776306.5030300@gmail.com> <4679cefc.06d7720a.0280.ffff9cce@mx.google.com> <4679EA43.4040002@gmail.com> <467a2692.17bb720a.5a14.ffffa80c@mx.google.com> <467A8F17.1080608@rtr.ca> <4680d387.24528c0a.3634.69bd@mx.google.com> <46815FF4.9040001@rtr.ca> <4681e04b.22b38c0a.78ec.6f76@mx.google.com> <46826F42.70405@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:17040 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753439AbXF0XuG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Jun 2007 19:50:06 -0400
Received: by py-out-1112.google.com with SMTP id u77so694817pyb
        for <linux-ide@vger.kernel.org>; Wed, 27 Jun 2007 16:50:06 -0700 (PDT)
In-Reply-To: <46826F42.70405@rtr.ca>
Content-Language: en-au
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Mark Lord' <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org

Hi Mark,

The device is a Nexcom NSA1083 appliance:

http://www.nexcom.com/product/productshow.jsp?iid=13&pid=878

It's an OEM appliance that uses the Intel 965 chipset. We use it as one of
three platforms for our access control and compliance products as it has 8
built in Ethernet ports and a dual core processor - with built in compact
flash. The older appliance that this new (1083) one is superseding also had
built in CF although this one apparently had separate PATA and SATA
controllers, whereas the 1083 has only one 4 channel ICH8 Intel SATA
controller which interfaces to one CF connector and one IDE connector via a
SATA to PATA bridge ( I don't know exactly what this bridge is or how it
interfaces to the SATA bus - but I can probably find this out from the
manufacturer). The CF is a standard 512MB Sandisk/Kingston chip that we boot
from and write configuration data to.

I appreciate your offer to look at this issue and depending on where you
are, we can probably ship you an appliance directly from Taiwan. The other
option possibly is to get you/someone remote access into one of these units
via the net, if that would help. The ridiculous thing is that we can boot
off the CF with no problems and the libata/piix driver goes some way to
recognizing that it's compact flash, so I believe the issue can't be too
difficult to resolve - I just need someone with a bit of knowledge on the
driver that can guide me through things to try or areas to look.
    
Many thanks,

> -----Original Message-----
> From: Mark Lord [mailto:liml@rtr.ca]
> Sent: Thursday, 28 June 2007 12:08 AM
> To: Andrew Hall
> Cc: linux-ide@vger.kernel.org; robert.de.rooy@gmail.com
> Subject: Re: CF flash PATA on libata failure to attach
> 
> Andrew Hall wrote:
> >> This looks a lot like the other CF-card problem that was being
> debugged
> >> here over the past week -- the one where POLLING had to be turned
> on.
> >> Robert de Rooy (copied) was the reporter for that one.
> >> Perhaps you two could compare notes ?
> 
> Do you have a spare device you can send me?
> 
> Or exactly what is this gizmo, anyway?
> (brand, model, form factor ...)
> 
> Thanks

