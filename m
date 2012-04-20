From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] libata: clear error mask of old error history
Date: Fri, 20 Apr 2012 14:29:20 +0400
Message-ID: <4F913A80.3030207@mvista.com>
References: <1334885938.4927.11.camel@minggr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:59841 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754503Ab2DTKa4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Apr 2012 06:30:56 -0400
Received: by lbom4 with SMTP id m4so3826963lbo.19
        for <linux-ide@vger.kernel.org>; Fri, 20 Apr 2012 03:30:54 -0700 (PDT)
In-Reply-To: <1334885938.4927.11.camel@minggr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>

Hello.

On 20-04-012 5:38, Lin Ming wrote:

> The old error history was cleared in ata_ering_clear().
> It only sets ATA_EFLAG_OLD_ER eflags, but the err_mask was not cleared.
> So ata_ering_map() still iterates the old error history.

> This causes problem, for example, wrong probe trials count were returned in
> ata_eh_schedule_probe(), which in turn causes SATA link speed to be slowed down
> to 1.5Gbps.

> Reported-and-tested-by: Martin Mokrejs<mmokrejs@fold.natur.cuni.cz>
> Signed-off-by: Lin Ming<ming.m.lin@intel.com>
> ---

> Hi Jeff,

> This patch fixes an old regression introduced in 2.6.37-rc1
> of commit d902747.

> So it should be included into stable releases since 2.6.37.

    You should have included:

Cc: stable@vger.kernel.org # 2.6.37+

after your signoff in this case.

MBR, Sergei
