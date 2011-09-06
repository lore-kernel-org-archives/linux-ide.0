From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2/2] pata_sis: add mode_filter method for certain sis5513
 chipsets
Date: Tue, 06 Sep 2011 15:30:18 -0400
Message-ID: <4E6674CA.6020405@pobox.com>
References: <1315336919-2737-1-git-send-email-dpmcgee@gmail.com> <1315336919-2737-2-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:58630 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754656Ab1IFTaW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Sep 2011 15:30:22 -0400
In-Reply-To: <1315336919-2737-2-git-send-email-dpmcgee@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 09/06/2011 03:21 PM, Dan McGee wrote:
> This mirrors a very old commit (3160d5416f39da9d9) to the old sis5513
> IDE driver that prevents certain setups from working. UDMA6, aka
> ATA/133, is not supported on some chipsets and we need to ensure this
> mode is not chosen even if a connected drive supports it. Port this old
> patch forward to the new PATA driver to ensure UDMA5 is the highest mode
> used if that is what is supported.
>
> Kernel bugzilla #41582.
>
> Reviewed-by: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
> Signed-off-by: Dan McGee<dpmcgee@gmail.com>
> ---
>   drivers/ata/pata_sis.c |   27 ++++++++++++++++++++++++++-
>   1 files changed, 26 insertions(+), 1 deletions(-)


Queued, thanks...




