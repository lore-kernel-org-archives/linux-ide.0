From: "Andrew Hall" <andrew.a.hall@gmail.com>
Subject: RE: CF flash PATA on libata failure to attach
Date: Fri, 29 Jun 2007 17:34:36 +1000
Message-ID: <4684b61f.05358c0a.4c8f.30a5@mx.google.com>
References: <11172839.post@talk.nabble.com>	<46766BD3.4040702@gmail.com> <20070618125742.28a0bc57@the-village.bc.nu> <46770edc.101d640a.4fdf.4eae@mx.google.com> <46776306.5030300@gmail.com> <4679cefc.06d7720a.0280.ffff9cce@mx.google.com> <4679EA43.4040002@gmail.com> <467a2692.17bb720a.5a14.ffffa80c@mx.google.com> <467A8F17.1080608@rtr.ca> <4680d387.24528c0a.3634.69bd@mx.google.com> <46815FF4.9040001@rtr.ca> <4681e04b.22b38c0a.78ec.6f76@mx.google.com> <46826F42.70405@rtr.ca> <4682f7a3.15538c0a.2e12.ffff8676@mx.google.com> <4683F1C9.2060505@rtr.ca> <468453f8.13578c0a.3c99.ffffa514@mx.google.com> <46845BEE.90801@rtr.ca> <46846b72.15588c0a.4c19.ffffeeb9@mx.google.com> <46846E3E.3010606@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.177]:65416 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011AbXF2He7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Jun 2007 03:34:59 -0400
Received: by py-out-1112.google.com with SMTP id u77so1110596pyb
        for <linux-ide@vger.kernel.org>; Fri, 29 Jun 2007 00:34:59 -0700 (PDT)
In-Reply-To: <46846E3E.3010606@rtr.ca>
Content-Language: en-au
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: 'Mark Lord' <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org, 'Tejun Heo' <htejun@gmail.com>, 'Alan Cox' <alan@redhat.com>

> 
> Per my other email -- did you try the legacy IDE driver
> instead of libata?  Can you provide a boot log from that for Tejun?

Further to this the PATA to SATA bridge being used in this case is:

http://www.jmicron.com/JM20330.html

..as you will see only PIO and UDMA modes are supported.

