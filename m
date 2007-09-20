From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH]libata-acpi: add ACPI _PSx method
Date: Thu, 20 Sep 2007 18:00:17 -0400
Message-ID: <46F2ED71.3070603@pobox.com>
References: <1189737938.6330.7.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:36635 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750913AbXITWAV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 20 Sep 2007 18:00:21 -0400
In-Reply-To: <1189737938.6330.7.camel@sli10-conroe.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-ide <linux-ide@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Tejun Heo <htejun@gmail.com>

Shaohua Li wrote:
> ACPI spec (ver 3.0a, p289) requires IDE power on/off executes ACPI _PSx
> methods. As recently most PATA drivers use libata, this patch adds _PSx
> method support in libata. ACPI spec doesn't mention if SATA requires the
> same _PSx method, but executing _PSx for SATA should be ok I think.
> 
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>

ahci and sata_sil24 directly power off components, so it seems quite 
unwise for "modern" SATA controllers.

ISTR Tejun, when he cleaned up libata-acpi, finally figured out a good 
way to distinguish ACPI's idea of "IDE" -- which sometimes includes the 
legacy programming mode of SATA controllers, and a controller running a 
modern programming mode.

Your best bet is to use a similar test when deciding when to execute 
_PSx.  Or, you could simply be conservative and only do it for PATA.

outside of those issues, the rest of the patch looks ok.

