From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 1/4 #upstream-fixes] libata: cosmetic updates
Date: Tue, 08 Sep 2009 21:20:39 -0400
Message-ID: <4AA702E7.7030905@pobox.com>
References: <4A77F6B8.4000000@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:51602 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752981AbZIIBUj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 8 Sep 2009 21:20:39 -0400
In-Reply-To: <4A77F6B8.4000000@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: ide <linux-ide@vger.kernel.org>, meissner@novell.com

On 08/04/2009 04:52 AM, Tejun Heo wrote:
> We're about to add more SATA_* and ATA_ACPI_FILTER_* constants.
> Reformat them in preparation.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> ---
>   drivers/ata/libata-acpi.c |   10 ----------
>   include/linux/ata.h       |    4 ++--
>   include/linux/libata.h    |    9 +++++++++

ok, but can you rediff + resend?


