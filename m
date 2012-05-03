From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] libata: skip old error history when counting probe trials
Date: Thu, 03 May 2012 15:10:18 +0400
Message-ID: <4FA2679A.2040504@mvista.com>
References: <1336008189.5520.25.camel@minggr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:36563 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753981Ab2ECLMB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 May 2012 07:12:01 -0400
Received: by lahj13 with SMTP id j13so1154634lah.19
        for <linux-ide@vger.kernel.org>; Thu, 03 May 2012 04:12:00 -0700 (PDT)
In-Reply-To: <1336008189.5520.25.camel@minggr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>, Grant Grundler <grundler@google.com>, Gwendal Grignou <gwendal@google.com>

Hello.

On 03-05-2012 5:23, Lin Ming wrote:

> Commit d902747

    Please also specify the summary of that commit in parens.

> introduced ATA_EFLAG_OLD_ER to mark entries in the
> error ring as cleared.

> But ata_count_probe_trials_cb() didn't check this flag and it still
> counts the old error history. So wrong probe trials count is returned
> and it causes problem, for example, SATA link speed is slowed down from
> 3.0Gbps to 1.5Gbps.

> Fix it by checking ATA_EFLAG_OLD_ER in ata_count_probe_trials_cb().

> Cc: stable<stable@vger.kernel.org>  # 2.6.37+
> Signed-off-by: Lin Ming<ming.m.lin@intel.com>

MBR, Sergei
