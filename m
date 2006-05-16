From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFT] major libata update
Date: Tue, 16 May 2006 18:02:29 -0400
Message-ID: <446A4BF5.7080006@garzik.org>
References: <20060515170006.GA29555@havoc.gtf.org> <4469B93E.6010201@emc.com> <4469E0DB.1040709@garzik.org> <4469EEC0.4060907@gmail.com> <446A1A21.80501@emc.com> <446A4721.3030506@emc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:29590 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750872AbWEPWCd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 May 2006 18:02:33 -0400
In-Reply-To: <446A4721.3030506@emc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ric@emc.com
Cc: Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Mark Lord <mlord@pobox.com>, Jens Axboe <axboe@suse.de>

Ric Wheeler wrote:
> 
> One other note, it seems like this patch set has broken the write 
> barrier support - is that a side effect of enabling NCQ still?
> 
> I see messages that claim flush barriers are enabled:
> 
> [root@c001n01 root]# mount -o 
> barrier=flush,rw,noatime,nodiratime,data=ordered,notail /dev/sda10 /mnt/1
> May 16 22:21:56 centera kernel: ReiserFS: sda10: found reiserfs format 
> "3.6" with standard journal
> [root@c001n01 root]# May 16 22:21:58 centera kernel: ReiserFS: sda10: 
> using ordered data mode
> May 16 22:21:58 centera kernel: reiserfs: using flush barriers
> May 16 22:21:58 centera kernel: ReiserFS: sda10: journal params: device 
> sda10, size 8192, journal first block 18, max trans len 1024, max batch 
> 900, max commit age 30, max trans age 30
> May 16 22:21:58 centera kernel: ReiserFS: sda10: checking transaction 
> log (sda10)
> May 16 22:21:58 centera kernel: ReiserFS: sda10: Using r5 hash to sort 
> names
> 
> But when I test with my synchronous write load, I am going at 6 times 
> the normal rate (i.e., the rate I see with barriers disabled) ;-)

Well, NCQ read/write commands have a 'FUA' bit...  though maybe the NCQ 
code forgot to check the global libata_fua.

	Jeff



