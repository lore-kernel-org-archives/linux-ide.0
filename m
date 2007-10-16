From: "peer chen" <peerchen@gmail.com>
Subject: Re: [PATCH] sata_nv,ahci: add the ahci legacy mode support to sata_nv
Date: Tue, 16 Oct 2007 16:08:22 +0800
Message-ID: <cfaab6210710160108x1328086cse991f668e23e569e@mail.gmail.com>
References: <200709251323031982245@gmail.com> <470FE47B.5060505@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.191]:27969 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754646AbXJPIIZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Oct 2007 04:08:25 -0400
Received: by mu-out-0910.google.com with SMTP id i10so2488048mue
        for <linux-ide@vger.kernel.org>; Tue, 16 Oct 2007 01:08:23 -0700 (PDT)
In-Reply-To: <470FE47B.5060505@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>, akpm <akpm@linux-foundation.org>, Kuan Luo <kluo@nvidia.com>

I hope one of the following patches can be merged to 2.6.24.
==========================
http://lkml.org/lkml/2007/10/8/93
http://lkml.org/lkml/2007/9/25/20

Yes, I agree to set the 'swncq' as default for 2.6.24, after all, for
our server customers, stability is far more important than the new
feature no matter the problem is caused by drive or controller.


2007/10/13, Jeff Garzik <jeff@garzik.org>:
> Peer Chen wrote:
> > Add the ahci controller legacy mode support to sata_nv.
> > Move the DIDs of legacy mode from ahci.c to sata_nv.c
> >
> > The patch base on kernel 2.6.23-rc8
> >
> > Signed-off-by: Peer Chen <peerchen@gmail.com>
>
> Would you mind checking libata-dev.git#upstream, and make sure it has
> all the NV patches?
>
> I'm thinking I should go ahead and push the 'nv-swncq' branch, which
> contains the sata_nv updates for swncq.  They have been in -mm for a
> while.  I am leaning towards leaving the default to 'off' for 2.6.24 though.
>
> Comments welcome...
>
>        Jeff
>
>
>
>
