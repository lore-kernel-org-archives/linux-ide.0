From: Jesse Stockall <stockall@magma.ca>
Subject: Re: [PATCH/RFC] PATA port on SATA controllers
Date: Fri, 08 Oct 2004 10:08:44 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1097244524.5480.0.camel@homer.blizzard.org>
References: <20041003034752.55539.qmail@web60306.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx2.magma.ca ([206.191.0.250]:50610 "EHLO mx2.magma.ca")
	by vger.kernel.org with ESMTP id S269988AbUJHOHK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Oct 2004 10:07:10 -0400
In-Reply-To: <20041003034752.55539.qmail@web60306.mail.yahoo.com>
List-Id: linux-ide@vger.kernel.org
To: Erik Benada <erikbenada@yahoo.ca>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On Sat, 2004-10-02 at 23:47, Erik Benada wrote:
> Hi Jeff,
> 
> this is the first attempt to properly support SATA and PATA ports on the same controller.
> Patch is against 2.6.9-rc3.
> 
> Changes:
> - ata_probe_ent: multiple ata_port_operations, per port flags
> - libata-core.c: changes for new ata_probe_ent + minor cleanups (mostly in comments)
> - sata_promise.c: PATA port support using new infrastructure
> 
> Tested on my PDC20378.
> 

Works on my PDC20376.

Jesse

-- 
Jesse Stockall <stockall@magma.ca>

