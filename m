From: "Eric D. Mudama" <edmudama@bounceswoosh.org>
Subject: Re: ide-io.c, ide_do_request -- race condition?
Date: Mon, 12 Jul 2004 12:35:05 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040712183505.GE26789@bounceswoosh.org>
References: <40F2CFDE.66D28904@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 80-169-17-66.mesanetworks.net ([66.17.169.80]:681 "EHLO
	mail.bounceswoosh.org") by vger.kernel.org with ESMTP
	id S261605AbUGLSeV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Jul 2004 14:34:21 -0400
Content-Disposition: inline
In-Reply-To: <40F2CFDE.66D28904@verizon.net>
List-Id: linux-ide@vger.kernel.org
To: "Max T. Woodbury" <max.teneyck.woodbury@verizon.net>
Cc: linux-ide@vger.kernel.org

On Mon, Jul 12 at 13:52, Max T. Woodbury wrote:
>Still, why would PIO mode be unsafe?  (I can see slower, but I don't
>expect speed from this beast.  Oh well.  Thanks for the pointer.)

PIO has no data integrity check, so bogus cables that glitch the data
will not be detected.  Not sure if that is what he was talking about,
but is definitely a problem for PIO.

--eric


-- 
Eric D. Mudama
edmudama@mail.bounceswoosh.org

