From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: maintenence sata_sis
Date: Mon, 22 Aug 2005 12:01:12 +0200
Message-ID: <4309A268.8090203@gmx.net>
References: <m31x4pkhjb.fsf@anduin.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zeus1.kernel.org ([204.152.191.4]:63367 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751351AbVHVWSo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Aug 2005 18:18:44 -0400
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by zeus1.kernel.org (8.13.1/8.13.1) with SMTP id j7MA2Mfq032260
	for <linux-ide@vger.kernel.org>; Mon, 22 Aug 2005 03:02:23 -0700
In-Reply-To: <m31x4pkhjb.fsf@anduin.mandrakesoft.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Arnaud Patard <apatard@mandriva.com>, Rainer.Koenig@fujitsu-siemens.com

Hello Jeff,

currently it exists 3 variants to support the SiS182 Chipset
- use SiS182 with the code from SiS180, only add the PCI-ID to the driver
- the source code from OSDL
- the source code from www.sis.com
Actually i have no SiS board available. So i have no chance to maintain
the driver.

regards
Uwe Koziolek



Arnaud Patard wrote:

>Hi,
>
>
>I got recently a motherboard shipped with the SATA SIS 182 chipset. This
>chipset is not supported by the kernel. I tried to just add the PCI IDS
>in the supported chipset list as suggested on some mails in this
>list but it didn't work for the hard drive connected on the second sata port.
>
>I found that this has been reported on
>http://bugme.osdl.org/show_bug.cgi?id=4192. Unfortunately the patch
>didn't apply to the recents kernel. So, I've written a new minimal patch that
>add support for this chipset. 
>
>It works well on the machine I have with a 2.6.12.5 kernel but I was not
>able to test it on SIS 180/181 chipset (I don't have the hardware). 
>
>imho having support for this chipset in the kernel could be usefull, so
>any feedback/comments are welcome. 
>
>Regards,
>Arnaud Patard
>
>  
>

