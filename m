From: Christoph Hellwig <hch@lst.de>
Subject: Re: command emulation fix
Date: Thu, 19 Jan 2017 21:27:25 +0100
Message-ID: <20170119202725.GB6403@lst.de>
References: <1484412602-11801-1-git-send-email-hch@lst.de> <20170115230723.GB14446@mtj.duckdns.org> <20170116152120.GA16072@lst.de> <20170118191750.GA9171@mtj.duckdns.org> <20170119143551.GA31203@lst.de> <20170119202316.GA25390@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:58735 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754320AbdASUiU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 19 Jan 2017 15:38:20 -0500
Content-Disposition: inline
In-Reply-To: <20170119202316.GA25390@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org

On Thu, Jan 19, 2017 at 03:23:16PM -0500, Tejun Heo wrote:
> Yeah, it is probably fine but I just feel weird about changing the
> code to introduce a possible failure case.  Let's leave it as-is for
> now.

We can move to a small mempool instead.  If we ever want discards
(aka TRIM) to perform nicely on ATA a global static buffer isn't
going to cut it.  I've spent some time to optimize it for NVMe so
that it's usable which I plan to submit soon.  I've not looked ATA
in that respect yet, but it's probably going to be an issue.
