From: Jens Axboe <axboe@suse.de>
Subject: Re: ahci, SActive flag, and the HD activity LED
Date: Wed, 3 Aug 2005 08:19:22 +0200
Message-ID: <20050803061917.GE3710@suse.de>
References: <42EF93F8.8050601@fujitsu-siemens.com> <20050802163519.GB3710@suse.de> <42F05359.7030006@fujitsu-siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns.virtualhost.dk ([195.184.98.160]:35247 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262077AbVHCGRU (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 3 Aug 2005 02:17:20 -0400
Content-Disposition: inline
In-Reply-To: <42F05359.7030006@fujitsu-siemens.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, "Wichert, Gerhard" <Gerhard.Wichert@fujitsu-siemens.com>

On Wed, Aug 03 2005, Martin Wilck wrote:
> Jens Axboe wrote:
> 
> >>If I am reading the specs correctly, that'd mean the ahci driver is 
> >>wrong in setting the SActive bit.
> >
> >I completely agree, that was my reading of the spec as well and hence my
> >original posts about this in the NCQ thread.
> 
> Have you (or has anybody else) also seen the wrong behavior of the 
> activity LED?

No, but I have observed that SActive never gets cleared by the device
for non-NCQ commands (which is probably which gets you the stuck LED on
some systems?), which to me is another indication that we should not be
setting the tag bits for those commands.

-- 
Jens Axboe

