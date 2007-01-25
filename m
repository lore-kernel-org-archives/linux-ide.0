From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] sata_via: don't diddle with ATA_NIEN in ->freeze
Date: Thu, 25 Jan 2007 12:32:32 +0000
Message-ID: <20070125123232.064f1a49@localhost.localdomain>
References: <20070125114659.GD8606@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56659 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S933174AbXAYMVF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Jan 2007 07:21:05 -0500
In-Reply-To: <20070125114659.GD8606@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, j.taimr@chello.nl

On Thu, 25 Jan 2007 20:46:59 +0900
Tejun Heo <htejun@gmail.com> wrote:

> vt6420 completely loses its ability to raise IRQ for ATAPI devices if
> ATA_NIEN is diddled with in ->freeze.  Further investigation is
> necessary to determine whether this problem is shared on other
> controllers but it doesn't seem to be at this point.

> Signed-off-by: Tejun Heo <htejun@gmail.com>

Acked-by: Alan Cox <alan@redhat.com>
