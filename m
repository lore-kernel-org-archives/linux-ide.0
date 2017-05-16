From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: libahci: properly propagate return value of
 platform_get_irq()
Date: Tue, 16 May 2017 11:20:22 -0400
Message-ID: <20170516152022.GA6389@htj.duckdns.org>
References: <1494936372-27209-1-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.161.172]:36726 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750950AbdEPPUZ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 16 May 2017 11:20:25 -0400
Received: by mail-yw0-f172.google.com with SMTP id b68so54548169ywe.3
        for <linux-ide@vger.kernel.org>; Tue, 16 May 2017 08:20:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1494936372-27209-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-ide@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>

On Tue, May 16, 2017 at 02:06:12PM +0200, Thomas Petazzoni wrote:
> When platform_get_irq() fails, it returns an error code, which
> libahci_platform and replaces it by -EINVAL. This commit fixes that by
> propagating the error code. It fixes the situation where
> platform_get_irq() returns -EPROBE_DEFER because the interrupt
> controller is not available yet, and generally looks like the right
> thing to do.
> 
> We pay attention to not show the "no irq" message when we are in an
> EPROBE_DEFER situation, because the driver probing will be retried
> later on, once the interrupt controller becomes available to provide
> the interrupt.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Applied to libata/for-4.12-fixes.

Thanks.

-- 
tejun
