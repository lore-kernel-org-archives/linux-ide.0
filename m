From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [RFC] add DMA setup FIS auto-activate feature
Date: Thu, 23 Jul 2009 00:18:33 -0600
Message-ID: <4A6800B9.10706@gmail.com>
References: <1248320734.9035.22.camel@sli10-desk.sh.intel.com> <4A67E00F.40808@pobox.com> <20090723054007.GA7473@sli10-desk.sh.intel.com> <4A67F8ED.2070204@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.248]:59913 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990AbZGWGQW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Jul 2009 02:16:22 -0400
Received: by an-out-0708.google.com with SMTP id d40so938670and.1
        for <linux-ide@vger.kernel.org>; Wed, 22 Jul 2009 23:16:22 -0700 (PDT)
In-Reply-To: <4A67F8ED.2070204@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Shaohua Li <shaohua.li@intel.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide <linux-ide@vger.kernel.org>

On 07/22/2009 11:45 PM, Tejun Heo wrote:
> Shaohua Li wrote:
>>> IIRC, not all NCQ-capable controllers support this feature...  SATA 1.0
>>> hardware may not behave properly in response, no?
>> It appears the AHCI spec doesn't define a HBA capability about this
>> feature, but I'm likely wrong as I'm not quite familar with SATA.
>
> IIRC, AA is in the ahci spec from rev 1.0, so if controllers implement
> the spec correctly, it should work.  But even for ahcis, if we enable
> it by default, I'm fairly sure we'll be met by a number of unpleasant
> surprises.  Not sure whether doing that would be worth the trouble or
> not.

There's definitely a controller dependency here, as SATA 1.0 hardware 
won't respond properly if this feature is turned on. Likely we need a 
host flag to indicate whether the controller supports auto-activate. It 
seems like AHCI shouldn't be a problem, but it's not clear if any other 
controller types would support it.

As far as busted hardware not handling it properly.. well if it just 
ignores the enabling then that's not a problem as things will just work 
as before. There could be devices that claim support, don't ignore it 
but don't handle it properly.. but realistically the only way we can 
find out if that's the case is turning it on and see what breaks.
