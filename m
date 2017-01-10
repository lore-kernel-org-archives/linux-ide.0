From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/1] libata: Fix ATA request sense
Date: Tue, 10 Jan 2017 10:59:06 -0500
Message-ID: <20170110155906.GB6666@htj.duckdns.org>
References: <1482110260-14551-1-git-send-email-damien.lemoal@wdc.com>
 <20170106204416.GC29909@mtj.duckdns.org>
 <4ecc1395-3ac9-3381-3a90-b8fb58b46923@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36772 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932476AbdAJP7P (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 10 Jan 2017 10:59:15 -0500
Received: by mail-pf0-f193.google.com with SMTP id b22so13173887pfd.3
        for <linux-ide@vger.kernel.org>; Tue, 10 Jan 2017 07:59:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4ecc1395-3ac9-3381-3a90-b8fb58b46923@wdc.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Damien Le Moal <damien.lemoal@wdc.com>
Cc: linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>

On Tue, Jan 10, 2017 at 09:54:44AM +0900, Damien Le Moal wrote:
> Should we send this patch to stable too ?
> This bug does break applications on kernels 4.7 to 4.9 (e.g. libzbc test
> suite and many tools we have using SGIO to directly send ATA commands to
> SATA disks). I suspect sg-utils and hdparm may be affected in some way too.

Already marked for stable.

Thanks.

-- 
tejun
