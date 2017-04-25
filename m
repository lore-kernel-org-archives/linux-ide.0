From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] libata: reject passthrough WRITE SAME requests
Date: Tue, 25 Apr 2017 12:31:08 -0400
Message-ID: <yq1mvb4fnzn.fsf@oracle.com>
References: <20170425113954.23121-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:20348 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1948277AbdDYQbX (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 25 Apr 2017 12:31:23 -0400
In-Reply-To: <20170425113954.23121-1-hch@lst.de> (Christoph Hellwig's message
        of "Tue, 25 Apr 2017 13:39:54 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: tj@kernel.org, linux-ide@vger.kernel.org, stable@vger.kernel.org


Christoph,

> The WRITE SAME to TRIM translation rewrites the DATA OUT buffer.  While
> the SCSI code accomodates for this by passing a read-writable buffer
> userspace applications don't cater for this behavior.  In fact it can
> be used to rewrite e.g. a readonly file through mmap and should be
> considered as a security fix.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
