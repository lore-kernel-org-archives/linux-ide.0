From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 00/68] ide2libata
Date: Mon, 1 Feb 2010 10:31:19 +0100
Message-ID: <201002011031.19741.bzolnier@gmail.com>
References: <20100129160308.21495.14120.sendpatchset@localhost> <20100129232540.41f6c4f6@lxorguk.ukuu.org.uk> <20100131.234726.124893364.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:25372 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127Ab0BAJbz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Feb 2010 04:31:55 -0500
In-Reply-To: <20100131.234726.124893364.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: alan@lxorguk.ukuu.org.uk, jeff@garzik.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 01 February 2010 08:47:26 am David Miller wrote:

> However what I don't like is how this is implemented.  We shouldn't
> pretend the data structures are the same by using macros in some
> header file, we should truly abstract out the data types properly such
> that these drivers in fact use the same datastructures.

The hardest part is done and the idea is proved so this indeed would be
a natural next step..

> For the price of a few series of data structure morphs, we eliminate
> the tester-base issue of legacy IDE.  There's one driver for both
> ATA and legacy IDE, the stuff in front is just a presentation and
> probing layer, nothing more.

Hmm.. sounds exactly like the direction in which IDE has been going for
the last few years.. :)

--
Bartlomiej Zolnierkiewicz
