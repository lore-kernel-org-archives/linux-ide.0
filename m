From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: How to determine performance bottleneck?
Date: Mon, 13 Oct 2008 21:12:02 +0100
Message-ID: <20081013211202.0328f1e4@lxorguk.ukuu.org.uk>
References: <20081013202836.3fc62c3e@mjolnir.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:41655 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759910AbYJMUMb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 13 Oct 2008 16:12:31 -0400
In-Reply-To: <20081013202836.3fc62c3e@mjolnir.drzeus.cx>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

> five results in 25 MiB/s/disk. In other words, something is limiting
> things to about 100 MiB/s. Now the question is what that limiting
> factor is.

Whats the PCIe bridge chip and what is the memory bandwidth of the
system ?

