From: Mark Lord <liml@rtr.ca>
Subject: Re: Port Multiplier drives not always all found on cold plug
Date: Sat, 17 May 2008 15:16:44 -0400
Message-ID: <482F2F1C.9030102@rtr.ca>
References: <482DB79F.2030204@rtr.ca> <482DBA62.4020209@rtr.ca> <482DBC5C.3020904@rtr.ca> <482DC41F.9080901@rtr.ca> <482DCD1F.4090503@rtr.ca> <482EE9E1.5000805@gmail.com> <482F16AB.1040003@rtr.ca> <482F1B5C.2000006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:2910 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754257AbYEQTQr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 17 May 2008 15:16:47 -0400
In-Reply-To: <482F1B5C.2000006@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@redhat.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
>
> * sil3124/32 and mv4140 combination for some reason can't do NCQ
>   reliably.  I don't know why.  I'll blacklist it for the time being
>   and contact both companies about this.
..

MMm... I wonder if it's the "don't mix NCQ with non-NCQ" issue there ?

I'll ping my Marvell folks about that one too.

Cheers
