From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH RFC] ahci: implement handoff quirk
Date: Sat, 11 Apr 2009 10:51:51 -0700
Message-ID: <49E0D8B7.8010206@kernel.org>
References: <485882FE.1060409@kernel.org> <49E0CB5B.3070807@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47758 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757692AbZDKRwL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 11 Apr 2009 13:52:11 -0400
In-Reply-To: <49E0CB5B.3070807@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, "Zhao, Richard" <Richard.Zhao@amd.com>, shane.huang@amd.com

Jeff Garzik wrote:
> We probably need to do this...
> 
> it's not a controller requirement but a BIOS one, so in theory even an
> existing, deployed AHCI 1.2 platform could suddenly require BIOS/OS
> handoff, if a BIOS update suddenly starts doing new and weird stuff in SMI.
> 
> Note that we need to do BIOS/OS handoff upon resume as well as at boot
> time.

Yeah, probably.  Do you know of any system which makes use of this
feature?  I'm a bit uneasy about committing it without any testing.

Thanks.

-- 
tejun
