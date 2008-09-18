From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/4 v2] ide: Implement disk shock protection support
Date: Thu, 18 Sep 2008 16:24:53 -0700
Message-ID: <200809181624.54248.bzolnier@gmail.com>
References: <87d4j2n3dn.fsf@denkblock.local> <20080917163144.9870.59732.stgit@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.232]:59350 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756268AbYIRXxm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Sep 2008 19:53:42 -0400
Received: by rv-out-0506.google.com with SMTP id k40so151227rvb.1
        for <linux-ide@vger.kernel.org>; Thu, 18 Sep 2008 16:53:42 -0700 (PDT)
In-Reply-To: <20080917163144.9870.59732.stgit@denkblock.local>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: Jeff Garzik <jeff@garzik.org>, Randy Dunlap <randy.dunlap@oracle.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wednesday 17 September 2008 09:38:37 Elias Oltmanns wrote:
> On user request (through sysfs), the IDLE IMMEDIATE command with UNLOAD
> FEATURE as specified in ATA-7 is issued to the device and processing of
> the request queue is stopped thereafter until the specified timeout
> expires or user space asks to resume normal operation. This is supposed
> to prevent the heads of a hard drive from accidentally crashing onto the
> platter when a heavy shock is anticipated (like a falling laptop expected
> to hit the floor). Port resets are deferred whenever a device on that
> port is in the parked state.
> 
> Signed-off-by: Elias Oltmanns <eo@nebensachen.de>

applied
