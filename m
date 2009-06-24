From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] cs5520: add missing IRQ setup for the second port
Date: Wed, 24 Jun 2009 10:22:00 +0100
Message-ID: <20090624102200.7debd041@lxorguk.ukuu.org.uk>
References: <20090623094206.4d1f1b5b@lxorguk.ukuu.org.uk>
	<200906231159.01295.bzolnier@gmail.com>
	<20090623163324.715421f5@lxorguk.ukuu.org.uk>
	<20090623.164429.179899088.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:46095 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750957AbZFXJUh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Jun 2009 05:20:37 -0400
In-Reply-To: <20090623.164429.179899088.davem@davemloft.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: bzolnier@gmail.com, elendil@planet.nl, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> What should we do?  I guess "do nothing and wait until we see a bug
> report from an actual user" is a valid response...


I doubt you ever will.

The docs don't say so I'd assume its hard coded 14/15 as if it was ISA
(its not an IDE storage class device so doesn't have the PCI config bits
to switch between legacy and native modes).

Alan
