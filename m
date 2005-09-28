From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH libata-dev-2.6:upstream] libata EH document update
Date: Wed, 28 Sep 2005 12:19:14 -0400
Message-ID: <433AC282.6010000@pobox.com>
References: <20050926022847.GA9724@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:28644 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751085AbVI1QTT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Sep 2005 12:19:19 -0400
In-Reply-To: <20050926022847.GA9724@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org, tali@admingilde.org

Tejun Heo wrote:
>  Hello, Jeff.
> 
>  Here's DocBook'fied libata_eh document.  Sorry it took so long.

thanks, applied.


>  To whine a little bit, I still think it's better to go plain text
> with ata docs under Documentation/ata.  I don't really see the
> benefits of DocBook as it currently stands.  It's so much less
> accessible.  make pdf/ps docs still don't work and although it's been
> broken for quite a while now, nobody really cares.

It depends on your distro whether it works or not :(

For me, I just 'make xmldocs' then use db2pdf to convert the documents, 
since xmlto fails miserably.


>  One benefit of using DocBook is integrating docs generated from
> comments with the rest of template but I think such generated content
> can (maybe should) stay separate from other stuff.  I think the
> generated content and the rest won't stay synchronized for very long
> considering the rate of change, lazy doc updates and even less
> interest in DocBook docs.  Okay, enough whining.
> 
>  For libata_eh doc, I just created a <sect1> which contains the whole
> thing.  I thought about separating out origins of commands and stuff
> into separate chapters so that the structure of the document is more
> consistent, but the contents were too little to be spread out and they
> are describing in EH centric way, so I just left all in one chapter.
> 
>  I'm thinking about attaching ata_exceptions doc at the end of this
> DocBook file as a separate supplementary chapter.  What do you think?

Sounds good to me, though I think it works best when placed before the 
chapters for the individual drivers.

	Jeff


