From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/2] libata: Blacklist queued TRIM on Samsung SSD 850 Pro
Date: Fri, 27 Mar 2015 15:23:52 -0400
Message-ID: <20150327192352.GC638@htj.duckdns.org>
References: <1427483841-23401-1-git-send-email-martin.petersen@oracle.com>
 <1427483841-23401-2-git-send-email-martin.petersen@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:34162 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753266AbbC0TX4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 27 Mar 2015 15:23:56 -0400
Content-Disposition: inline
In-Reply-To: <1427483841-23401-2-git-send-email-martin.petersen@oracle.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org, stable@vger.kernel.org

On Fri, Mar 27, 2015 at 03:17:21PM -0400, Martin K. Petersen wrote:
> Blacklist queued TRIM on this drive for now.
> 
> Reported-by: Stefan Keller <linux-list@zahlenfresser.de>
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> CC: stable@vger.kernel.org

Applied 1-2 to libata/for-4.0-fixes.

Thanks.

-- 
tejun
