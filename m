From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ata_piix: fix pio/mwdma programming (for testing, don't
 apply)
Date: Fri, 02 Feb 2007 22:04:00 +0300
Message-ID: <45C38B20.50102@ru.mvista.com>
References: <20070202151856.GD1625@htj.dyndns.org>	<45C359FC.2000601@ru.mvista.com>	<45C369C5.5000201@gmail.com> <20070202184928.4229f99a@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:1530 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1423055AbXBBTEH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Feb 2007 14:04:07 -0500
In-Reply-To: <20070202184928.4229f99a@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, ahaas@airmail.net, linux-ide@vger.kernel.org

Hello.

Alan wrote:

>>>   Actually, I think ata_timing_merge() should just be performed when
>>>setting MWDMA mode... This should be the right thing to do in most cases
>>>(however, this hardware has some complications in the form of only 2-bit
>>>wide active/recovery counts and 2 fast timing bank select bits)...

>>Yeap, that'll be nice.  Dunno whether modifying piix/ata_piix too much
>>would be a good idea tho considering the wide usage.

> If I remember rightly the 2bits is ok because you can set the bit to say
> that timings are for DMA only,

    Yeah, after thinking a bit more, the current logic seems good enough, i. 
e. it's better to slow down PIO to mode 0 than further slow down DMA to match 
the current PIO speed -- however, this is already happening with MWDMA1 which 
is actually faster than PIO3 (150 vs 180 ns).  But well, who cares... :-)

> the device then uses slower than PIO0 for all other cycles.

    Well, thankfully, compatible mode is PIO0 exactly (except for taskfile 
accesses which are way slower indeed).

>>In both mwdma and pio cases, they're just turning off UDMA.  Don't know
>>whether it's actually necessary but still afraid to change it unless
>>there is a good reason.

> The tuning manual I have does it, so I do it 8)

    Do you mean 29860004.pdf?  Actually, I'm not seeing anything alike here.
It would've been stupid idea to couple UDMA to PIO but well... after looking 
at the HighPoint datasheets, one becomes hard to surprise. :-)

> Alan

    Well, after looking at do_pata_set_dmamode(), I have another question:
why IORDY enable is forced here?  It has *nothing* to do with the IDE DMA 
protocol. (This also seems to be an issue with piix.c...)

MBR, Sergei
