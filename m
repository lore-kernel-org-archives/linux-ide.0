From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata-sff: Reenable Port Multiplier after libata-sff
 remodeling.
Date: Tue, 31 Aug 2010 19:32:24 -0400
Message-ID: <4C7D9108.5010506@garzik.org>
References: <4C7CB7A0.3000003@kernel.org> <1283296836-23863-1-git-send-email-gwendal@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:41660 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752051Ab0HaXc2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 31 Aug 2010 19:32:28 -0400
Received: by qwh6 with SMTP id 6so5739477qwh.19
        for <linux-ide@vger.kernel.org>; Tue, 31 Aug 2010 16:32:28 -0700 (PDT)
In-Reply-To: <1283296836-23863-1-git-send-email-gwendal@google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: tj@kernel.org, nicolas@jungers.net, linux-ide@vger.kernel.org

On 08/31/2010 07:20 PM, Gwendal Grignou wrote:
> Keep track of the link on the which the current request is in progress.
> It allows support of links behind port multiplier.
>
> Not all libata-sff is PMP compliant. Code for native BMDMA controller
> does not take in accound PMP.
>
> Tested on Marvell 7042 and Sil7526.
>
> Signed-off-by: Gwendal Grignou<gwendal@google.com>
> ---
>   drivers/ata/libata-sff.c |   38 ++++++++++++++++++++++++++++----------
>   drivers/ata/sata_mv.c    |    2 +-
>   include/linux/libata.h   |    3 ++-
>   3 files changed, 31 insertions(+), 12 deletions(-)

FWIW, the normal standard for revised patches is to include a short 
changelog following the "---", but preceding the patch itself. 
Something like:

---------------------SNIP-----------------------
Not all libata-sff is PMP compliant. Code for native BMDMA controller
does not take in accound PMP.

Tested on Marvell 7042 and Sil7526.

Signed-off-by: Gwendal Grignou <gwendal@google.com>
---
v3: cleanups, add WARN_ON() etc
v2: ata_sff_queue_pio_task takes a qc etc

  drivers/ata/libata-sff.c |   38 ++++++++++++++++++++++++++++----------
  drivers/ata/sata_mv.c    |    2 +-
  include/linux/libata.h   |    3 ++-
  3 files changed, 31 insertions(+), 12 deletions(-)
---------------------SNIP-----------------------



I'll queue this up along with the other libata fixes tonight (unless 
there are further revisions of course:))

	Jeff


