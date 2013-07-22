From: Marc C <marc.ceeeee@gmail.com>
Subject: Re: [PATCH] libata: Add additional queued command opcodes from SATA spec
Date: Mon, 22 Jul 2013 13:42:42 -0700
Message-ID: <7D07DE2D-D421-4E79-AB4B-27566DCB3655@gmail.com>
References: <CAO1A-8DmPXdM-XbzD18aQUYy4+Aph0jVwrSe1_spJJcRM57NNQ@mail.gmail.com> <20130722200014.GA4042@mtj.dyndns.org>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36667 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753873Ab3GVUmp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Jul 2013 16:42:45 -0400
Received: by mail-pa0-f48.google.com with SMTP id kp1so3173039pab.21
        for <linux-ide@vger.kernel.org>; Mon, 22 Jul 2013 13:42:44 -0700 (PDT)
In-Reply-To: <20130722200014.GA4042@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

Hi Tejun,

> Hmmm, are you planning to add code making use of the above new
> commands soon?  If not, why add the opcodes at all?  ata.h isn't
> aiming to contain all possible ATA commands.

                                                        
That is the goal.

I have some out-of-tree user apps that exploit those opcodes
(via uapi). I eventually will have additional patches, but cannot 
submit the pull request for them until the SATA 3.2 spec is public.

Regards,
Marc

On Jul 22, 2013, at 1:00 PM, Tejun Heo <tj@kernel.org> wrote:

> Hello,
> 
> On Fri, Jul 19, 2013 at 06:17:14PM -0700, Marc C wrote:
>> This patch adds the new queued opcodes to the ATA device command
>> list.
>> 
>> Rev 3.0 and 3.1 of the SATA spec introduced the following
>> opcodes:
>> 
>> - NCQ QUEUE MANAGEMENT
>> - SEND FPDMA QUEUED
>> - RECEIVE FPDMA QUEUED
> 
> Hmmm, are you planning to add code making use of the above new
> commands soon?  If not, why add the opcodes at all?  ata.h isn't
> aiming to contain all possible ATA commands.
> 
> Thanks.
> 
> -- 
> tejun

