From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: reject passthrough WRITE SAME requests
Date: Fri, 28 Apr 2017 18:09:31 -0400
Message-ID: <20170428220931.GK22354@htj.duckdns.org>
References: <20170425113954.23121-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33797 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032217AbdD1WJd (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 28 Apr 2017 18:09:33 -0400
Content-Disposition: inline
In-Reply-To: <20170425113954.23121-1-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-ide@vger.kernel.org, stable@vger.kernel.org

On Tue, Apr 25, 2017 at 01:39:54PM +0200, Christoph Hellwig wrote:
> The WRITE SAME to TRIM translation rewrites the DATA OUT buffer.  While
> the SCSI code accomodates for this by passing a read-writable buffer
> userspace applications don't cater for this behavior.  In fact it can
> be used to rewrite e.g. a readonly file through mmap and should be
> considered as a security fix.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Cc: stable@vger.kernel.org

Applied to libata/for-4.12, assuming we aren't doing rc9.

Thanks.

-- 
tejun
