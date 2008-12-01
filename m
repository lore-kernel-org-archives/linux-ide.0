From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] pata-rb532-cf: fix and rename register definitions
Date: Mon, 01 Dec 2008 14:24:25 -0500
Message-ID: <493439E9.9010804@garzik.org>
References: <20081128193322.D103C386DBBE@mail.ifyouseekate.net> <20081128194550.734FF386DBBE@mail.ifyouseekate.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:58986 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751382AbYLATYd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 1 Dec 2008 14:24:33 -0500
In-Reply-To: <20081128194550.734FF386DBBE@mail.ifyouseekate.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Phil Sutter <n0-1@freewrt.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org

Phil Sutter wrote:
> The original standalone driver uses a custom address for the error
> register. Use it in pata-rb532-cf, too.
> 
> Rename two register definitions:
> - The address offset 0x0800 in fact is the ATA base, not ATA command
>   address.
> - The offset 0x0C00 is not a regular ATA data address, but a buffered one
>   allowing 4-byte IO.
> 
> Signed-off-by: Phil Sutter <n0-1@freewrt.org>
> ---
>  drivers/ata/pata_rb532_cf.c |   11 +++++++----

applied


