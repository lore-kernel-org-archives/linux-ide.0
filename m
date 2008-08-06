From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Kernel Summit request for Discussion of future of ATA (libata)
 and IDE
Date: Wed, 6 Aug 2008 09:51:18 +0100
Message-ID: <20080806095118.39035512@lxorguk.ukuu.org.uk>
References: <fa.OGeO7gZvBG4obEzRbVltjSebgTQ@ifi.uio.no>
	<fa.KtvYE2B2yrJqUleolhtMPN9ljAQ@ifi.uio.no>
	<fa.AqEKTvguYFAzDFHy/We/8MpOqmo@ifi.uio.no>
	<48976168.3020804@shaw.ca>
	<20080804205508.20a3f917@lxorguk.ukuu.org.uk>
	<48977200.3050307@shaw.ca>
	<20080804220619.76b94ceb@lxorguk.ukuu.org.uk>
	<4898EE70.1030604@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:51005 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754519AbYHFJJ3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Aug 2008 05:09:29 -0400
In-Reply-To: <4898EE70.1030604@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, ksummit-2008-discuss@lists.linux-foundation.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>

> Here's my first cut at it. Compile tested only. This sets most controllers
> to use 32-bit PIO except for those which could potentially be on a real ISA
> or other 16-bit bus. It's a bit non-obvious what to do with some of the
> drivers, so input is welcome.

Only thing I would do differently and definitely want to do differently
is the assumption that we just turn on 32bit and see what occurs. We need
to read/test/change controller by controller over to 32bit not just hope.

Alan
