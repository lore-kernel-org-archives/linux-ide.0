From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.27.6 question: ata_sff_hsm_move: ata15 (why always ata15)?
Date: Mon, 24 Nov 2008 18:32:04 +0000
Message-ID: <20081124183204.2d3734e3@lxorguk.ukuu.org.uk>
References: <alpine.DEB.1.10.0811141850590.6217@p34.internal.lan>
	<491E4092.5030804@shaw.ca>
	<20081115103424.34f01370@lxorguk.ukuu.org.uk>
	<491FBA29.3000803@kernel.org>
	<20081116112511.3913123a@lxorguk.ukuu.org.uk>
	<492AF06A.8020004@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:51805 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750876AbYKXScN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Nov 2008 13:32:13 -0500
In-Reply-To: <492AF06A.8020004@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Tejun Heo <tj@kernel.org>, Robert Hancock <hancockr@shaw.ca>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-raid@vger.kernel.org

> Well ata_piix for starters.  Verified here by me.

Some piix are fine (mine are) so maybe its a device property in part.
Certainly it is needed for some combinations including current stuff like
jmicron PATA ports.
