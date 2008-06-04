From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 7/9] au1xxx-ide: don't use hwif->hwif_data
Date: Wed, 04 Jun 2008 13:43:19 +0400
Message-ID: <484663B7.2080902@ru.mvista.com>
References: <20080602202253.7265.23590.sendpatchset@localhost.localdomain> <20080602202347.7265.36700.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:12044 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752444AbYFDJnY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 4 Jun 2008 05:43:24 -0400
In-Reply-To: <20080602202347.7265.36700.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> * Use &auide_hwif directly instead of using hwif->hwif_data.
>
> While at it:
>
> * No need to initialize hwif->{select,config}_data.
>
> There should be no functional changes caused by this patch.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>   
Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

MBR, Sergei


