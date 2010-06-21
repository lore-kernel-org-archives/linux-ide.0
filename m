From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 12/12] usb: use IRQ watching
Date: Mon, 21 Jun 2010 15:51:25 +0200
Message-ID: <4C1F6E5D.5030809@kernel.org>
References: <1276443098-20653-1-git-send-email-tj@kernel.org> <1276443098-20653-13-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57366 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932388Ab0FUNwJ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 21 Jun 2010 09:52:09 -0400
In-Reply-To: <1276443098-20653-13-git-send-email-tj@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: mingo@elte.hu, tglx@linutronix.de, bphilips@suse.de, yinghai@kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, jeff@garzik.org, linux-ide@vger.kernel.org, stern@rowland.harvard.edu, gregkh@suse.de, khali@linux-fr.org

On 06/13/2010 05:31 PM, Tejun Heo wrote:
> Ask IRQ subsystem to watch HCD IRQ line after initialization.  This at
> least keeps USB ports which are occupied on initialization working and
> eases bug reporting and debugging.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Greg, if you think the change is okay, can you please ack it?  Also,
would it be okay to route this through irq tree?

Thanks.

-- 
tejun
