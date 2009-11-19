From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 4/5] pata: Update experimental tags
Date: Thu, 19 Nov 2009 19:40:08 +0000
Message-ID: <20091119194008.2c97edcd@lxorguk.ukuu.org.uk>
References: <20091117144450.15430.83450.stgit@localhost.localdomain>
	<200911191838.11791.bzolnier@gmail.com>
	<20091119175051.6a91d160@lxorguk.ukuu.org.uk>
	<200911191852.23061.bzolnier@gmail.com>
	<20091119182132.5155f819@lxorguk.ukuu.org.uk>
	<4B0590A2.9050306@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55227 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754562AbZKSTi2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Nov 2009 14:38:28 -0500
In-Reply-To: <4B0590A2.9050306@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Alan Cox <alan@linux.intel.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

>     I'd suggest to address the delay by another, separate patch to both 
> pata_hpt37x and pata_hpt3x2n drivers, and accept Bart's original patch for 
> bit reversing...

If you can confirm the 371N is fine without switching to I/O cycles then
I agree entirely with that and I'll push the udelay(10) into all three
plus the drivers/ide one unless Bart beats me to it.

Alan

