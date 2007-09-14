From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH]libata-acpi: add ACPI _PSx method
Date: Fri, 14 Sep 2007 11:11:56 +0800
Message-ID: <1189739516.6330.12.camel@sli10-conroe.sh.intel.com>
References: <1189737938.6330.7.camel@sli10-conroe.sh.intel.com>
	 <46E9FE3F.5040003@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:11536 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750857AbXIND0y (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 Sep 2007 23:26:54 -0400
In-Reply-To: <46E9FE3F.5040003@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide <linux-ide@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Thu, 2007-09-13 at 23:21 -0400, Jeff Garzik wrote:
> Shaohua Li wrote:
> > ACPI spec (ver 3.0a, p289) requires IDE power on/off executes ACPI _PSx
> > methods. As recently most PATA drivers use libata, this patch adds _PSx
> > method support in libata. ACPI spec doesn't mention if SATA requires the
> > same _PSx method, but executing _PSx for SATA should be ok I think.
> > 
> > Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> 
> Where/how can a need for this change be produced?
I run suspend/resume test in a Thinkpad R40 laptop, which implements
_PSx method in IDE devices. But I'd say I didn't see visible difference
in the suspend/resume circle w/wo the patch in the test laptop. This is
just to make Linux match with ACPI spec. Maybe this changes other
laptops.

Thanks,
Shaohua
