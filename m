From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH]pata_ninja32: Avoid corrupting status flags
Date: Tue, 30 Aug 2016 16:14:56 -0400
Message-ID: <20160830201456.GC12660@htj.duckdns.org>
References: <20160830164702.26e5e9b4@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yb0-f194.google.com ([209.85.213.194]:34279 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750825AbcH3UO7 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 30 Aug 2016 16:14:59 -0400
Received: by mail-yb0-f194.google.com with SMTP id g67so671539ybi.1
        for <linux-ide@vger.kernel.org>; Tue, 30 Aug 2016 13:14:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160830164702.26e5e9b4@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

On Tue, Aug 30, 2016 at 04:47:02PM +0100, One Thousand Gnomes wrote:
> From: Alan Cox <alan@linux.intel.com>
> 
> Ninja32 needs to set some flags to indicate it does 32bit IO. However it currently assigns this which
> loses the initializing flag and causes a warning spew. Fix it to use a logical or as is intended.
>     
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> Tested-by: Ellmar Stelnberger <estellnb@elstel.org>

Applied to libata/for-4.8-fixes and pushed out.

Thanks.

-- 
tejun
