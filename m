From: Alan Cox <alan@redhat.com>
Subject: Re: [PATCH] libata: Add MMIO support to pata_sil680
Date: Thu, 24 May 2007 05:33:16 -0400
Message-ID: <20070524093316.GB10777@devserv.devel.redhat.com>
References: <20070515061239.611A2DDEE9@ozlabs.org> <1179209697.32247.153.camel@localhost.localdomain> <20070523144217.5abd9fdf@the-village.bc.nu> <1179960518.32247.948.camel@localhost.localdomain> <20070524003123.77b9c81c@the-village.bc.nu> <46552A63.4080002@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:39221 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758114AbXEXJdf (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 May 2007 05:33:35 -0400
Content-Disposition: inline
In-Reply-To: <46552A63.4080002@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alan Cox <alan@redhat.com>, Linux IDE <linux-ide@vger.kernel.org>

On Thu, May 24, 2007 at 02:02:11AM -0400, Jeff Garzik wrote:
> Ben's patch got merged because it does not change the status quo.  This 

Yes it does - SRST timing is now wrong for the SIL680. Thats PATA and now
PATA + MMIO so the problem case.

