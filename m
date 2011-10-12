From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 3/3] pata_cmd64x: remove dead CMD646 rev 1 code
Date: Wed, 12 Oct 2011 18:55:07 +0100
Message-ID: <20111012185507.0f0b49b0@lxorguk.ukuu.org.uk>
References: <201110111959.04056.bzolnier@gmail.com>
	<20111011205803.0c696a21@lxorguk.ukuu.org.uk>
	<201110121722.50358.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:45982 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751906Ab1JLR7z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 12 Oct 2011 13:59:55 -0400
In-Reply-To: <201110121722.50358.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> cmd646r1_bmdma_stop() just calls the standard ata_bmdma_stop()
> helper and it has been the case since the driver introduction
> by commit 669a5db ("[libata] Add a bunch of PATA drivers.") in
> Aug 2006.

The question that was asked before I seem to remember was whehter it
should be using its own helper. As libata reads the status first it
shouldn't so this seems ok

But this should all be documented in the changelog or god knows how
someone will figure it out in 18 months time if they end up bisecting to
it.

