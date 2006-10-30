From: Mark Lord <liml@rtr.ca>
Subject: Re: 2.6.19-rc3-git7: scsi_device_unbusy: inconsistent lock state
Date: Mon, 30 Oct 2006 13:20:37 -0500
Message-ID: <45464275.9040601@rtr.ca>
References: <45460D52.3000404@rtr.ca> <20061030144315.GG4563@kernel.dk> <1162220239.2948.27.camel@laptopd505.fenrus.org> <20061030154444.GH4563@kernel.dk> <1162225002.2948.45.camel@laptopd505.fenrus.org> <20061030162621.GK4563@kernel.dk> <1162225915.2948.49.camel@laptopd505.fenrus.org> <20061030175224.GB14055@kernel.dk> <45463C5B.7070900@rtr.ca> <45464064.2090108@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:22024 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751968AbWJ3SUj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 30 Oct 2006 13:20:39 -0500
In-Reply-To: <45464064.2090108@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Arjan van de Ven <arjan@infradead.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, mingo@elte.hu

Mark Lord wrote:
> 
>I also see it with the SLES10 kernel 2.6.16.21-0.8.
..

Obvious self-correction: not the same problem in the SLES10 kernel.
I just got confused juggling five kernels around.  :)

But problem is still there in 2.6.19*.
Rebuilding kernel now with frame pointers and DEBUG_INFO enabled.

Cheers
