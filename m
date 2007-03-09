From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: fix native mode disabled port handling
Date: Fri, 9 Mar 2007 12:52:35 +0000
Message-ID: <20070309125235.0ff63053@lxorguk.ukuu.org.uk>
References: <20070309104335.GD32687@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41046 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932657AbXCILs3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 9 Mar 2007 06:48:29 -0500
In-Reply-To: <20070309104335.GD32687@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org

On Fri, 9 Mar 2007 19:43:35 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Disabled port handling in ata_pci_init_native_mode() is slightly
> broken in that it may end up using the wrong port_info.  This patch
> updates it such that disables ports are made dummy as done in the
> legacy and other cases.
> 
> While at it, fix indentation in ata_resources_present().

"Fix" 8)

Acked-by: Alan Cox <alan@redhat.com>
