From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH] hook ACPI _PSx method to IDE power on/off
Date: Fri, 03 Aug 2007 08:44:56 +0800
Message-ID: <1186101896.25162.0.camel@sli10-conroe.sh.intel.com>
References: <1186035248.29979.5.camel@sli10-conroe.sh.intel.com>
	 <20070802123145.GA30304@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:18169 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753068AbXHCAuU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 2 Aug 2007 20:50:20 -0400
In-Reply-To: <20070802123145.GA30304@srcf.ucam.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux acpi <linux-acpi@vger.kernel.org>, linux-ide@vger.kernel.org, Len Brown <lenb@kernel.org>

On Thu, 2007-08-02 at 13:31 +0100, Matthew Garrett wrote:
> On Thu, Aug 02, 2007 at 02:14:08PM +0800, Shaohua Li wrote:
> > ACPI spec defines the sequence of IDE power on/off:
> 
> Most distributions seem to be using the libata PATA code now - any plans 
> to implement it there as well?
Ok, I'll look at it too.

Thanks,
Shaohua
