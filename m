From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ata_sff_data_xfer* return value
Date: Sun, 8 Nov 2009 20:00:50 +0000
Message-ID: <20091108200050.20d96a44@lxorguk.ukuu.org.uk>
References: <m37hu0bywp.fsf@intrepid.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55795 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755108AbZKHUA6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 8 Nov 2009 15:00:58 -0500
In-Reply-To: <m37hu0bywp.fsf@intrepid.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

On Sun, 08 Nov 2009 20:27:02 +0100
Krzysztof Halasa <khc@pm.waw.pl> wrote:

> Hi,
> 
> I wonder if this is entirely correct? If so, why?

It is correct. We return the bytes consumed as it may well not be the
same as the total bytes requested. In practice we don't currently do a
great deal with it even with ATAPI but it's useful for doing bug checks.

