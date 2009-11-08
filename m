From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: ata_sff_data_xfer* return value
Date: Sun, 08 Nov 2009 21:06:04 +0100
Message-ID: <m3y6mgaij7.fsf@intrepid.localdomain>
References: <m37hu0bywp.fsf@intrepid.localdomain>
	<20091108200050.20d96a44@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from khc.piap.pl ([195.187.100.11]:55996 "EHLO khc.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754607AbZKHUGA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 8 Nov 2009 15:06:00 -0500
In-Reply-To: <20091108200050.20d96a44@lxorguk.ukuu.org.uk> (Alan Cox's message
	of "Sun, 8 Nov 2009 20:00:50 +0000")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> It is correct. We return the bytes consumed as it may well not be the
> same as the total bytes requested. In practice we don't currently do a
> great deal with it even with ATAPI but it's useful for doing bug checks.

I see. Thanks.
-- 
Krzysztof Halasa
