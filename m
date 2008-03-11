From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 02/16] ata: replace remaining __FUNCTION__ occurrences
Date: Mon, 10 Mar 2008 20:51:30 -0400
Message-ID: <47D5D792.5030402@garzik.org>
References: <1204770292.14154.38.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:50851 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751379AbYCKAvc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 10 Mar 2008 20:51:32 -0400
In-Reply-To: <1204770292.14154.38.camel@brick>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Harvey Harrison <harvey.harrison@gmail.com>
Cc: linux-ide <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

Harvey Harrison wrote:
> __FUNCTION__ is gcc-specific, use __func__
> 
> Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
> ---
>  drivers/ata/libata-acpi.c   |    8 ++++----
>  drivers/ata/libata-core.c   |   14 +++++++-------
>  drivers/ata/pata_pdc2027x.c |    2 +-
>  3 files changed, 12 insertions(+), 12 deletions(-)

applied


