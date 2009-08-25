From: Mark Lord <liml@rtr.ca>
Subject: Re: Ubuntu 9.04 (2.6.28-14) and eSATA Port Multiplier (PMP) Not
 working
Date: Tue, 25 Aug 2009 19:09:16 -0400
Message-ID: <4A946F1C.60508@rtr.ca>
References: <e3fccfde0908101354y4e98a985nc119d8941e8b1665@mail.gmail.com>	 <4A8242C5.3060605@gmail.com>	 <e3fccfde0908121536wbacde3bt447c3b8e769f184d@mail.gmail.com>	 <da824cf30908171425i3ec9237bi1370e71d5096c174@mail.gmail.com>	 <e3fccfde0908171530w43f78711lea85ffa1ea26d2ea@mail.gmail.com>	 <da824cf30908171939o7110322bn993dc5d3217a4cfa@mail.gmail.com>	 <e3fccfde0908181454w3e45ef65ucf2b5173d97d10eb@mail.gmail.com> <da824cf30908251528h25c2dffcp9943abd4af85cb52@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:47780 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932160AbZHYXJK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 Aug 2009 19:09:10 -0400
In-Reply-To: <da824cf30908251528h25c2dffcp9943abd4af85cb52@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: Chris K <kayex@rogers.com>, Linux IDE <linux-ide@vger.kernel.org>

Grant Grundler wrote:
>
> I don't believe port ata7.05 exists. AFAIK,  sil3736 only has 5 ports (0 to 4).
> One of the quirks isn't applying or needs to be added to the kernel.
> I don't recall what the psuedo port is for but Tejun or "Sans Digital
> TRM4-B" vendor might know.
..

The "extra" phantom port is usually for SEMB (enclosure management).

Cheers
