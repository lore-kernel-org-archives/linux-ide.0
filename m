From: Tejun Heo <htejun@gmail.com>
Subject: Re: [git patches] libata fixes
Date: Sun, 18 Mar 2007 04:42:19 +0900
Message-ID: <45FC449B.2090100@gmail.com>
References: <00a701c768bd$f8abe130$2101a8c0@donald>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.236]:20055 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753824AbXCQTmZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 Mar 2007 15:42:25 -0400
Received: by nz-out-0506.google.com with SMTP id s1so415434nze
        for <linux-ide@vger.kernel.org>; Sat, 17 Mar 2007 12:42:24 -0700 (PDT)
In-Reply-To: <00a701c768bd$f8abe130$2101a8c0@donald>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: rol@as2917.net
Cc: 'Linus Torvalds' <torvalds@linux-foundation.org>, 'Jeff Garzik' <jeff@garzik.org>, 'Alan Cox' <alan@redhat.com>, 'Andrew Morton' <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, 'LKML' <linux-kernel@vger.kernel.org>, "'Eric D. Mudama'" <edmudama@gmail.com>

Paul Rolland wrote:
> Hello,
> 
> I'm preparing to attach a disk. 
> In the meantime, I've rebuild a 2.6.21-rc4, and got that while booting :
> ...
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata1.00: ATA-7: Maxtor 6L250S0, BANC1G10, max UDMA/133
> ata1.00: 490234752 sectors, multi 0: LBA48 NCQ (depth 31/32)
> ata1.00: configured for UDMA/133
> ...
> Adding 2096436k swap on /dev/sde5.  Priority:-1 extents:1 across:2096436k
> Adding 4192956k swap on /dev/sda3.  Priority:-2 extents:1 across:4192956k
> ata1.00: exception Emask 0x2 SAct 0x7fffffc3 SErr 0x0 action 0x2 frozen
> ata1.00: (spurious completions during NCQ issue=0x0 SAct=0x7fffffc3
> FIS=004040a1:00000020)
> ata1.00: cmd 60/01:00:52:eb:ff/00:00:09:00:00/40 tag 0 cdb 0x0 data 512 in
>          res 40/00:08:53:eb:ff/00:00:09:00:00/40 Emask 0x2 (HSM violation)

If you leave it alone, does libata turn off NCQ and boot continues?

-- 
tejun
