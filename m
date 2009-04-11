From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH RFC] ahci: implement handoff quirk
Date: Sat, 11 Apr 2009 12:54:51 -0400
Message-ID: <49E0CB5B.3070807@garzik.org>
References: <485882FE.1060409@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:56235 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753280AbZDKQy4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 11 Apr 2009 12:54:56 -0400
In-Reply-To: <485882FE.1060409@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, "Zhao, Richard" <Richard.Zhao@amd.com>, shane.huang@amd.com

Tejun Heo wrote:
> ahci 1.2 has an exciting! new feature called BIOS/OS handoff which
> basically is there to allow BIOS to keep tinkering with the controller
> even after OS starts executing.  I have no idea what this is useful
> for but it's there and we need to do it.
> 
> This patch implements the handoff as FIXUP_HEADER as the controller
> needs to be claimed before the OS changes any configuration including
> IRQ routing.
> 
> I'm yet to see any controller which actually requires this, so it's
> not for inclusion yet.  Maybe keep this in a separate branch?
> 
> RFC, DON'T COMMIT

We probably need to do this...

it's not a controller requirement but a BIOS one, so in theory even an 
existing, deployed AHCI 1.2 platform could suddenly require BIOS/OS 
handoff, if a BIOS update suddenly starts doing new and weird stuff in SMI.

Note that we need to do BIOS/OS handoff upon resume as well as at boot time.

	Jeff



