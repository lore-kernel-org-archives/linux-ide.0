From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Libata PATA status
Date: Wed, 4 Jul 2007 15:23:59 +0100
Message-ID: <20070704152359.1ad8d194@the-village.bc.nu>
References: <20070703185116.59c8f5f5@the-village.bc.nu>
	<p73k5tg2uj9.fsf@bingen.suse.de>
	<20070704131746.4bbe4d0e@the-village.bc.nu>
	<20070704130258.GA10904@one.firstfloor.org>
	<20070704141819.01a357fa@the-village.bc.nu>
	<20070704132930.GB10904@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49255 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758750AbXGDORr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 4 Jul 2007 10:17:47 -0400
In-Reply-To: <20070704132930.GB10904@one.firstfloor.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: Andi Kleen <andi@firstfloor.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jeff@garzik.org

On Wed, 4 Jul 2007 15:29:30 +0200
Andi Kleen <andi@firstfloor.org> wrote:

> > You could probably reliably map "hda/b/c/d" initially with some kind of
> > forwarder providing nobody hot plugged them.  Just not sure I see the
> 
> PATA hotplug? 
> 
> SATA systems typically already use /dev/sda*, it just applies to PATA.

We support PATA warm plugging sort of already and it'll go further in
time. Mostly this is relevant to laptops
