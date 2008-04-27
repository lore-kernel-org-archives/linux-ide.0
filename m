From: "Bryan Wu" <cooloney@kernel.org>
Subject: Re: [PATCH 1/1] [libata/BF54x]: Fix bug - Implement bfin ata interrupt handler to avoid "irq 68 nobody cared" (v2)
Date: Sun, 27 Apr 2008 21:53:58 +0800
Message-ID: <386072610804270653vdfd2cf3g30a07ee41d6e9c0d@mail.gmail.com>
References: <1209115165-24995-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:2426 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754057AbYD0NyF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Apr 2008 09:54:05 -0400
Received: by yw-out-2324.google.com with SMTP id 5so858097ywh.1
        for <linux-ide@vger.kernel.org>; Sun, 27 Apr 2008 06:53:58 -0700 (PDT)
In-Reply-To: <1209115165-24995-1-git-send-email-cooloney@kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sonic Zhang <sonic.zhang@analog.com>, Bryan Wu <cooloney@kernel.org>

On Fri, Apr 25, 2008 at 5:19 PM, Bryan Wu <cooloney@kernel.org> wrote:
> From: Sonic Zhang <sonic.zhang@analog.com>
>
>  Return IRQ_HANDLED when bfin ata device is busy.
>  http://blackfin.uclinux.org/gf/project/uclinux-dist/tracker/?action=TrackerItemEdit&tracker_item_id=3513
>
>  v1-v2:
>   - fold api breakage fixing patch together.
>   - mark 'static', not 'inline'.
>
>  Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
>  Signed-off-by: Bryan Wu <cooloney@kernel.org>
>  ---
>   drivers/ata/pata_bf54x.c |  124 ++++++++++++++++++++++++++++++++++++++++++++--
>   1 files changed, 120 insertions(+), 4 deletions(-)
>

Hi Jeff,

Is this V2 updated patch OK for you?

Thanks
-Bryan
