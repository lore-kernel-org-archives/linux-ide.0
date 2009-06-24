From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] pata_rdc: driver for RDC ATA devices
Date: Wed, 24 Jun 2009 23:55:48 +0100
Message-ID: <20090624235548.681b8992@lxorguk.ukuu.org.uk>
References: <20090624172930.24354.80799.stgit@t61.ukuu.org.uk>
	<4A42800D.6020202@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:45025 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752138AbZFXWz1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 24 Jun 2009 18:55:27 -0400
In-Reply-To: <4A42800D.6020202@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org, kevin.huang@rdc.com.tw, greg@kroah.com, Linux IDE mailing list <linux-ide@vger.kernel.org>

> Seems fine and fairly straightforward to me.  My lone comment -- go 
> through and replace magic numbers with named constants, for e.g. the PCI 
> config registers that program timings...

Its based on your ata_piix driver. Feel free to update that and I'll pull
names and things across to match.
