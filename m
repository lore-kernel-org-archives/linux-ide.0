From: "zhao, forrest" <forrest.zhao@intel.com>
Subject: Re: [PATCH 3/6] The definition of ahci_port_standby()
	and	ahci_port_spinup()
Date: Fri, 02 Jun 2006 17:01:53 +0800
Message-ID: <1149238913.29552.7.camel@forrest26.sh.intel.com>
References: <1149234328.13451.56.camel@forrest26.sh.intel.com>
	 <447FF381.4060707@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:26160 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751349AbWFBJNl (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 2 Jun 2006 05:13:41 -0400
In-Reply-To: <447FF381.4060707@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hannes Reinecke <hare@suse.de>
Cc: jeff@garzik.org, axboe@suse.de, htejun@gmail.com, jeremy@goop.org, lkml@rtr.ca, linux-ide@vger.kernel.org

On Fri, 2006-06-02 at 10:14 +0200, Hannes Reinecke wrote:
> Did you actually test with staggered-spinup and/or cold-presence
> detection? I just added them per spec but never got a chance to test
> them here.

We have no mobile platform in our lab, which support staggered-spinup or
cold presence detection. I would test it when the newest chipset is
available. 

> And: it might be an idea to rename the HOST_CAP bits to be consistent
> with those printed during initialisation. It's bad enough as it is (ie
> the spec uses different abbrevs than the implementation), but we should
> try to be consistent within the implementation.
> I would rename them to HOST_CAP_STAG and HOST_CAP_SLUM.

Agree. When reading code, I need to translate the MACRO into the abbrevs
in spec to understand the meaning.

> Add slumber mode: libata-core used to issue a port reset with an
> implicit SLUMBER/PARTIAL mode disable. So after a reset we might not be
> able to put the device into SLUMBER mode even if supported.
> What was the reasoning for this?

I have the same question. Maybe the original author of libata-core.c can
help answer it.
