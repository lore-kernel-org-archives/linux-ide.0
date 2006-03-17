From: "Eric D. Mudama" <edmudama@gmail.com>
Subject: Re: LibPATA code issues / 2.6.15.4
Date: Fri, 17 Mar 2006 08:20:41 -0700
Message-ID: <311601c90603170720s624e1fe0ufe1a8e39170fa144@mail.gmail.com>
References: <1142344212.4416ca14a26b4@webmail.aon.at> <44182CD7.9070401@rtr.ca>
	 <20060316100838.GF3595@suse.de> <441A4873.3030102@rtr.ca>
	 <441A80CA.6080407@tw.ibm.com> <441A880F.7010204@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.194]:37426 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751041AbWCQPUm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 17 Mar 2006 10:20:42 -0500
Received: by zproxy.gmail.com with SMTP id m7so907861nzf
        for <linux-ide@vger.kernel.org>; Fri, 17 Mar 2006 07:20:42 -0800 (PST)
In-Reply-To: <441A880F.7010204@pobox.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: albertl@mail.com, Mark Lord <lkml@rtr.ca>, Jens Axboe <axboe@suse.de>, me_trash1@aon.at, linux-ide@vger.kernel.org

On 3/17/06, Jeff Garzik <jgarzik@pobox.com> wrote:
> Even given the current thread's confusion, I rather like the existing
> names.  Everybody does DMA these days, so ATA_CMD_WRITE being of DMA
> protocol seems the most natural to me.

You'd be amazed how many drives ship into new hardware designs that
use PIO.  We've even been asked for non-spec-compliant PIO changes to
improve performance.

Personally I like Albert's renaming patch.
