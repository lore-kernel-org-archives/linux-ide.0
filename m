From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] libata: remove SCT WRITE SAME support
Date: Tue, 25 Apr 2017 12:33:55 -0400
Message-ID: <yq1inlsfnv0.fsf@oracle.com>
References: <20170425122652.31763-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:22354 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1176488AbdDYQeL (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 25 Apr 2017 12:34:11 -0400
In-Reply-To: <20170425122652.31763-1-hch@lst.de> (Christoph Hellwig's message
        of "Tue, 25 Apr 2017 14:26:52 +0200")
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: tj@kernel.org, linux-ide@vger.kernel.org


Christoph,

> This was already disabled a while ago because it caused I/O errors,
> and it's severly getting into the way of the discard / write zeroes
> rework.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
