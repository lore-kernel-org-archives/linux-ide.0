From: Tejun Heo <tj@kernel.org>
Subject: Re: command emulation fix
Date: Thu, 19 Jan 2017 15:45:34 -0500
Message-ID: <20170119204534.GE25390@mtj.duckdns.org>
References: <1484412602-11801-1-git-send-email-hch@lst.de>
 <20170115230723.GB14446@mtj.duckdns.org>
 <20170116152120.GA16072@lst.de>
 <20170118191750.GA9171@mtj.duckdns.org>
 <20170119143551.GA31203@lst.de>
 <20170119202316.GA25390@mtj.duckdns.org>
 <20170119202725.GB6403@lst.de>
 <20170119203458.GC25390@mtj.duckdns.org>
 <20170119203646.GD25390@mtj.duckdns.org>
 <20170119204135.GA6675@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34255 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751292AbdASUxv (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 19 Jan 2017 15:53:51 -0500
Received: by mail-pf0-f194.google.com with SMTP id y143so3974937pfb.1
        for <linux-ide@vger.kernel.org>; Thu, 19 Jan 2017 12:53:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170119204135.GA6675@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-ide@vger.kernel.org

Hello,

On Thu, Jan 19, 2017 at 09:41:35PM +0100, Christoph Hellwig wrote:
> On Thu, Jan 19, 2017 at 03:36:46PM -0500, Tejun Heo wrote:
> > But do you actually expect there to be scalability issues around this
> > buffer?  Its uses are extremely short and libata operations are pretty
> > strongly synchronized to begin with.
> 
> Mostly for setups using JBODs with massive numbers of SATA disks.
> 
> This would mostly not be ahci or a real ATA driver but libsas calling
> into libata for the translation.

Ah, understood.

Thanks for the explanation.

-- 
tejun
