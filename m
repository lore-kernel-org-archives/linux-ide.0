From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/2] libata: force disable trim for SuperSSpeed S238
Date: Tue, 14 Jul 2015 14:54:18 -0400
Message-ID: <20150714185418.GB2273@mtj.duckdns.org>
References: <1436873314-22563-1-git-send-email-arne_f@ipfire.org>
 <1436873314-22563-3-git-send-email-arne_f@ipfire.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:36130 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827AbbGNSyW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Jul 2015 14:54:22 -0400
Received: by qkdv3 with SMTP id v3so12844568qkd.3
        for <linux-ide@vger.kernel.org>; Tue, 14 Jul 2015 11:54:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1436873314-22563-3-git-send-email-arne_f@ipfire.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arne Fitzenreiter <arne_f@ipfire.org>
Cc: linux-ide@vger.kernel.org

On Tue, Jul 14, 2015 at 01:28:34PM +0200, Arne Fitzenreiter wrote:
> this disc lose blocks if trim is used. most time the partition
> area.

This device loses blocks, often the partition table area, on trim.
Disable TRIM.

Signed-off-by:...
Cc: stable@vger.kernel.org  (the previous patch too)

Also, how did you learn that the device loses data on trim?  Is there
a report?  If this is something you noticed yourself, can you please
detail what you observed and how reproducible the problem is?

Thanks.

-- 
tejun
