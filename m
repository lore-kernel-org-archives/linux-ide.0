From: Tejun Heo <tj@kernel.org>
Subject: Re: command emulation fix
Date: Thu, 19 Jan 2017 15:23:16 -0500
Message-ID: <20170119202316.GA25390@mtj.duckdns.org>
References: <1484412602-11801-1-git-send-email-hch@lst.de>
 <20170115230723.GB14446@mtj.duckdns.org>
 <20170116152120.GA16072@lst.de>
 <20170118191750.GA9171@mtj.duckdns.org>
 <20170119143551.GA31203@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34424 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753872AbdASUXX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 19 Jan 2017 15:23:23 -0500
Received: by mail-pf0-f178.google.com with SMTP id e4so15989794pfg.1
        for <linux-ide@vger.kernel.org>; Thu, 19 Jan 2017 12:23:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170119143551.GA31203@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-ide@vger.kernel.org

Hello, Christoph.

On Thu, Jan 19, 2017 at 03:35:51PM +0100, Christoph Hellwig wrote:
> On Wed, Jan 18, 2017 at 11:17:50AM -0800, Tejun Heo wrote:
> > I reverted just the last patch.  The rest should be fine, right?
> 
> Yes.  And personally I think the last one is also fine, but we
> seem to disagree.

Yeah, it is probably fine but I just feel weird about changing the
code to introduce a possible failure case.  Let's leave it as-is for
now.

Thanks.

-- 
tejun
