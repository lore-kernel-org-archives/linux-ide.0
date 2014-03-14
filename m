From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 0/3] ata: acpi/zpodd: some small fixes
Date: Fri, 14 Mar 2014 11:24:24 -0400
Message-ID: <20140314152424.GM12613@htj.dyndns.org>
References: <1394775970-6022-1-git-send-email-aaron.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:34080 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755198AbaCNPY3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Mar 2014 11:24:29 -0400
Received: by mail-qc0-f180.google.com with SMTP id x3so3010438qcv.39
        for <linux-ide@vger.kernel.org>; Fri, 14 Mar 2014 08:24:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1394775970-6022-1-git-send-email-aaron.lu@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: linux-ide@vger.kernel.org

On Fri, Mar 14, 2014 at 01:46:07PM +0800, Aaron Lu wrote:
> Two small fix for libata-acpi and libata-zpodd and one simplification
> for libata-zpodd.
> 
> Aaron Lu (3):
>   libata: zpodd: should depend on PM_RUNTIME
>   libata: acpi: avoid passing NULL to ACPI evaluation method
>   libata: zpodd: eliminate odd_can_poweroff

Applied 1-3 to libata/for-3.15 w/ stable cc dropped.

Thanks.

-- 
tejun
