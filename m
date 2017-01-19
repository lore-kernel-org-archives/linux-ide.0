From: Christoph Hellwig <hch@lst.de>
Subject: Re: command emulation fix
Date: Thu, 19 Jan 2017 15:35:51 +0100
Message-ID: <20170119143551.GA31203@lst.de>
References: <1484412602-11801-1-git-send-email-hch@lst.de> <20170115230723.GB14446@mtj.duckdns.org> <20170116152120.GA16072@lst.de> <20170118191750.GA9171@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:55741 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752809AbdASOf6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Thu, 19 Jan 2017 09:35:58 -0500
Content-Disposition: inline
In-Reply-To: <20170118191750.GA9171@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org

On Wed, Jan 18, 2017 at 11:17:50AM -0800, Tejun Heo wrote:
> I reverted just the last patch.  The rest should be fine, right?

Yes.  And personally I think the last one is also fine, but we
seem to disagree.
