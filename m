From: "Grant Grundler" <grundler@google.com>
Subject: Re: [PATCH 02/12] sata_mv pci features
Date: Fri, 2 May 2008 11:28:56 -0700
Message-ID: <da824cf30805021128k2b5ead90o491b4f911e41cedc@mail.gmail.com>
References: <481AAF84.40501@rtr.ca> <481AAFB7.4090708@rtr.ca>
	 <481AAFE0.9090101@rtr.ca>
	 <da824cf30805020906k276e6574p93dfe7b696eeda8b@mail.gmail.com>
	 <481B5256.9040003@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:38711 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764900AbYEBS3E (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 May 2008 14:29:04 -0400
Received: from zps18.corp.google.com (zps18.corp.google.com [172.25.146.18])
	by smtp-out.google.com with ESMTP id m42ISw7Q016483
	for <linux-ide@vger.kernel.org>; Fri, 2 May 2008 19:28:58 +0100
Received: from wf-out-1314.google.com (wfa28.prod.google.com [10.142.1.28])
	by zps18.corp.google.com with ESMTP id m42ISu5v020660
	for <linux-ide@vger.kernel.org>; Fri, 2 May 2008 11:28:57 -0700
Received: by wf-out-1314.google.com with SMTP id 28so1345172wfa.15
        for <linux-ide@vger.kernel.org>; Fri, 02 May 2008 11:28:56 -0700 (PDT)
In-Reply-To: <481B5256.9040003@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Fri, May 2, 2008 at 10:41 AM, Mark Lord <liml@rtr.ca> wrote:
> Grant Grundler wrote:
>  ..
>
>
> > In order to enable cut-thru, the docs say "MRdTrig" bit in PCI
> > Command Register ()xC00) must also be clear on 6042.
> > This _might_ also apply to  7042. I didn't see any code in
> > this patch (Perhaps a different one?) to make sure
> > "MRdTrig" bit is clear.
> >
>  ..
>
>  Were you looking for this, from the same patch #02:

Yup - exactly. Sorry, I missed that.

I was expecting MRDTRIG to be cleared if the cut-through
was going to be enabled. Instead, MRDTRIG is a gating factor.
I don't know if you want to (or can) change that though.

>  And, no, this does not apply to the 7042 (PCI Express version).

Yes - seems obvious from the code once it's pointed out.

thanks,
grant
