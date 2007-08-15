From: Mikko Rapeli <mikko.rapeli@iki.fi>
Subject: Re: [PATCH] ST340823A, HPA and libata
Date: Wed, 15 Aug 2007 16:56:33 +0300
Message-ID: <20070815135633.GA1920@nalle>
References: <20070801092903.GA1199@nalle> <200708030034.13193.bzolnier@gmail.com> <20070802231100.GA1861@nalle> <200708030135.16910.bzolnier@gmail.com> <20070805190616.GA1932@nalle> <20070808142505.3213a1a6@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gw03.mail.saunalahti.fi ([195.197.172.111]:50757 "EHLO
	gw03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753334AbXHON4m (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Aug 2007 09:56:42 -0400
Content-Disposition: inline
In-Reply-To: <20070808142505.3213a1a6@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org, jeff@garzik.org, akpm@osdl.org

On Wed, Aug 08, 2007 at 02:25:05PM +0100, Alan Cox wrote:
> Ok this is a different approach to handling it - knowing it is an off by
> one so we can handle the drive if clipped

Patch works with 2.6.23-rc2 after the boot problem was solved.

-Mikko
