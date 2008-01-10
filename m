From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [patch]workaround suspend bug for ACPI IDE
Date: Thu, 10 Jan 2008 22:55:43 +0100
Message-ID: <200801102255.45037.bzolnier@gmail.com>
References: <1199928392.21141.13.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:24096 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296AbYAJWRY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 10 Jan 2008 17:17:24 -0500
Received: by ug-out-1314.google.com with SMTP id z38so377672ugc.16
        for <linux-ide@vger.kernel.org>; Thu, 10 Jan 2008 14:17:22 -0800 (PST)
In-Reply-To: <1199928392.21141.13.camel@sli10-desk.sh.intel.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-ide <linux-ide@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Thursday 10 January 2008, Shaohua Li wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=9673
> ACPI _PS3 cause S4 breaks in the second attempt. The system has a _PS3
> method for IDE, which will call into SMM mode. Currently we haven't clue
> why just the second attempt fails, as it's totally in BIOS code, so
> blacklist the system so far for 2.6.24.
> 
> A possible suspect is ACPI NVS isn't save/restore, we will revisit the
> bug after linux does ACPI NVS save/restore.
> 
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>

applied, I did three minor changes while at it:

* fixed some scripts/checkpatch.pl complaints
* const-ified ide_acpi_dmi_table[]
* credited Mikko using 'Reported-by:' tag

Thanks,
Bart
