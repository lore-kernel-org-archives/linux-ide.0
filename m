From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: Fix regression when the NCQ Send and Receive log
 page is absent
Date: Thu, 21 May 2015 17:53:56 -0400
Message-ID: <20150521215356.GC4914@htj.duckdns.org>
References: <1432079057-11262-1-git-send-email-martin.petersen@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:32956 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422686AbbEUVyA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 21 May 2015 17:54:00 -0400
Received: by qcblr10 with SMTP id lr10so405952qcb.0
        for <linux-ide@vger.kernel.org>; Thu, 21 May 2015 14:53:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1432079057-11262-1-git-send-email-martin.petersen@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org, sergey.senozhatsky@gmail.com

On Tue, May 19, 2015 at 07:44:17PM -0400, Martin K. Petersen wrote:
> Commit 5d3abf8ff67f allowed us to fall back to the unqueued READ LOG
> variant if the queued version failed. However, if the device did not
> support the page at all we would end up looping due to a merge snafu.
> 
> Ensure we only take the fallback path once.

Applied w/ commit title added in the description.

Thanks.

-- 
tejun
