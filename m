From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 3/3] libata: Make sil680 do its own exec_command posting
Date: Fri, 14 May 2010 22:34:56 -0400
Message-ID: <4BEE0850.5060502@garzik.org>
References: <20100505092350.586.46344.stgit@localhost.localdomain> <20100505092542.586.16410.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f191.google.com ([209.85.210.191]:59427 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752811Ab0EOCe7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 May 2010 22:34:59 -0400
Received: by yxe29 with SMTP id 29so1353242yxe.4
        for <linux-ide@vger.kernel.org>; Fri, 14 May 2010 19:34:57 -0700 (PDT)
In-Reply-To: <20100505092542.586.16410.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-ide@vger.kernel.org

On 05/05/2010 05:25 AM, Alan Cox wrote:
> Use our own mmio area to avoid PCI posting. This avoids the rather slow
> paranoid implementation in the default handler.
>
> Signed-off-by: Alan Cox<alan@linux.intel.com>
> ---
>
>   drivers/ata/pata_sil680.c |   30 ++++++++++++++++++++++++++----
>   1 files changed, 26 insertions(+), 4 deletions(-)

applied


