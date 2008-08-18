From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] ata: Add support for Long Logical Sectors and Long
 Physical Sectors
Date: Mon, 18 Aug 2008 19:49:10 +0100
Message-ID: <20080818194910.6c269626@lxorguk.ukuu.org.uk>
References: <1217957207-23116-1-git-send-email-matthew@wil.cx>
	<1217957207-23116-3-git-send-email-matthew@wil.cx>
	<48A8B211.8030103@pobox.com>
	<20080818181523.GG677@parisc-linux.org>
	<20080818190629.22fd618c@lxorguk.ukuu.org.uk>
	<20080818184246.GH677@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:59268 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758559AbYHRTGf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Aug 2008 15:06:35 -0400
In-Reply-To: <20080818184246.GH677@parisc-linux.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Matt_Domsch@dell.com, Matthew Wilcox <willy@linux.intel.com>

> Why do we need to do that?  Leaving sector_size_supported() unset means
> exactly "no to anything but 512".  I'll be quite surprised if we see
> PATA drives supporting 4096 or 520 byte sectors anyway.  It seems like
> a premium feature.

Good point on the former - yes it defaults sane now so that doesn't need
doing. For the sector size remember a lot of PATA chips appear with SATA
bridges at times - especially promise and highpoint.
