From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/3] libata: acpi: avoid passing NULL to ACPI evaluation
 method
Date: Fri, 14 Mar 2014 08:58:47 -0400
Message-ID: <20140314125847.GA12613@htj.dyndns.org>
References: <1394775970-6022-1-git-send-email-aaron.lu@intel.com>
 <1394775970-6022-3-git-send-email-aaron.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:46376 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754328AbaCNM6u (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Mar 2014 08:58:50 -0400
Received: by mail-qc0-f170.google.com with SMTP id e9so2788495qcy.15
        for <linux-ide@vger.kernel.org>; Fri, 14 Mar 2014 05:58:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1394775970-6022-3-git-send-email-aaron.lu@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: linux-ide@vger.kernel.org

On Fri, Mar 14, 2014 at 01:46:09PM +0800, Aaron Lu wrote:
> If ACPI handle for an ATA device is NULL, we shouldn't call
> ata_dev_get_GTF as that function will use handle to do some ACPI
> evaluation.

This caused a crash, right?  Can you please include what can trigger
such oops and how it looks like and reference to the original bug
report.  In general, when you're cc'ing stable, please try to provide
as much information about the bug as possible so that downstreams have
easier time evaluating the importance and risk of the change.  The
same goes for the previous patch.

Thanks.

-- 
tejun
