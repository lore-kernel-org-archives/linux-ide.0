From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 12/15] alim15x3: ->speedproc, filter out invalid modes
 passed from user-space
Date: Mon, 2 Jul 2007 20:22:31 +0100
Message-ID: <20070702202231.33ffe36e@the-village.bc.nu>
References: <200706302110.20766.bzolnier@gmail.com>
	<46891CD4.7020703@ru.mvista.com>
	<200707021956.32844.bzolnier@gmail.com>
	<46893D42.9070603@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48104 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753102AbXGBTQs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jul 2007 15:16:48 -0400
In-Reply-To: <46893D42.9070603@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org

> I am not ready to trust that pata_ali works as well as alim15x3 in all 
> cases.  Someone should test e.g. Alpha AXP systems with IDE (use 
> alim15x3) to make sure all is well.

My pata_ali is reported to do so. I don't know if yours does because my
libata tree has some changes to set the controller to PIO when doing the
initial reset/probe which may be needed if you don't have BIOS init.

If it doesn't it won't be hard to tweak. The timing rules are taken
from the documentation.

Alan
