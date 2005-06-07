From: Balazs Ree <ree@ree.hu>
Subject: Re: Samsung SP0822N does not go over UDMA 33 (2.6.11)
Date: Tue, 07 Jun 2005 23:07:02 +0200
Message-ID: <pan.2005.06.07.21.06.59.837074@ree.hu>
References: <pan.2005.06.03.13.18.36.818342@ree.hu> <pan.2005.06.06.08.12.11.7629@ree.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:14815 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261986AbVFGVSc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Jun 2005 17:18:32 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DflNS-0002oQ-OX
	for linux-ide@vger.kernel.org; Tue, 07 Jun 2005 23:12:50 +0200
Received: from 3e44aa8f.adsl.enternet.hu ([62.68.170.143])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 07 Jun 2005 23:12:50 +0200
Received: from ree by 3e44aa8f.adsl.enternet.hu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Tue, 07 Jun 2005 23:12:50 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I wrote earlier:
 
>> I have a new Samsung SP0822N. This is a 80G (P)ATA disk that is supposed
>> to support ATA133. It is connected to a SiI680 PCI controller. I am using
>> kernel 2.6.11.
>> 
>> But at bootup, the disk is identified as ATA33:
>> 
>> Jun  3 12:49:08 brumi kernel: hde: 156368016 sectors (80060 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(33)
>>
>>  Model=SAMSUNG SP0822N, FwRev=WA100-10, SerialNo=S06QJ10Y458485

I've found the solution! With CONFIG_IDEDMA_IVB set (IGNORE word93
Validation BITS) it gets the full ATA133 speed.

So the problem was yet the 80c ribbon detection. I was a bit confused
about this because previously I had thought from the documentations that
the boot option idex=ata66 would override this problem (but it did not do
so, and I wrongly supposed it must be something else than cable detection
then).

-- 
Bala'zs REE' jabber + email: ree@ree.hu
             ICQ: 75955071   AIM: reebalazs

