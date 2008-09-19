From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/4 v2] ide: Implement disk shock protection support
Date: Thu, 18 Sep 2008 17:47:31 -0700
Message-ID: <200809181747.31715.bzolnier@gmail.com>
References: <87d4j2n3dn.fsf@denkblock.local> <200809181624.54248.bzolnier@gmail.com> <87d4j17ze2.fsf@denkblock.local>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.227]:5636 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755691AbYISAsA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 18 Sep 2008 20:48:00 -0400
Received: by rv-out-0506.google.com with SMTP id k40so171442rvb.1
        for <linux-ide@vger.kernel.org>; Thu, 18 Sep 2008 17:47:59 -0700 (PDT)
In-Reply-To: <87d4j17ze2.fsf@denkblock.local>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Elias Oltmanns <eo@nebensachen.de>
Cc: Jeff Garzik <jeff@garzik.org>, Randy Dunlap <randy.dunlap@oracle.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday 18 September 2008 17:28:05 Elias Oltmanns wrote:
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > On Wednesday 17 September 2008 09:38:37 Elias Oltmanns wrote:
> >> On user request (through sysfs), the IDLE IMMEDIATE command with UNLOAD
> >
> >> FEATURE as specified in ATA-7 is issued to the device and processing of
> >> the request queue is stopped thereafter until the specified timeout
> >> expires or user space asks to resume normal operation. This is supposed
> >> to prevent the heads of a hard drive from accidentally crashing onto the
> >> platter when a heavy shock is anticipated (like a falling laptop expected
> >> to hit the floor). Port resets are deferred whenever a device on that
> >> port is in the parked state.
> >> 
> >> Signed-off-by: Elias Oltmanns <eo@nebensachen.de>
> >
> > applied
> 
> I'm very sorry for responding so late to Tejun's concerns but I got
> bitten by the uaccess bug in recent linux-next discussed on LKML.
> 
> @Bart, one isue raised by Tejun actually applies to this ide patch as
> well. Even though the problem is considerably more complex in the libata
> case than I had bargained for, we are lucky in the ide case. Still, we
> need to move prepar_to_wait() to the top of the while loop. Can you
> please include the following interdiff? It also gets rid of a
> superfluous variable.

done, thanks!
