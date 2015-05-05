From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/4] libata: Allow NCQ TRIM to be enabled or disabled
 with a module parameter
Date: Tue, 5 May 2015 09:31:06 -0400
Message-ID: <20150505133106.GK1971@htj.duckdns.org>
References: <1430790861-30066-1-git-send-email-martin.petersen@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42]:34594 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423462AbbEENbK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 5 May 2015 09:31:10 -0400
Received: by qgfi89 with SMTP id i89so80925468qgf.1
        for <linux-ide@vger.kernel.org>; Tue, 05 May 2015 06:31:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1430790861-30066-1-git-send-email-martin.petersen@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: hare@suse.de, linux-ide@vger.kernel.org

On Mon, May 04, 2015 at 09:54:18PM -0400, Martin K. Petersen wrote:
> We have started seeing SSD firmware updates introduce support for queued
> TRIM. Sadly, in most cases this support is completely untested and can
> lead to either errors or data corruption.
> 
> Add two libata force flags that can be used to either enable or disable
> queued TRIM support.
> 
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

Applied 1-4 to libata/for-4.2.

Thanks.

-- 
tejun
