From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 05/20] pata_efar: always program master_data before
 slave_data
Date: Wed, 23 Feb 2011 10:36:15 +0000
Message-ID: <20110223103615.76b8a621@lxorguk.ukuu.org.uk>
References: <20110208122314.19110.4092.sendpatchset@linux-mhg7.site>
	<AANLkTi=jp+q9VYNJvko8P4ju_z86Rw5AxWY9O_reFDai@mail.gmail.com>
	<20110223091437.0fb888a2@lxorguk.ukuu.org.uk>
	<201102231128.51910.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:51908 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752317Ab1BWKeX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 Feb 2011 05:34:23 -0500
In-Reply-To: <201102231128.51910.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Sergei Shtylyov <sshtylyov@mvista.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: [PATCH] ata_piix: add RDC support
> 
> Add RDC PATA support to ata_piix and remove no longer
> needed pata_rdc driver.

Now that one does make sense given the similarity. I'll go over both
later today and see if I agree they match this way.
