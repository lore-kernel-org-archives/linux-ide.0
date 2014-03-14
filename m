From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: Fix SC1200 dependencies
Date: Fri, 14 Mar 2014 10:43:30 -0400
Message-ID: <20140314144330.GK12613@htj.dyndns.org>
References: <20140314154131.75f5a2a0@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:37237 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754614AbaCNOnd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Mar 2014 10:43:33 -0400
Received: by mail-qc0-f180.google.com with SMTP id x3so2904876qcv.25
        for <linux-ide@vger.kernel.org>; Fri, 14 Mar 2014 07:43:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140314154131.75f5a2a0@endymion.delvare>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-ide@vger.kernel.org

On Fri, Mar 14, 2014 at 03:41:31PM +0100, Jean Delvare wrote:
> The SC1200 is a SoC based on the Geode GX1 32-bit x86 processor, so
> its drivers are only needed on this architecture, except for build
> testing purpose.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Tejun Heo <tj@kernel.org>

Applied to libata/for-3.15.

Thanks.

-- 
tejun
