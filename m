From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 1/1] pata_it821x: fix lost interrupt with atapi devices
Date: Mon, 17 Sep 2007 07:00:03 +0200
Message-ID: <46EE09D3.9010201@gmail.com>
References: <200709041607.l84G7KsT032647@norden.math.tntech.edu>	<18141.42848.537873.349518@alkaid.it.uu.se> <20070906013929.1621849d@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:55894 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558AbXIQI07 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Sep 2007 04:26:59 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1953884wah
        for <linux-ide@vger.kernel.org>; Mon, 17 Sep 2007 01:26:58 -0700 (PDT)
In-Reply-To: <20070906013929.1621849d@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mikael Pettersson <mikpe@it.uu.se>, Jeff Norden <jeff@math.tntech.edu>, alan@redhat.com, linux-kernel@vger.kernel.org, Albert CC Lee <albertcc@tw.ibm.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

[cc'ing Albert and linux-ide]

Alan Cox wrote:
> /from the media. */
>>  > +	if (qc->nbytes < 2048)
>>  > +		return -EOPNOTSUPP;
>>  > +
>>  >  	/* No ATAPI DMA in smart mode */
>>  >  	if (itdev->smart)
>>  >  		return -EOPNOTSUPP;
>>  > 
>>
>> This looks like a gross hack. Aren't you supposed to inspect
>> the command instead and whitelist the ones you know are OK,
>> like pata_pdc2027x.c and sata_promise.c do?
> 
> It does seem to be about transfer size in the IT821x case not commands.
> It may be to do with how we issue ATAPI command transfer sizes from high
> up (patch went to Jeff) but for now this is definitely the right approach
> 
> Reviewed-by: Alan Cox <alan@redhat.com>

I wonder whether we should be using similar check in generic path too.
We have quite a few cases where MWDMA ATAPI devices choking on commands
with small transfer sizes.  I don't think we'll experience significant
performance regression with this applied and even if there is some, it's
far better to have slightly slower working device.

What do you guys think?

-- 
tejun

