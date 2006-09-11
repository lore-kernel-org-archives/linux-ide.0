From: Jeff Garzik <jeff@garzik.org>
Subject: Re: What's in libata-dev.git
Date: Mon, 11 Sep 2006 11:50:55 -0400
Message-ID: <450585DF.1080500@garzik.org>
References: <20060911132250.GA5178@havoc.gtf.org> <45056627.7030202@ru.mvista.com> <450566A2.1090009@garzik.org> <450568F3.3020005@ru.mvista.com> <1157986974.23085.147.camel@localhost.localdomain> <45057651.8000404@garzik.org> <1157988513.23085.159.camel@localhost.localdomain> <20060911153706.GE4955@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:41399 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751313AbWIKPvD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Sep 2006 11:51:03 -0400
In-Reply-To: <20060911153706.GE4955@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>

Jens Axboe wrote:
> On Mon, Sep 11 2006, Alan Cox wrote:
>> We could perhaps do it by ATA version - 255 for ATA < 3 256 for ATA 3+,
> 
> Might be sane, yep.


Since we're doing this just for paranoia, and nobody can actually 
produce a problem case, it's safer just to hardcode 255 for all cases, 
than try to come up with a hueristic that won't be exercised for another 
decade...

Most new disks are lba48 anyway.  (should we use 65535 there too???)

	Jeff


