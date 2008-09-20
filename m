From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/2 v4] libata: Implement disk shock protection support
Date: Sat, 20 Sep 2008 19:55:10 -0400
Message-ID: <48D58D5E.30508@kernel.org>
References: <87tzcb7r0r.fsf@denkblock.local>	<20080919214400.7183.64611.stgit@denkblock.local>	<48D4805A.3090707@kernel.org> <87abe37462.fsf@denkblock.local>	<87wsh75avl.fsf@denkblock.local> <20080920213418.16970.37782.stgit@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39935 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751539AbYITX6m (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 20 Sep 2008 19:58:42 -0400
In-Reply-To: <20080920213418.16970.37782.stgit@denkblock.local>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Elias Oltmanns wrote:
> On user request (through sysfs), the IDLE IMMEDIATE command with UNLOAD
> FEATURE as specified in ATA-7 is issued to the device and processing of
> the request queue is stopped thereafter until the specified timeout
> expires or user space asks to resume normal operation. This is supposed
> to prevent the heads of a hard drive from accidentally crashing onto the
> platter when a heavy shock is anticipated (like a falling laptop
> expected to hit the floor). In fact, the whole port stops processing
> commands until the timeout has expired in order to avoid any resets due
> to failed commands on another device.
> 
> Signed-off-by: Elias Oltmanns <eo@nebensachen.de>

Acked-by: Tejun Heo <tj@kernel.org>

As for completion, yes, I think it would be nice to update complete
such that multiple complete_all() calls don't overflow and completion
can be used for this type of usage.  Anyways, that's for another day I
guess.

Thanks.

-- 
tejun
