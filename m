From: Balazs Ree <ree@ree.hu>
Subject: Re: Samsung SP0822N does not go over UDMA 33 (2.6.11)
Date: Mon, 06 Jun 2005 10:12:18 +0200
Message-ID: <pan.2005.06.06.08.12.11.7629@ree.hu>
References: <pan.2005.06.03.13.18.36.818342@ree.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:24271 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261219AbVFFIRo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Jun 2005 04:17:44 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DfCiz-000061-7X
	for linux-ide@vger.kernel.org; Mon, 06 Jun 2005 10:12:45 +0200
Received: from 3e44aa8f.adsl.enternet.hu ([62.68.170.143])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 06 Jun 2005 10:12:45 +0200
Received: from ree by 3e44aa8f.adsl.enternet.hu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 06 Jun 2005 10:12:45 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


I posted this earlier:

> I have a new Samsung SP0822N. This is a 80G (P)ATA disk that is supposed
> to support ATA133. It is connected to a SiI680 PCI controller. I am using
> kernel 2.6.11.
> 
> But at bootup, the disk is identified as ATA33:
> 
> Jun  3 12:49:08 brumi kernel: hde: 156368016 sectors (80060 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(33)
>
>  Model=SAMSUNG SP0822N, FwRev=WA100-10, SerialNo=S06QJ10Y458485

As I've received no reply for this help request, I can assume that no one
uses this particular model of Samsung. Perhaps it is a new model...? This
means I am on my own.

I would be willing to find out why this happens, but someone could
please give me a helping hand? It would be great if you could point me to
the exact location of the ide code where the limitation to udma2 is made,
this would save me an enormous amount of time. Then I guess I would make
the code a bit more verbose and figure out something. You can also contact
me directly about this.

Thank you very much in advance, any help is highly appreciated.

-- 
Bala'zs REE' jabber + email: ree@ree.hu
             ICQ: 75955071   AIM: reebalazs


