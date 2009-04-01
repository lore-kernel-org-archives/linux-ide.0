From: Tejun Heo <tj@kernel.org>
Subject: Re: ata_check_status_mmio exception kernel panic
Date: Wed, 01 Apr 2009 12:37:58 +0900
Message-ID: <49D2E196.3040509@kernel.org>
References: <3fb94e50903312006y12717b8dh7dd7769f3f5b1dda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55720 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754724AbZDADhc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 31 Mar 2009 23:37:32 -0400
In-Reply-To: <3fb94e50903312006y12717b8dh7dd7769f3f5b1dda@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sagar Borikar <sagar.borikar@gmail.com>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>

Hello,

Sagar Borikar wrote:
> We are facing random kernel panics on drive removal when IO is
> happening to RAID. Note that kernel panic is random and not every time
> it happens. This is mips based production system and kernel is 2.6.18.
> Unfortunately we can't upgrade the kernel as its on field.

2.6.18 is way too old and the mentioned function has been removed a
lont time ago in favor of iomem support.  Can you please give a shot
at more recent kernel?

Thanks.

-- 
tejun
