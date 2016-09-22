From: Tejun Heo <tj@kernel.org>
Subject: Re: small libata cleanup
Date: Thu, 22 Sep 2016 11:51:34 -0400
Message-ID: <20160922155134.GC1892@htj.duckdns.org>
References: <1474555790-8716-1-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.161.176]:35394 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757860AbcIVPvg (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 22 Sep 2016 11:51:36 -0400
Received: by mail-yw0-f176.google.com with SMTP id u82so93808290ywc.2
        for <linux-ide@vger.kernel.org>; Thu, 22 Sep 2016 08:51:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1474555790-8716-1-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-ide@vger.kernel.org

On Thu, Sep 22, 2016 at 07:49:48AM -0700, Christoph Hellwig wrote:
> Hi Tejun,
> 
> this series cleans up the few architecture libata-portmap.h headers we
> have, and removes the odd asm-generic/libata-portmap.h one.

Applied 1-2 to libata/for-4.9.

Thanks.

-- 
tejun
