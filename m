From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 7/9] libata: stop overloading port_info->private_data
Date: Mon, 4 Feb 2008 14:26:58 +0000
Message-ID: <20080204142658.00314213@core>
References: <12016853433196-git-send-email-htejun@gmail.com>
	<1201685344817-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47641 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752218AbYBDOda (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 4 Feb 2008 09:33:30 -0500
In-Reply-To: <1201685344817-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, liml@rtr.ca, kngregertsen@norway.atmel.com, sonic.adi@gmail.com, rmk@dyn-67.arm.linux.org.uk, alessandro.zummo@towertech.it, domen.puncer@telargo.com, akira2.iguchi@toshiba.co.jp, leoli@freescale.com, Tejun Heo <htejun@gmail.com>

On Wed, 30 Jan 2008 18:29:01 +0900
Tejun Heo <htejun@gmail.com> wrote:

> port_info->private_data is currently used for two purposes - to record
> private data about the port_info or to specify host->private_data to
> use when allocating ata_host.


Sensible point, horrible implementation - I'd NAK this strongly in favour
of switching to:

ata_pci_init_one(....., private_ptr);

otherwise when that glue changes we are going to keep having to fix six
or more drivers.

Alan
