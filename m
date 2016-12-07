From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata-scsi: disable SCT Write Same for the moment
Date: Wed, 7 Dec 2016 16:32:22 -0500
Message-ID: <20161207213222.GC22296@htj.duckdns.org>
References: <20161207212133.3463-1-nicstange@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36826 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932503AbcLGVcY (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 7 Dec 2016 16:32:24 -0500
Content-Disposition: inline
In-Reply-To: <20161207212133.3463-1-nicstange@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: Shaun Tancheff <shaun.tancheff@seagate.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Dec 07, 2016 at 10:21:33PM +0100, Nicolai Stange wrote:
> It can certainly be fixed, but the final release is quite close -- so
> disable SCT Write Same for all ATA devices rather than introducing some
> SCT key buffer allocation schemes at this point.

Applied to libata/for-4.9-fixes.  Will push out soon.

Thanks.

-- 
tejun
