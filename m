From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata / pata drivers and smart , pata_via . pata_pdc202xx_old
Date: Sun, 2 Sep 2007 13:38:00 +0100
Message-ID: <20070902133800.7c188e98@the-village.bc.nu>
References: <200709021158.l82BwCcR013983@mi0.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54665 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S965480AbXIBM3t (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 2 Sep 2007 08:29:49 -0400
In-Reply-To: <200709021158.l82BwCcR013983@mi0.bluebottle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: n <xellos@bluebottle.com>
Cc: patrizio.bassi@gmail.com, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, "Kernel," <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@redhat.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

On Sun, 2 Sep 2007 04:58:11 -0700
"n" <xellos@bluebottle.com> wrote:

> is it possible to get the new libata drivers (pata_via . pata_pdc202xx_old) 
> to support smart?
> i was looking at smartcrl -a and it says Device does not support SMART even 
> though it does.

They support smart. You may need a newer smartctl or to use different
options
