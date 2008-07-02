From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes] sata_sil24: add DIDs for adaptec flavors
Date: Wed, 02 Jul 2008 17:47:48 +0900
Message-ID: <486B40B4.30708@kernel.org>
References: <486AED59.7020606@kernel.org> <20080702085517.61909c74@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41414 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762504AbYGBIyD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Jul 2008 04:54:03 -0400
In-Reply-To: <20080702085517.61909c74@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Travis Read <ics@dark.net.au>

Alan Cox wrote:
> On Wed, 02 Jul 2008 11:52:09 +0900
> Tejun Heo <tj@kernel.org> wrote:
> 
>> Adaptec uses different DIDs for 3132.  Add them.
>>
>> Reported by Travis Read.
>>
>> Signed-off-by: Tejun Heo <tj@kernel.org>
>> Cc: Travis Read <ics@dark.net.au>
> 
> NAK
> 
>>  	{ PCI_VDEVICE(CMD, 0x0242), BID_SIL3132 },
>>  	{ PCI_VDEVICE(CMD, 0x3131), BID_SIL3131 },
>>  	{ PCI_VDEVICE(CMD, 0x3531), BID_SIL3131 },
>> +	{ PCI_VDEVICE(CMD, 0x0242), BID_SIL3132 },
>> +	{ PCI_VDEVICE(CMD, 0x0244), BID_SIL3132 },
> 
> The first of those is a duplicate (see the top entry)

Heh.. yeah.  What was I thinking.  Thanks for spotting it.

-- 
tejun
