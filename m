From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: remove SCT WRITE SAME support
Date: Fri, 28 Apr 2017 18:10:26 -0400
Message-ID: <20170428221020.GL22354@htj.duckdns.org>
References: <20170425122652.31763-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f178.google.com ([209.85.161.178]:36533 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423119AbdD1WKj (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 28 Apr 2017 18:10:39 -0400
Received: by mail-yw0-f178.google.com with SMTP id l18so37310464ywh.3
        for <linux-ide@vger.kernel.org>; Fri, 28 Apr 2017 15:10:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170425122652.31763-1-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-ide@vger.kernel.org

On Tue, Apr 25, 2017 at 02:26:52PM +0200, Christoph Hellwig wrote:
> This was already disabled a while ago because it caused I/O errors,
> and it's severly getting into the way of the discard / write zeroes
> rework.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Applied to libata/for-4.12.

Thanks.

-- 
tejun
