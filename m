From: Christoph Hellwig <hch@lst.de>
Subject: Re: command emulation fix
Date: Thu, 19 Jan 2017 21:41:35 +0100
Message-ID: <20170119204135.GA6675@lst.de>
References: <1484412602-11801-1-git-send-email-hch@lst.de> <20170115230723.GB14446@mtj.duckdns.org> <20170116152120.GA16072@lst.de> <20170118191750.GA9171@mtj.duckdns.org> <20170119143551.GA31203@lst.de> <20170119202316.GA25390@mtj.duckdns.org> <20170119202725.GB6403@lst.de> <20170119203458.GC25390@mtj.duckdns.org> <20170119203646.GD25390@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:58769 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751012AbdASUmY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 19 Jan 2017 15:42:24 -0500
Content-Disposition: inline
In-Reply-To: <20170119203646.GD25390@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org

On Thu, Jan 19, 2017 at 03:36:46PM -0500, Tejun Heo wrote:
> But do you actually expect there to be scalability issues around this
> buffer?  Its uses are extremely short and libata operations are pretty
> strongly synchronized to begin with.

Mostly for setups using JBODs with massive numbers of SATA disks.

This would mostly not be ahci or a real ATA driver but libsas calling
into libata for the translation.
