From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: FUA and 311x (was Re: LibPATA code issues / 2.6.15.4)
Date: Wed, 01 Mar 2006 20:58:02 -0500
Message-ID: <4406512A.9080708@pobox.com>
References: <1141239617.23202.5.camel@rousalka.dyndns.org>	 <4405F471.8000602@rtr.ca>	 <1141254762.11543.10.camel@rousalka.dyndns.org> <311601c90603011719k43af0fbbg889f47d798e22839@mail.gmail.com> <440650BC.5090501@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:28820 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751113AbWCBB6H (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Mar 2006 20:58:07 -0500
In-Reply-To: <440650BC.5090501@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>, "Eric D. Mudama" <edmudama@gmail.com>, Tejun Heo <htejun@gmail.com>
Cc: Nicolas Mailhot <nicolas.mailhot@gmail.com>, Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Carlos Pardo <Carlos.Pardo@siliconimage.com>

Jeff Garzik wrote:
> For libata, I think an ATA_FLAG_NO_FUA would be appropriate for 
> situations like this...  assume FUA is supported in the controller, and 
> set a flag where it is not.  Most chips will support FUA, either by 
> design or by sheer luck.  The ones that do not support FUA are the 
> controllers that snoop the ATA command opcode, and internally choose the 
> protocol based on that opcode.  For such hardware, unknown opcodes will 
> inevitably cause problems.

This also begs the question... what controller was being used, when the 
single Maxtor device listed in the blacklist was added?  Perhaps it was 
a problem with the controller, not the device.

	Jeff


