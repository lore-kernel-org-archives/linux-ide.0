From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 5/5] libata/drivers: Add pata_macio, driver Apple PowerMac/PowerBook
 IDE controller
Date: Tue, 01 Dec 2009 21:48:07 +0900
Message-ID: <4B151087.7080606@kernel.org>
References: <20091201070834.6A840B7B63@ozlabs.org> <4B14CD22.4020806@kernel.org> <200912011344.38656.hmacht@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49336 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752389AbZLAMsD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Dec 2009 07:48:03 -0500
In-Reply-To: <200912011344.38656.hmacht@suse.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: hmacht@suse.de
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-ide@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Jeff Garzik <jeff@garzik.org>

On 12/01/2009 09:44 PM, Holger Macht wrote:
> I do not remember any specific reason for using ata_port_schedule_eh(). I
> guess it's just there because the previous implementation used
> it. ata_port_freeze()/abort() might as well work properly. However, I
> would hesitate to change the existing code, because verifying that
> everything works contains quite some effort. There are so many different
> use cases this code can be accessed with and it has to be verified with
> all kind of different hardware to make sure we get no hard
> freezes. Testing that freeze()/abort() in this new driver would be worth a
> try, though. Next time I have setup my test environment again I can verify
> that it also works in the general libata-acpi code.

Yeap, agreed.  It was pretty painful get it right the last time
around, so changing it on a hunch would be a pretty bad idea.  If you
have a chance to try freeze or abort, please keep me posted.

Thanks.

-- 
tejun
