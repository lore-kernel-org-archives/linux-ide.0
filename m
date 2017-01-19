From: Tejun Heo <tj@kernel.org>
Subject: Re: command emulation fix
Date: Thu, 19 Jan 2017 15:34:58 -0500
Message-ID: <20170119203458.GC25390@mtj.duckdns.org>
References: <1484412602-11801-1-git-send-email-hch@lst.de>
 <20170115230723.GB14446@mtj.duckdns.org>
 <20170116152120.GA16072@lst.de>
 <20170118191750.GA9171@mtj.duckdns.org>
 <20170119143551.GA31203@lst.de>
 <20170119202316.GA25390@mtj.duckdns.org>
 <20170119202725.GB6403@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34902 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754127AbdASUfK (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 19 Jan 2017 15:35:10 -0500
Received: by mail-pf0-f194.google.com with SMTP id f144so3948068pfa.2
        for <linux-ide@vger.kernel.org>; Thu, 19 Jan 2017 12:35:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170119202725.GB6403@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-ide@vger.kernel.org

Hello, Christoph.

On Thu, Jan 19, 2017 at 09:27:25PM +0100, Christoph Hellwig wrote:
> We can move to a small mempool instead.  If we ever want discards
> (aka TRIM) to perform nicely on ATA a global static buffer isn't
> going to cut it.  I've spent some time to optimize it for NVMe so
> that it's usable which I plan to submit soon.  I've not looked ATA
> in that respect yet, but it's probably going to be an issue.

So, unless we allocate one mempool per port, we're gonna have to
synchronize around its use anyway.  mempool can't guarantee allocation
to multiple users at the same time.  If this is something which
affects scalability, I'm completley fine with making it per-port (or
device).  Each ata_port carries 512 byte buffer anyway.  Maybe we can
reuse that?

Thanks.

-- 
tejun
