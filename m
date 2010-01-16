From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: SATA_SIL on IXP425 workaround
Date: Fri, 15 Jan 2010 23:03:27 -0600
Message-ID: <4B51489F.8010105@gmail.com>
References: <m33a4nfvva.fsf@intrepid.localdomain>	<201001141659.19687.bzolnier@gmail.com>	<20100114192210.62593ead@lxorguk.ukuu.org.uk>	<m3my0gh2dc.fsf@intrepid.localdomain> <20100114210515.7a477a43@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:44164 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725Ab0APFDa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Jan 2010 00:03:30 -0500
In-Reply-To: <20100114210515.7a477a43@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

On 01/14/2010 03:05 PM, Alan Cox wrote:
>> We need to use the MMIO BAR at least for starting DMA transfers, the
>> I/O ones are 64KB-limited. We can't just use read[bw] if reading all
>> 32 bits has side effects.
>
> Last time I instrumented this on x86 we never issued a>  64K linear block
> in our s/g lists. In fact we went for years before anyone noticed we had
> a bug with CS5530 and a couple of other chips that mishandled 64K segment
> sizes, and that was only finally noticed in a very specific and weird
> circumstance.

Having a block over 64KB may be rare, but the other thing that the large 
block transfer feature does is remove the restriction on a block 
crossing a 64KB boundary, which based on the experiments I did when I 
worked on adding the feature, does happen fairly commonly if the driver 
allows it.
