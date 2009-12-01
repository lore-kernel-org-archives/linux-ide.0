From: Tejun Heo <tj@kernel.org>
Subject: Re: libata hotplug question
Date: Tue, 01 Dec 2009 14:34:08 +0900
Message-ID: <4B14AAD0.4060806@kernel.org>
References: <1259561052.2076.73.camel@pasglop>	 <1259624651.2076.158.camel@pasglop>  <4B1459B5.40504@kernel.org>	 <1259635420.2076.180.camel@pasglop> <1259644647.2076.204.camel@pasglop>	 <4B14A809.8000304@kernel.org> <1259645409.2076.213.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38484 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750750AbZLAFdu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Dec 2009 00:33:50 -0500
In-Reply-To: <1259645409.2076.213.camel@pasglop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org

On 12/01/2009 02:30 PM, Benjamin Herrenschmidt wrote:
>> You didn't schedule any EH actions, right?
> 
> I did the usual ehi_hotplug + freeze

Hmmm.... then I have no idea what happened there.  :-(

>> libata-acpi.c does that.  Setting ATA_DFLAG_DETACH device flag and
>> scheduling EH will do that.  Please take a look at
>> ata_acpi_detach_device() but you must be *sure* that your hot unplug
>> notification is completely reliable.
> 
> Well, it seems to be reliable that way for unplugs. I even debounce it
> both ways but I'm actually considering removing the debounce on unplug.
> 
> I'll let you know how it goes with a custom prereset() that returns
> -ENODEV. How would that differ from ATA_DFLAG_DETACH ?

In effect, they would be the same but if the hotplug notification can
be made reliable, I think using DFLAG_DETACH would be better as
there's already other users doing that (user requested detach and ACPI
dock removal).

Thanks.

-- 
tejun
