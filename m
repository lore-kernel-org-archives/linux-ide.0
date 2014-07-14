From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v4] libata: support the ata host which implements a queue
 depth less than 32
Date: Mon, 14 Jul 2014 09:23:42 -0700
Message-ID: <CAPcyv4h3SiFrOjeGd6Ca8bLoCQERYHp0D3eXkJ2rL=UOTFo7cg@mail.gmail.com>
References: <1405138104-25769-1-git-send-email-haokexin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:59243 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756181AbaGNQXn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Jul 2014 12:23:43 -0400
Received: by mail-ie0-f175.google.com with SMTP id x19so3519640ier.34
        for <linux-ide@vger.kernel.org>; Mon, 14 Jul 2014 09:23:43 -0700 (PDT)
In-Reply-To: <1405138104-25769-1-git-send-email-haokexin@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kevin Hao <haokexin@gmail.com>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <tj@kernel.org>

On Fri, Jul 11, 2014 at 9:08 PM, Kevin Hao <haokexin@gmail.com> wrote:
> The sata on fsl mpc8315e is broken after the commit 8a4aeec8d2d6
> ("libata/ahci: accommodate tag ordered controllers"). The reason is
> that the ata controller on this SoC only implement a queue depth of
> 16. When issuing the commands in tag order, all the commands in tag
> 16 ~ 31 are mapped to tag 0 unconditionally and then causes the sata
> malfunction. It makes no senses to use a 32 queue in software while
> the hardware has less queue depth. So consider the queue depth
> implemented by the hardware when requesting a command tag.
>
> Fixes: 8a4aeec8d2d6 ("libata/ahci: accommodate tag ordered controllers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kevin Hao <haokexin@gmail.com>

Acked-by: Dan Williams <dan.j.williams@intel.com>
