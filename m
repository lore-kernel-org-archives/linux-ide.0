From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: UDMA failure with UDMA/100 CF card, pata_pdc2027x, MPC8347
Date: Tue, 9 Sep 2008 17:08:49 +0100
Message-ID: <20080909170849.3e60f3ea@lxorguk.ukuu.org.uk>
References: <48C67C5A.8050006@btconnect.com>
	<20080909145811.55cc4726@lxorguk.ukuu.org.uk>
	<48C69004.9030709@btconnect.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:57059 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757193AbYIIQJO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 9 Sep 2008 12:09:14 -0400
In-Reply-To: <48C69004.9030709@btconnect.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: richw@netcomuk.co.uk
Cc: richard.whitlo@btconnect.com, linux-ide@vger.kernel.org

> With our 2.6.20 ppc port, libata configures my lexar 4GB 300x CF card to 
> run at UDMA/100 within about 1.5 seconds - since it works so well, I 
> never really looked at the mechanics of it.
> Any more ideas?

Not immediately but finding which release it broke and then bisecting
that release if neccessary is going to make it a lot lot easier to figure.

