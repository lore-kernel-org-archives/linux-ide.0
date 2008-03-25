From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH #upstream-fixes 1/2] libata: implement ata_qc_raw_nbytes()
Date: Mon, 24 Mar 2008 22:26:25 -0400
Message-ID: <47E862D1.2040701@garzik.org>
References: <47D5EFD4.2090801@gmail.com> <47DE63C8.2000006@garzik.org> <47DF81AF.7080000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:49180 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753548AbYCYC02 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 Mar 2008 22:26:28 -0400
In-Reply-To: <47DF81AF.7080000@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "Rafael J. Wysocki" <rjw@sisk.pl>

Tejun Heo wrote:
> Implement ata_qc_raw_nbytes() which determines the raw user-requested
> size of a PC command.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>
> ---
>  drivers/ata/libata-scsi.c |   14 +++++++++++---
>  include/linux/libata.h    |    8 +++++++-
>  2 files changed, 18 insertions(+), 4 deletions(-)

applied 1-2


