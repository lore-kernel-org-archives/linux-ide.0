From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH 2/3] libata: acpi: avoid passing NULL to ACPI evaluation
 method
Date: Fri, 14 Mar 2014 22:32:08 +0800
Message-ID: <532312E8.4020001@intel.com>
References: <1394775970-6022-1-git-send-email-aaron.lu@intel.com> <1394775970-6022-3-git-send-email-aaron.lu@intel.com> <20140314125847.GA12613@htj.dyndns.org> <5323115A.7050200@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:4784 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754667AbaCNOcD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 14 Mar 2014 10:32:03 -0400
In-Reply-To: <5323115A.7050200@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On 03/14/2014 10:25 PM, Aaron Lu wrote:
> On 03/14/2014 08:58 PM, Tejun Heo wrote:
>> On Fri, Mar 14, 2014 at 01:46:09PM +0800, Aaron Lu wrote:
>>> If ACPI handle for an ATA device is NULL, we shouldn't call
>>> ata_dev_get_GTF as that function will use handle to do some ACPI
>>> evaluation.
>>
>> This caused a crash, right?  Can you please include what can trigger
>> such oops and how it looks like and reference to the original bug
>> report.  In general, when you're cc'ing stable, please try to provide
>> as much information about the bug as possible so that downstreams have
>> easier time evaluating the importance and risk of the change.  The
>> same goes for the previous patch.
>
> For the 1/3 patch, no crash either. It's just that if CONFIG_PM_RUNTIME
> is not set, ZPODD will not function so building it doesn't make sense.

No bug report for this either, I realized this when I'm preparing a test
build for !CONFIG_PM_RUNTIME and found that I can still select ZPODD.
