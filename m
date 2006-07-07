From: Alan Cox <alan@redhat.com>
Subject: Re: [PATCH 15/24] ata_generic - generic BIOS setup SFF ATA driver
Date: Fri, 7 Jul 2006 13:20:00 -0400
Message-ID: <20060707172000.GI25166@devserv.devel.redhat.com>
References: <1152036113264-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361141196-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361153194-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361162763-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361161279-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361173710-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361183634-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036119810-git-send-email-alan@lxorguk.ukuu.org.uk> <11520361203144-git-send-email-alan@lxorguk.ukuu.org.uk> <44AE8C60.5060004@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:22424 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932212AbWGGRVQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 7 Jul 2006 13:21:16 -0400
Content-Disposition: inline
In-Reply-To: <44AE8C60.5060004@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: alan@lxorguk.ukuu.org.uk, akpm@osdl.org, linux-ide@vger.kernel.org, root <root@hraefn.swansea.linux.org.uk>, Alan Cox <alan@redhat.com>

On Fri, Jul 07, 2006 at 12:31:28PM -0400, Jeff Garzik wrote:
> >+static int all_generic_ide;		/* Set to claim all devices */
> 
> Maybe a better name is 'claim_all'?

all_generic_ide is also the name used in the old IDE so it seems good to keep
it together

> Various symbols and strings seem to be confused as to whether this is 
> generic PATA or generic ATA.

Will rework that

