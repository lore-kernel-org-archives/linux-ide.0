From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: add missing call to ->cable_detect() in new EH
 path
Date: Sun, 22 Apr 2007 18:39:15 +0100
Message-ID: <20070422183915.6ce375bd@the-village.bc.nu>
References: <20070422170553.GL10619@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55680 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751399AbXDVRfr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 22 Apr 2007 13:35:47 -0400
In-Reply-To: <20070422170553.GL10619@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

On Mon, 23 Apr 2007 02:05:53 +0900
Tejun Heo <htejun@gmail.com> wrote:

> ->cable_detect() used to be called on by the old ata_bus_probe() path.
> Add invocation to ata_eh_revalidate_and_attach() right after IDENTIFYs
> are done.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>

Acked-by: Alan Cox <alan@redhat.com>

I need to push the "if the drive is SATA the cable is SATA " patch once
all this has settled too.
