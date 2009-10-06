From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH REDIFFED 1/4 #upstream] libata: cosmetic updates
Date: Tue, 06 Oct 2009 00:25:16 -0400
Message-ID: <4ACAC6AC.7060906@pobox.com>
References: <4A77F6B8.4000000@kernel.org> <4AA702E7.7030905@pobox.com> <4AAFE7F4.9050400@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:55430 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750746AbZJFEZ4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Oct 2009 00:25:56 -0400
In-Reply-To: <4AAFE7F4.9050400@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: ide <linux-ide@vger.kernel.org>, meissner@novell.com

On 09/15/2009 03:16 PM, Tejun Heo wrote:
> We're about to add more SATA_* and ATA_ACPI_FILTER_* constants.
> Reformat them in preparation.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> ---
> Almost forgot about this series.  Here's the refreshed version.
>
> Thanks.
>
>   drivers/ata/libata-acpi.c |   10 ----------
>   include/linux/ata.h       |    6 +++---
>   include/linux/libata.h    |    9 +++++++++
>   3 files changed, 12 insertions(+), 13 deletions(-)

applied


