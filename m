From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 04/64] pata_amd: remove bogus code from timing_setup()
Date: Mon, 18 Jan 2010 17:50:37 +0000
Message-ID: <20100118175037.23727d64@lxorguk.ukuu.org.uk>
References: <20100118171349.14623.90030.sendpatchset@localhost>
	<20100118171420.14623.85263.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:35960 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752343Ab0ARRrv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 18 Jan 2010 12:47:51 -0500
In-Reply-To: <20100118171420.14623.85263.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

On Mon, 18 Jan 2010 18:14:20 +0100
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] pata_amd: remove bogus code from timing_setup()
> 
> DMA modes don't have 8-bit timings.

If you are in a DMA based mode then you have 8bit timings for writes to
the non data registers. You can get an 8bit timed access to the other
drive even in DMA mode. 

