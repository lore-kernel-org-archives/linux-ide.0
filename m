From: Mark Lord <liml@rtr.ca>
Subject: Re: [PATCH] libata: add support for READ/WRITE LONG
Date: Mon, 12 Mar 2007 15:10:05 -0400
Message-ID: <45F5A58D.9060102@rtr.ca>
References: <3aac340703102322p362998b9labedc13503702d2b@mail.gmail.com>	 <45F56800.3040104@rtr.ca> <3aac340703121003l43685599t8dbffe6247879a91@mail.gmail.com> <45F5A523.1080500@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:1128 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752190AbXCLTKC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 Mar 2007 15:10:02 -0400
In-Reply-To: <45F5A523.1080500@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Vitaliyi <imgrey@gmail.com>, Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Mark Lord wrote:
> The READ/WRITE LONG commands are theoretically obsolete,
> but the majority of drives in existance still implement them.
> 
> The WRITE_LONG and WRITE_LONG_ONCE commands are of particular
> interest for fault injection testing -- eg. creating "media errors"
> at specific locations on a disk.
> 
> The fussy bit is that these commands require a non-standard
> sector size, usually 520 bytes instead of 512.
..

A possible nice side-benefit, is that this patch also prepares libata
for future extension to use drives with a mix of physical sector sizes.

More work required for that, of course, but not *much* more.

Cheers
