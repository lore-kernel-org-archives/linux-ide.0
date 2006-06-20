From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] libata: implement per-dev EH action mask	eh_info->dev_action[]
Date: Tue, 20 Jun 2006 17:08:32 +0900
Message-ID: <4497AD00.6000703@gmail.com>
References: <20060619092723.GF11755@htj.dyndns.org> <1150786964.7132.117.camel@forrest26.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.196]:32077 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964991AbWFTIIb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Jun 2006 04:08:31 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1941335nze
        for <linux-ide@vger.kernel.org>; Tue, 20 Jun 2006 01:08:30 -0700 (PDT)
In-Reply-To: <1150786964.7132.117.camel@forrest26.sh.intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "zhao, forrest" <forrest.zhao@intel.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

zhao, forrest wrote:
> On Mon, 2006-06-19 at 18:27 +0900, Tejun Heo wrote:
>> Note that per-dev actions
>> can still be specified at port-level and it has the same effect of
>> specifying the action for all devices on the port.
>>
> 
> Why not use eh_info->action for port-level only, and eh_info->dev_action
> [] for device-level only?
>>From my understanding, this clear separation can at least make code easy
> to read.

The distinction between port-wide (later it becomes link-wide) and 
device-wide EH operations is meaningful only for PATA devices.  For a 
SATA LLD, device-wide operations is port-wide operation and using 
different fields doesn't make much sense.

So, I chose to put a bit more complexity where those per-dev actions are 
implemented while allowing LLDs and other parts of EH not to distinguish 
between those two unless it specifically wants to.

-- 
tejun
