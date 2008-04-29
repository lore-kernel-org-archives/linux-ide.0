From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] ata: Add Intel SCH PATA support
Date: Tue, 29 Apr 2008 21:22:59 +0400
Message-ID: <48175973.7050307@ru.mvista.com>
References: <20080426140007.63cfeede@dxy.sh.intel.com>	<20080426103012.21dcf0fb@core>	<20080427075115.3ea40204@dxy.sh.intel.com>	<20080427093434.182a2137@core>	<20080427220315.794a6df3@dxy.sh.intel.com>	<20080427153111.3438dce8@core> <20080428092056.1e710a45@dxy.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:22924 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1760237AbYD2RXj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Apr 2008 13:23:39 -0400
In-Reply-To: <20080428092056.1e710a45@dxy.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alek Du <alek.du@intel.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, jgarzik@pobox.com

Alek Du wrote:

>>Re: [PATCH] ata: Add Intel SCH PATA support

>>On Sun, 27 Apr 2008 22:03:15 +0800
>>Alek Du <alek.du@intel.com> wrote:

>>>Alan,

>>>One problem I still do not understand, if I return PATA_UNK for cable detection result, could the
>>>driver finally set the disk to UDMA5 mode if I plug in 80 wire disk?

>>You tell me - you've got the hardware documentation I assume. Assuming the
>>system implements detection then it should. If a PATA controller doesn't
>>implement any detection (cable or host side) and it does UDMA5 then I
>>believe the correct description for it is usually "broken" as people will
>>have horrible problems trying to use things like flash drives with it.

>>Alan
> 
> 
> The data sheet of SCH (http://download.intel.com/design/chipsets/embedded/datashts/319537.pdf) page 347 shows
> the only supported PATA registers, for those not shown should be treated as "Reserved". 
> Unfortunately, IOCFG (0x54) and port enable bits (0x41, 0x43) are all reserved.

    If you'd actually compared the datasheet to the driver and/or the PIIX/ICH 
datasheets, you would have seen that SCH is not compatible to PIIX/ICH. It 
doesn't have PIO/DMA and UDMA timing and UDMA enable registers at config. 
space offsets 0x4x but instead has pair of drive timing registers (SCH PATA 
controller is single-channel) controlling PIO/DMA/UDMA speeds each at 0x8x, 
laid out completely differently: PIIX/ICH timing registers fields encoded 
cycle counts which SCH registers fileds encode mode numbers themselves.

> Let's regard SCH PATA controller is an usually "broken" one :-), what do you suggest me to work around it?

    Let's regard it as the one deserving its own driver. ;-)

> Thanks,
> Alek

MBR, Sergei
