From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.32: Promise UDMA33 card refuses to work in UDMA mode
Date: Mon, 4 Jan 2010 17:39:58 +0000
Message-ID: <20100104173958.28439d63@lxorguk.ukuu.org.uk>
References: <20091224181300.GA4654@flint.arm.linux.org.uk>
	<20100104103756.6cfa5b3a@lxorguk.ukuu.org.uk>
	<20100104133024.GA10521@flint.arm.linux.org.uk>
	<201001041731.35619.bzolnier@gmail.com>
	<20100104172816.GD18335@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:44890 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753498Ab0ADRg3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Jan 2010 12:36:29 -0500
In-Reply-To: <20100104172816.GD18335@flint.arm.linux.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

> Firstly, icside shares its two IDE channels with one DMA engine - so it's
> a simplex interface.  IDE supports those (or did when the code was written)
> serializing requests between the two interfaces.  libata does not.

Libata does the driver may not.

