From: Tejun Heo <htejun@gmail.com>
Subject: Re: CF flash PATA on libata failure to attach
Date: Mon, 02 Jul 2007 19:58:49 +0900
Message-ID: <4688DA69.60700@gmail.com>
References: <46815FF4.9040001@rtr.ca> <4681e04b.22b38c0a.78ec.6f76@mx.google.com> <46826F42.70405@rtr.ca> <4682f7a3.15538c0a.2e12.ffff8676@mx.google.com> <4683F1C9.2060505@rtr.ca> <468453f8.13578c0a.3c99.ffffa514@mx.google.com> <46845BEE.90801@rtr.ca> <46846b72.15588c0a.4c19.ffffeeb9@mx.google.com> <46846E3E.3010606@rtr.ca> <4684b61f.05358c0a.4c8f.30a5@mx.google.com> <20070629101733.GB25064@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.176]:7710 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771AbXGBLAJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jul 2007 07:00:09 -0400
Received: by py-out-1112.google.com with SMTP id u77so2545718pyb
        for <linux-ide@vger.kernel.org>; Mon, 02 Jul 2007 04:00:08 -0700 (PDT)
In-Reply-To: <20070629101733.GB25064@devserv.devel.redhat.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@redhat.com>
Cc: Andrew Hall <andrew.a.hall@gmail.com>, 'Mark Lord' <liml@rtr.ca>, linux-ide@vger.kernel.org

Alan Cox wrote:
> On Fri, Jun 29, 2007 at 05:34:36PM +1000, Andrew Hall wrote:
>> Further to this the PATA to SATA bridge being used in this case is:
>>
>> http://www.jmicron.com/JM20330.html
>>
>> ..as you will see only PIO and UDMA modes are supported.
> 
> In which case their microcontroller in the middle should be masking ident
> bits. Without a way to detect the presence of the device I don't see an
> easy way for us to handle it automatically at all

I'll ask JMicron about it.

-- 
tejun
