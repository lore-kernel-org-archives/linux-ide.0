From: Mark Lord <liml@rtr.ca>
Subject: Re: [RFT] major libata update
Date: Wed, 17 May 2006 18:03:19 -0400
Message-ID: <446B9DA7.6060400@rtr.ca>
References: <20060515170006.GA29555@havoc.gtf.org> <4469B93E.6010201@emc.com> <4469E0DB.1040709@garzik.org> <4469EEC0.4060907@gmail.com> <446A1A21.80501@emc.com> <446A63F6.5030706@gmail.com> <446A6615.6050701@garzik.org> <446A678E.8030403@garzik.org> <446A6ECD.7080104@garzik.org> <446A734A.6020504@gmail.com> <446A7504.9000201@gmail.com> <446A88DF.5060705@emc.com> <446A7E4A.1080003@gmail.com> <446A9F13.4020907@emc.com> <446AAA33.5010800@gmail.com> <446B8F25.3040907@pobox.com> <446B8FC6.5040009@garzik.org> <446B9AA7.4000305@gmail.com> <446B9C1A.1060106@rtr.ca> <446B9D16.3010302@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:1926 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751177AbWEQWDU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 May 2006 18:03:20 -0400
In-Reply-To: <446B9D16.3010302@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>, Ric Wheeler <ric@emc.com>, linux-ide@vger.kernel.org, Jens Axboe <axboe@suse.de>

Jeff Garzik wrote:
>
>> Once the sysfs attr's actually work, I'll probably re-do my hdparm
>> stuff to detect use them when available, avoiding the need for libata
>> to snoop passthrough commands.  But Jeff may (or not) want to snoop 
>> anyway.
> 
> We _have_ to snoop some commands, like SET FEATURES - XFER MODE.
> 
> Its just a given... you gotta either maintain cached state, or you gotta 
> notice when its stale.

Ah then, I suppose libata might as well snoop the write-cache on/off
(SET FEATURES) command as well.  We need some kind of API or something
to avoid the nasty layering violation that my hack uses.. I wonder if
we can just do a revalidate disk or something?

Cheers
