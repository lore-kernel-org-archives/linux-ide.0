From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: DMA on ht6560b?
Date: Mon, 18 Feb 2008 14:30:03 +0000
Message-ID: <20080218143003.39f22ca3@core>
References: <47B992A1.2030008@caiway.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:36442 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751340AbYBROih (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Feb 2008 09:38:37 -0500
In-Reply-To: <47B992A1.2030008@caiway.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Evert van Grootheest <j.e.van.grootheest@caiway.nl>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com

> I think the ht6560b controller supports DMA. 

The data sheet doesn't. It's a PIO controller capable of PIO4 with 32bit
host to cpu transfers are best.
