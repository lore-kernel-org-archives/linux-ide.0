From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 4/6] PalmLD IDE
Date: Tue, 21 Apr 2009 20:35:35 +0100
Message-ID: <20090421203535.081649d9@lxorguk.ukuu.org.uk>
References: <200904210205.59971.marek.vasut@gmail.com>
	<200904211652.34576.marek.vasut@gmail.com>
	<20090421161933.334bc5a2@lxorguk.ukuu.org.uk>
	<200904211944.08970.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:52730 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750743AbZDUTfX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Apr 2009 15:35:23 -0400
In-Reply-To: <200904211944.08970.marek.vasut@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Jeff Garzik <jgarzik@pobox.com>, linux-arm-kernel@lists.arm.linux.org.uk, Eric Miao <eric.y.miao@gmail.com>, linux-ide@vger.kernel.org

> > Ok so the ATA bus side ready isn't sufficient for your hardware ?
> 
> I can retry without the delay, but I'm quite afraid I ran into problems 
> without it. Btw. I rewrote that driver more than half year ago, so I don't 
> really recall the details, sorry, I don't want to misinform you here.

No problem... its not as if it slows down anyone elses hardware.

Ok looks fine for merging - via the ARM tree seems best ?
