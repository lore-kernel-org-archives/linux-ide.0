From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH 2/3] libata: acpi: avoid passing NULL to ACPI evaluation
 method
Date: Fri, 14 Mar 2014 22:25:30 +0800
Message-ID: <5323115A.7050200@intel.com>
References: <1394775970-6022-1-git-send-email-aaron.lu@intel.com> <1394775970-6022-3-git-send-email-aaron.lu@intel.com> <20140314125847.GA12613@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:32765 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754491AbaCNOZC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 Mar 2014 10:25:02 -0400
In-Reply-To: <20140314125847.GA12613@htj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On 03/14/2014 08:58 PM, Tejun Heo wrote:
> On Fri, Mar 14, 2014 at 01:46:09PM +0800, Aaron Lu wrote:
>> If ACPI handle for an ATA device is NULL, we shouldn't call
>> ata_dev_get_GTF as that function will use handle to do some ACPI
>> evaluation.
> 
> This caused a crash, right?  Can you please include what can trigger
> such oops and how it looks like and reference to the original bug
> report.  In general, when you're cc'ing stable, please try to provide
> as much information about the bug as possible so that downstreams have
> easier time evaluating the importance and risk of the change.  The
> same goes for the previous patch.

It shouldn't cause a crash, just some error messages from ACPICA I
think. There isn't a bug for it right now, I have only some vague
memory that I saw such error messages when dealing with some other bugs
some time ago. So perhaps I shouldn't add the stable tag, sorry for
that, this seems to belong to the 'this patch solves a potential
problem' case...

For the 1/3 patch, no crash either. It's just that if CONFIG_PM_RUNTIME
is not set, ZPODD will not function so building it doesn't make sense.

Thanks,
Aaron
