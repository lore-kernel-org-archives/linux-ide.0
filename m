From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 5/5] libata/drivers: Add pata_macio, driver Apple PowerMac/PowerBook
 IDE controller
Date: Wed, 02 Dec 2009 08:44:15 +0900
Message-ID: <4B15AA4F.5040309@kernel.org>
References: <20091201070834.6A840B7B63@ozlabs.org>	 <4B14CD22.4020806@kernel.org> <1259709552.2076.1053.camel@pasglop>	 <4B15A67C.2030102@kernel.org> <1259710543.2076.1054.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55117 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753191AbZLAXmr (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Dec 2009 18:42:47 -0500
In-Reply-To: <1259710543.2076.1054.camel@pasglop>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Jeff Garzik <jeff@garzik.org>, Holger Macht <hmacht@suse.de>

On 12/02/2009 08:35 AM, Benjamin Herrenschmidt wrote:
> On Wed, 2009-12-02 at 08:27 +0900, Tejun Heo wrote:
>> Conceptually freeze would be more approriate but the side effect is
>> that the port is frozen and EH will try to thaw it by resetting it.
>> So, abort would work better.
> 
> BTW. For a plug event, what should I do ? freeze is fine ? Or just
> schedule eh ? Right now, when plugging I see an exception Emask 0x10
> etc... message in the log when plugging which isn't totally nice :-)

freeze() and please don't fight the EH messages from low level driver.
If it's too much, we need to update core layer but given the variety
of phy related bugs, I think we need those messages.

Thanks.

-- 
tejun
