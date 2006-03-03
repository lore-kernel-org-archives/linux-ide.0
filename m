From: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] libata-dev: recognize WRITE_MULTI_FUA_EXT for r/w multiple
Date: Fri, 3 Mar 2006 15:28:23 +0100
Message-ID: <20060303142823.GQ4329@suse.de>
References: <4407AB1D.2080506@tw.ibm.com> <4408521B.9000905@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:43012 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751223AbWCCO2s (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 3 Mar 2006 09:28:48 -0500
Content-Disposition: inline
In-Reply-To: <4408521B.9000905@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: albertl@mail.com, Jeff Garzik <jgarzik@pobox.com>, Linux IDE <linux-ide@vger.kernel.org>

On Fri, Mar 03 2006, Mark Lord wrote:
> Albert Lee wrote:
> >Jeff,
> >
> >Changes:
> >Recognize ATA_CMD_WRITE_MULTI_FUA_EXT as r/w multiple commands.
> 
> This one will require exhaustive testing on various controllers.
> There are quite a few PIO boards with FIFOs that "recognize"
> opcodes for READs and WRITEs.  And practically all of them predate
> any concept of FUA commands.
> 
> Very VERY risky.

Which is why it's so annoying and seemingly idiotic that t13 keeps
making up new opcodes for the exact same thing instead of allowing
options bits.

-- 
Jens Axboe

