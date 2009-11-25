From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 09/86] pata_atiixp: no need to program PIO timings for
 MWDMA
Date: Wed, 25 Nov 2009 17:25:58 +0000
Message-ID: <20091125172558.69b37360@lxorguk.ukuu.org.uk>
References: <20091125170218.5446.13513.sendpatchset@localhost>
	<20091125170323.5446.6849.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:53897 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759320AbZKYRXw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Nov 2009 12:23:52 -0500
In-Reply-To: <20091125170323.5446.6849.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

On Wed, 25 Nov 2009 18:03:23 +0100
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] pata_atiixp: no need to program PIO timings for MWDMA
> 
> Moreover the code to do it was buggy and programmed PIO timings
> even if they were already set to a desired values.
> 
> There shouldn't be any problems with it as IDE atiixp host driver
> has been allowing separate PIO/MWDMA timings for last two years.

I need to take a look at the history of this - it got put there for a
reason I am sure. Whether a right one I don't know. Needs running past
AMD/ATI's maintainer anyway who should know.


