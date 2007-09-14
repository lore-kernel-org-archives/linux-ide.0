From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH]libata-acpi: add ACPI _PSx method
Date: Thu, 13 Sep 2007 23:21:35 -0400
Message-ID: <46E9FE3F.5040003@pobox.com>
References: <1189737938.6330.7.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45648 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750814AbXINDVn (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 13 Sep 2007 23:21:43 -0400
In-Reply-To: <1189737938.6330.7.camel@sli10-conroe.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-ide <linux-ide@vger.kernel.org>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

Shaohua Li wrote:
> ACPI spec (ver 3.0a, p289) requires IDE power on/off executes ACPI _PSx
> methods. As recently most PATA drivers use libata, this patch adds _PSx
> method support in libata. ACPI spec doesn't mention if SATA requires the
> same _PSx method, but executing _PSx for SATA should be ok I think.
> 
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>

Where/how can a need for this change be produced?

	Jeff



