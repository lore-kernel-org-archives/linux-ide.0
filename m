From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: UDMA with CS5530 using IBM Netvista N2200 (8363)
Date: Wed, 10 Sep 2008 14:55:45 +0100
Message-ID: <20080910145545.1cc1a30e@the-village.bc.nu>
References: <48C45BEF.5090502@gmail.com>
	<20080908094332.7b021b4e@lxorguk.ukuu.org.uk>
	<48C5BD49.6090204@gmail.com>
	<20080909115248.580eba78@lxorguk.ukuu.org.uk>
	<48C70313.6080704@gmail.com>
	<20080910093840.0fc9df68@the-village.bc.nu>
	<43e9b8530809100614t616154caldb32c4207b5b44ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:36754 "EHLO
	the-village.bc.nu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754684AbYJQVcd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Oct 2008 17:32:33 -0400
In-Reply-To: <43e9b8530809100614t616154caldb32c4207b5b44ad@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Antonio Martins <digiplan.pt@gmail.com>
Cc: linux-ide@vger.kernel.org

> So regarding DMA, Netvista 8363 has this limitation, and there is no
> DMA or UDMA mode that we can successfully enable. The only way to
> force PIO4, is changing directly in the source code. If kernel
> parameters were supported, we would be able to use some "idebus"
> parameter. Are these statements correct?

That seems to be the case yes, and would be fairly normal for devices of
that era using CF type interfaces. Nobody anticipated giant CF devices
with UDMA
