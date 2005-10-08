From: Fabian Knittel <fabian.knittel@avona.com>
Subject: Re: Problems with Promise SATAII TX4
Date: Sat, 08 Oct 2005 15:12:01 +0200
Message-ID: <4347C5A1.1020504@avona.com>
References: <20050330001007.GA16954@cebitec.uni-bielefeld.de> <430404A5.7060000@avona.com> <430B1D5E.9070201@avona.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.lenk.info ([217.160.183.176]:25779 "EHLO mail.lenk.info")
	by vger.kernel.org with ESMTP id S932112AbVJHNMY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Oct 2005 09:12:24 -0400
Received: from smtp.lenk.info ([82.165.24.235] ident=Debian-exim)
	by mail.lenk.info with esmtpsa
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.50 1)
	id 1EOEVV-0000Jy-Rv
	for <linux-ide@vger.kernel.org>; Sat, 08 Oct 2005 15:12:57 +0200
Received: from p54a34f4d.dip.t-dialin.net ([84.163.79.77] helo=am-nb01.am.local)
	by smtp.lenk.info with esmtpsa
	(Cipher TLS-1.0:DHE_RSA_3DES_EDE_CBC_SHA:24) (Exim 4.50 1)
	id 1EOEVW-00037u-7p
	for <linux-ide@vger.kernel.org>; Sat, 08 Oct 2005 15:12:58 +0200
Received: from [127.0.0.1] (helo=[127.0.0.1])
	by am-nb01.am.local with esmtp (Exim 3.35 #1 (Debian))
	id 1EOEUd-0000xz-00
	for <linux-ide@vger.kernel.org>; Sat, 08 Oct 2005 15:12:03 +0200
In-Reply-To: <430B1D5E.9070201@avona.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi again,

to follow up on myself again and just for the record, the problems
("nobody cared, disabling" interrupt errors while accessing several
drives simultaneously on the same Promise SATAII TX4 controller)
disappeared after hanging all drives on a seperate power supply unit. So
now I'm happily running with a 430W PSU powering the system and a ~200W
PSU powering the 4 drives.

I'm not sure why the system needs more than 430W, but with the new
setup, I can read from 4 drives at once without any problems. Before
this box was converted into a server we probably never tried to access
several drives simultaneously, so I can't really blame anything in specific.

So, my thanks primarily go to Andrey Melnikoff for the right hint (in
private mail). Thanks a lot!

Fabian

For reference, this is what I wrote some time ago:
> I wrote:
>>I'm experiencing problems with my Promise SATAII TX4 controller, quite
>>similar to what Kim reported a few months ago.
>>
>>Using a fresh linux-2.6.12.5 upstream kernel to boot into a rescue shell
>>(so there's no distribution specific stuff going on, nothing else
>>loaded, etc.), I can access my three connected Maxtor 120GB drives just
>>fine, as long as I do so individually.
> 
> [...]
> 
>>>Attached devices:
>>>Host: scsi0 Channel: 00 Id: 00 Lun: 00
>>> Vendor: ATA      Model: Maxtor 6Y120M0   Rev: YAR5
>>> Type:   Direct-Access                    ANSI SCSI revision: 05
>>>Host: scsi1 Channel: 00 Id: 00 Lun: 00
>>> Vendor: ATA      Model: Maxtor 6Y120M0   Rev: YAR5
>>> Type:   Direct-Access                    ANSI SCSI revision: 05
>>>Host: scsi3 Channel: 00 Id: 00 Lun: 00
>>> Vendor: ATA      Model: Maxtor 6Y120M0   Rev: YAR5
>>> Type:   Direct-Access                    ANSI SCSI revision: 05
> 
> 
> OK, apparently it's somewhat hardware related after all. I've added a
> Seagate drive (Model: ST3120827AS, Rev: 3.42) and reading from this
> drive together with two of the Maxtor drives (any two of the three)
> currently works without problems (for now).
> 
> Switching ports and cables doesn't change anything, so it's not related
> to that.
> 
> But how can that be? The individual drives don't reveal any problems and
> (as reported in my previous mail) the drives worked seamlessly for a few
> weeks ...
> 
> I'll have to do some more testing and this is probably off-topic by now,
> so I'll stop with the noise now.
