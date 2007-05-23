From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ata: pata_platform: Disable prereset logic.
Date: Wed, 23 May 2007 10:07:08 +0200
Message-ID: <4653F62C.4070700@gmail.com>
References: <20070523064408.GA29593@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.225]:4880 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756000AbXEWIHZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 23 May 2007 04:07:25 -0400
Received: by nz-out-0506.google.com with SMTP id o37so142887nzf
        for <linux-ide@vger.kernel.org>; Wed, 23 May 2007 01:07:23 -0700 (PDT)
In-Reply-To: <20070523064408.GA29593@linux-sh.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>, Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Paul Mundt wrote:
> On a number of boards the current prereset logic seems to misbehave:
> 
> scsi0 : pata_platform
> ata1: PATA max PIO0 cmd 0xb06001f0 ctl 0xb06003f6 bmdma 0x00000000 irq 0
> ata1: device not ready (errno=-19), forcing hardreset
> ata1: BUG: prereset() requested invalid reset type
> 
> This triggers when there is no card inserted in the slot.
> 
> Simply disabling the prereset gets rid of this, and doesn't seem to cause
> any problems for either PCMCIA or CF cards when they're actually present.

NACK.  The BUG printking needs fixing but you can't just kill
prereset().  Did it work properly on 2.6.21.1?  Can you modify
ata_wait_ready() such that it prints out the status value while waiting?

-- 
tejun
