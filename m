From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 1/3] libata: Remove excess delay in the tf_load path
Date: Fri, 14 May 2010 22:25:25 -0400
Message-ID: <4BEE0615.4000808@garzik.org>
References: <20100505092350.586.46344.stgit@localhost.localdomain> <20100505092448.586.25299.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f198.google.com ([209.85.211.198]:56486 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752811Ab0EOCZ1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 May 2010 22:25:27 -0400
Received: by ywh36 with SMTP id 36so1585486ywh.4
        for <linux-ide@vger.kernel.org>; Fri, 14 May 2010 19:25:26 -0700 (PDT)
In-Reply-To: <20100505092448.586.25299.stgit@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-ide@vger.kernel.org

On 05/05/2010 05:24 AM, Alan Cox wrote:
> We don't need to stall and wait after loading the task file and before
> issuing a command, so don't do it. This shows up on profiles and is not
> needed.
>
> Signed-off-by: Alan Cox<alan@linux.intel.com>
> ---
>
>   drivers/ata/libata-sff.c |    3 ---
>   drivers/ata/pata_via.c   |    2 --
>   2 files changed, 0 insertions(+), 5 deletions(-)

applied


