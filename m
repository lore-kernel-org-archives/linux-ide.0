From: Tejun Heo <tj@kernel.org>
Subject: Re: Ubuntu 9.04 (2.6.28-14) and eSATA Port Multiplier (PMP) Not
 working
Date: Thu, 27 Aug 2009 14:53:36 +0900
Message-ID: <4A961F60.8080400@kernel.org>
References: <e3fccfde0908101354y4e98a985nc119d8941e8b1665@mail.gmail.com>	 <4A8242C5.3060605@gmail.com>	 <e3fccfde0908121536wbacde3bt447c3b8e769f184d@mail.gmail.com>	 <da824cf30908171425i3ec9237bi1370e71d5096c174@mail.gmail.com>	 <e3fccfde0908171530w43f78711lea85ffa1ea26d2ea@mail.gmail.com>	 <da824cf30908171939o7110322bn993dc5d3217a4cfa@mail.gmail.com>	 <e3fccfde0908181454w3e45ef65ucf2b5173d97d10eb@mail.gmail.com> <da824cf30908251528h25c2dffcp9943abd4af85cb52@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:48192 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750747AbZH0Fxl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 Aug 2009 01:53:41 -0400
In-Reply-To: <da824cf30908251528h25c2dffcp9943abd4af85cb52@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: Chris K <kayex@rogers.com>, Linux IDE <linux-ide@vger.kernel.org>

Hello,

Grant Grundler wrote:
>> [59719.989422] ata7: irq_stat 0x01100010, PHY RDY changed
>> [59719.989477] ata7: SError: { 10B8B }
>> [59722.781043] ata7: exception Emask 0x10 SAct 0x0 SErr 0x0 action 0xe frozen
>> [59722.781112] ata7: irq_stat 0x00b40090, PHY RDY changed
>> [59791.300259] ata7.15: failed to write PMP_FEAT_EN (Emask=0x40)
>> [59791.300324] ata7: failed to recover PMP after 5 tries, giving up
>> [59791.300323] ata7: exception Emask 0x3 SAct 0x0 SErr 0x0 action 0x6 frozen t4
>> [59791.300483] ata7: irq_stat 0x00060002, device error via D2H FIS
> 
> The "6 ports" is the clue I was looking for.
> 
> [    7.080266] ata7.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6
> ports, feat 0x1/0x9
> [    7.080531] ata7.00: hard resetting link
> [    7.430307] ata7.00: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
> [    7.430311] ata7.01: hard resetting link
> [    7.780305] ata7.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [    7.780309] ata7.02: hard resetting link
> [    8.130305] ata7.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [    8.130310] ata7.03: hard resetting link
> [    8.480305] ata7.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> [    8.480310] ata7.04: hard resetting link
> [    8.830317] ata7.04: SATA link down (SStatus 0 SControl 320)
> [    8.830321] ata7.05: hard resetting link
> [    9.180232] ata7.05: failed to read SCR 1 (Emask=0x1)
> [    9.180233] ata7.05: failed to read SCR 0 (Emask=0x40)
> 
> I don't believe port ata7.05 exists. AFAIK,  sil3736 only has 5 ports (0 to 4).
> One of the quirks isn't applying or needs to be added to the kernel.
> I don't recall what the psuedo port is for but Tejun or "Sans Digital
> TRM4-B" vendor might know.
> 
> I think this comment in libata-pmp.c might be relevant:
>      /* port 5 is for SEMB device and it doesn't like SRST */
> 
> But it looks like port 5 isn't responding at all. You might add a hack to change
> "6" to "5" inside the "sil3726 quirks" code chunk.

Ah... right, it's the SEMB port which is causing the problem.  I left
it there just in case someone would extend on it and make it useful,
which never really happened and given the general flakiness of this
first generation PMPs, I think we would be better off simply disabling
these SEMB and configuration devices altogether.  Any objections?

Thanks.

-- 
tejun
