From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH #upstream-fixes] libata: ignore deverr on SETXFER if
 mode is configured
Date: Thu, 7 Feb 2008 01:45:39 +0000
Message-ID: <20080207014539.58f7581e@core>
References: <47AA6010.30003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33025 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758395AbYBGBvs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 6 Feb 2008 20:51:48 -0500
In-Reply-To: <47AA6010.30003@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Thu, 07 Feb 2008 10:34:08 +0900
Tejun Heo <htejun@gmail.com> wrote:

> Some controllers (VIA CX700) raise device error on SETXFER even after
> mode configuration succeeded.  Update ata_dev_set_mode() such that
> device error is ignored if transfer mode is configured correctly.  To
> implement this, device is revalidated even after device error on
> SETXFER.
> 
> This fixes kernel bugzilla bug 8563.

Tidy

Acked-by: Alan Cox <alan@redhat.com>
