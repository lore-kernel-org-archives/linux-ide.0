From: Alexander Clausen <alex@gc-web.de>
Subject: Re: Suspend w/ sata_promise
Date: Sun, 16 Nov 2008 17:43:30 +0100
Message-ID: <49204DB2.2040400@gc-web.de>
References: <49202CB0.60507@gc-web.de> <18720.18615.938839.921189@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from server2.gc-web.de ([88.198.38.110]:58286 "EHLO mail.gc-web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750952AbYKPQne (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 Nov 2008 11:43:34 -0500
In-Reply-To: <18720.18615.938839.921189@harpo.it.uu.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-ide@vger.kernel.org

Mikael Pettersson wrote:
> 
> There is currently no suspend support in the sata_promise driver, so
> whatever happens at suspend and resume is up to libata and ACPI.
> 
> Do you have anything connected to that mobo's VIA SATA ports? If not,
> you could move the disk(s) from the Promise controller to the VIA
> controller just to see how the machine behaves over repeated suspend/resume
> cycles. (I'm not suggesting you move the disks permanently, this would
> just be a data gathering experiment.)

Yeah, I tried moving the disk, but for whatever reasons, the controller BIOS did not detect it, so
it did not boot. Can the linux driver detect drives that the BIOS can't? If so, I can retry with
another boot medium.

Alex
