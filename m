From: "Eric D. Mudama" <edmudama@gmail.com>
Subject: Re: ahci, SActive flag, and the HD activity LED
Date: Thu, 4 Aug 2005 17:49:15 -0600
Message-ID: <311601c9050804164962d8a511@mail.gmail.com>
References: <42EF93F8.8050601@fujitsu-siemens.com>
	 <20050802163519.GB3710@suse.de> <42F05359.7030006@fujitsu-siemens.com>
	 <20050803061917.GE3710@suse.de>
Reply-To: "Eric D. Mudama" <edmudama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rproxy.gmail.com ([64.233.170.197]:22380 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262758AbVHDXtP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 4 Aug 2005 19:49:15 -0400
Received: by rproxy.gmail.com with SMTP id i8so434940rne
        for <linux-ide@vger.kernel.org>; Thu, 04 Aug 2005 16:49:15 -0700 (PDT)
In-Reply-To: <20050803061917.GE3710@suse.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jens Axboe <axboe@suse.de>
Cc: Martin Wilck <martin.wilck@fujitsu-siemens.com>, linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, "Wichert, Gerhard" <Gerhard.Wichert@fujitsu-siemens.com>

On 8/3/05, Jens Axboe <axboe@suse.de> wrote:
> On Wed, Aug 03 2005, Martin Wilck wrote:
> > Have you (or has anybody else) also seen the wrong behavior of the
> > activity LED?
> 
> No, but I have observed that SActive never gets cleared by the device
> for non-NCQ commands (which is probably which gets you the stuck LED on
> some systems?), which to me is another indication that we should not be
> setting the tag bits for those commands.

The drives won't send a SetBits FIS when not using NCQ, as it can
really confuse some host adapters that don't understand NCQ.  I'd
imagine you're correct that the driver shouldn't be setting the bit in
the first place.

--eric
