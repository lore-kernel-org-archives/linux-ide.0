From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH ht6560b] Force prefetch for some devices
Date: Fri, 27 Jun 2008 21:04:14 +0100
Message-ID: <20080627210414.6a903f1e@lxorguk.ukuu.org.uk>
References: <47B97EFA.2040805@caiway.nl>
	<20080218143636.3394eece@core>
	<486544DF.60002@caiway.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:49916 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756109AbYF0UVr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Jun 2008 16:21:47 -0400
In-Reply-To: <486544DF.60002@caiway.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Evert van Grootheest <j.e.van.grootheest@caiway.nl>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com

> Is there some generic way to figure out wheter a device supports it?
> What devices normally support prefetching? Disks only?

It depends on the controller not the device - generally older controller
support it only for disk devices.

Alan
