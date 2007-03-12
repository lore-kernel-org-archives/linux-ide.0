From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] libata: add support for READ/WRITE LONG
Date: Mon, 12 Mar 2007 22:13:51 +0000
Message-ID: <20070312221351.6c3db1fa@lxorguk.ukuu.org.uk>
References: <3aac340703102322p362998b9labedc13503702d2b@mail.gmail.com>
	<45F56800.3040104@rtr.ca>
	<3aac340703121003l43685599t8dbffe6247879a91@mail.gmail.com>
	<45F5A523.1080500@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54431 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752276AbXCLVKa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 12 Mar 2007 17:10:30 -0400
In-Reply-To: <45F5A523.1080500@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Vitaliyi <imgrey@gmail.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

On Mon, 12 Mar 2007 15:08:19 -0400
Mark Lord <liml@rtr.ca> wrote:

> The READ/WRITE LONG commands are theoretically obsolete,
> but the majority of drives in existance still implement them.
> 
> The WRITE_LONG and WRITE_LONG_ONCE commands are of particular
> interest for fault injection testing -- eg. creating "media errors"
> at specific locations on a disk.

Do you still get hangs with ata_piix if you use R/W LONG and these
changes ?

Alan
