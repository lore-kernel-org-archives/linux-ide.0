From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/6] ata: add ata_is_fpdma() accessor
Date: Tue, 21 Jun 2016 11:45:54 -0400
Message-ID: <20160621154554.GG3262@mtj.duckdns.org>
References: <1466422756-126637-1-git-send-email-hare@suse.de>
 <1466422756-126637-4-git-send-email-hare@suse.de>
 <20160620154249.GK3262@mtj.duckdns.org>
 <5768D566.9070207@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:33644 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731AbcFUPwc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Jun 2016 11:52:32 -0400
Received: by mail-yw0-f173.google.com with SMTP id v77so17724414ywg.0
        for <linux-ide@vger.kernel.org>; Tue, 21 Jun 2016 08:52:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5768D566.9070207@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hannes Reinecke <hare@suse.de>
Cc: Damien Le Moal <damien.lemoal@hgst.com>, linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.com>

Hello,

On Tue, Jun 21, 2016 at 07:49:26AM +0200, Hannes Reinecke wrote:
> Yes. Most of the SATA drivers (with the exception of ahci) don't know
> about NCQ NON DATA commands, so they use the test for 'NCQ' as a
> shorthand for 'NCQ command with DMA data'.
> With the introduction of the ATA_PROT_NODATA protocol variable these two
> are no longer equivalent, as you can have NCQ commands without DMA.
> As I haven't vetted any of those adapters for NCQ NON DATA commands, and
> these driver internally also assume that any NCQ command will have
> DMA-able data, I thought it prudent to introduce an ata_is_fpdma() flag,
> which retains the original meaning of ata_is_ncq().

In that case, the patch description needs to be way beefier.  As it
is, it looks like a trivial cleanup patch which it isn't.

Thanks.

-- 
tejun
