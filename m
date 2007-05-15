From: Alan Cox <alan@redhat.com>
Subject: Re: [PATCH] libata: Add MMIO support to pata_sil680
Date: Tue, 15 May 2007 07:08:18 -0400
Message-ID: <20070515110818.GA23094@devserv.devel.redhat.com>
References: <20070515061153.425BDDDEE8@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:58351 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754812AbXEOLIc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 May 2007 07:08:32 -0400
Content-Disposition: inline
In-Reply-To: <20070515061153.425BDDDEE8@ozlabs.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: jgarzik@pobox.com, Alan Cox <alan@redhat.com>, Linux IDE <linux-ide@vger.kernel.org>

On Tue, May 15, 2007 at 04:11:23PM +1000, Benjamin Herrenschmidt wrote:
> +	if (!try_mmio)
> +		goto use_pio;

Please use a different naming scheme "PIO" means something quite different
in ATA

Rest looks fine although I'd be interested to know if you can measure any
performance change.

Alan

