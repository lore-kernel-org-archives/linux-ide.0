From: Jeff Garzik <jgarzik@pobox.com>
Subject: FUA and 311x (was Re: LibPATA code issues / 2.6.15.4)
Date: Wed, 01 Mar 2006 20:56:12 -0500
Message-ID: <440650BC.5090501@pobox.com>
References: <1141239617.23202.5.camel@rousalka.dyndns.org>	 <4405F471.8000602@rtr.ca>	 <1141254762.11543.10.camel@rousalka.dyndns.org> <311601c90603011719k43af0fbbg889f47d798e22839@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:20116 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751124AbWCBB4U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Mar 2006 20:56:20 -0500
In-Reply-To: <311601c90603011719k43af0fbbg889f47d798e22839@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Eric D. Mudama" <edmudama@gmail.com>, Tejun Heo <htejun@gmail.com>
Cc: Nicolas Mailhot <nicolas.mailhot@gmail.com>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Carlos Pardo <Carlos.Pardo@siliconimage.com>

Eric D. Mudama wrote:
> I didn't know offhand so we plugged in a bus analzyer and took a look
> here in the lab... We didn't have a 3114 lying around, but issuing the
> Write DMA FUA (0x3D) opcode on a 3112 resulted in a D0h soft hang.  I
> think they're related (4-port vs 2-port).

Looking at the public docs posted at 
http://gkernel.sourceforge.net/specs/sii/ ...  FUA is not in the list of 
supported opcodes (Table 10-1).

The 311x does have a facility that allows the driver to specify the 
command protocol associated with an unknown-to-the-chip opcode.  Someone 
sufficiently interested could investigate using the VS Unlock and VS Set 
Command Protocol commands to patch in support (section 10.4.*).

For libata, I think an ATA_FLAG_NO_FUA would be appropriate for 
situations like this...  assume FUA is supported in the controller, and 
set a flag where it is not.  Most chips will support FUA, either by 
design or by sheer luck.  The ones that do not support FUA are the 
controllers that snoop the ATA command opcode, and internally choose the 
protocol based on that opcode.  For such hardware, unknown opcodes will 
inevitably cause problems.

	Jeff


