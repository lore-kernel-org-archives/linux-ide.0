From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 7/8] ide: make legacy IDE VLB modules check for the
 "probe" kernel params
Date: Wed, 14 Feb 2007 11:17:44 +0000
Message-ID: <20070214111744.76553c43@localhost.localdomain>
References: <20070214015603.4619.41923.sendpatchset@localhost.localdomain>
	<20070214015712.4619.78705.sendpatchset@localhost.localdomain>
	<20070214105329.3cc6ec27@localhost.localdomain>
	<200702141207.27483.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:38132 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750780AbXBNLDm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Feb 2007 06:03:42 -0500
In-Reply-To: <200702141207.27483.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

> > No point obsoleting the old ones. By the time being obsolete turns into
> > being anything like "gone", the hardware won't exist. It just causes
> 
> We don't have stable rules for kernel parameters.

We have fifteen years of traditional, common sense and the like

> I'll make warnings more verbose, i.e.
> 
> 'please use "ali14xx.probe" boot option instead of obsoleted "ide0=probe"'

Just leave the old option in as well, nobody needs to care that you are
changing it.

Alan
