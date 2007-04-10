From: Olaf Hering <olaf@aepfle.de>
Subject: Re: adding Pegasus IDE quirk for pata_via
Date: Tue, 10 Apr 2007 18:22:29 +0200
Message-ID: <20070410162229.GA508@aepfle.de>
References: <20070404111635.GA1855@aepfle.de> <461A3C10.3050104@genesi-usa.com> <20070409154026.4d8a0774@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:50054 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031031AbXDJQVv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 10 Apr 2007 12:21:51 -0400
Content-Disposition: inline
In-Reply-To: <20070409154026.4d8a0774@the-village.bc.nu>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matt Sealey <matt@genesi-usa.com>, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org

On Mon, Apr 09, Alan Cox wrote:

> > Again some comments would be appreciated from anyone who has a better idea on how this controller
> > works. This simple code addition came out of 2 or 3 days of discussion with the Pegasos designer
> > based on his experiences with the chip and is so simple there cannot be much wrong with it
> > apart from coding style and a distinct lack of testing.
> 
> Seems sane to me - as you said the x86 world relies on the BIOS for this
> and in fact pretty much never uses native mode anyway.

The snipped is appearently for drivers/ide.
Where is the correct place for drivers/ata?
