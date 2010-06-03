From: Tejun Heo <htejun@gmail.com>
Subject: Re: hibernation hangs with ATA errors (lockup_detector bug)
Date: Thu, 03 Jun 2010 10:17:37 +0200
Message-ID: <4C076521.8050108@gmail.com>
References: <4C03C608.1040600@gmail.com> <20100601135004.GP15159@redhat.com> <4C051D44.7040203@gmail.com> <20100602184459.GA15159@redhat.com> <20100602191336.GA5164@nowhere> <20100602194336.GB5164@nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48483 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988Ab0FCIRo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Jun 2010 04:17:44 -0400
In-Reply-To: <20100602194336.GB5164@nowhere>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Don Zickus <dzickus@redhat.com>, Jeff Garzik <jgarzik@pobox.com>, Jiri Slaby <jirislaby@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-ide@vger.kernel.org

Hello,

On 06/02/2010 09:43 PM, Frederic Weisbecker wrote:
> But I'm eventually surprised about this: stopping the cpu hotplug callbacks
> prevents some ATA resume callbacks to execute.
> 
> Does that mean some ata resume path are done from a cpu hotplug notifier?
> That looks weird.

libata itself doesn't use any cpu hotplug notifier.  It just uses
suspend and resume callbacks.  It looks like somehow IRQ delivery is
screwed up?

Thanks.

-- 
tejun
