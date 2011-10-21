From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [upstream-next] ahci start engine
Date: Fri, 21 Oct 2011 18:38:02 -0400
Message-ID: <4EA1F44A.7020804@pobox.com>
References: <CAN8TOE8mTWrHOZd08RhZttARGsa74fGmB7f044GHScA87PJcyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:46112 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884Ab1JUWiG (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Oct 2011 18:38:06 -0400
Received: by vws1 with SMTP id 1so3343298vws.19
        for <linux-ide@vger.kernel.org>; Fri, 21 Oct 2011 15:38:04 -0700 (PDT)
In-Reply-To: <CAN8TOE8mTWrHOZd08RhZttARGsa74fGmB7f044GHScA87PJcyg@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>

On 10/21/2011 06:27 PM, Brian Norris wrote:
> Hi Jeff,
>
> If you recall, there was an AHCI hardware bug I was working on a while
> back that Tejun helped me solve (or at least mitigate). In the end, a
> patch was pushed to your libata-dev/upstream-next branch at
> kernel.org. Since then, kernel.org went down (along with your tree). I
> only recently located your new github repository, and I can't find the
> patch anywhere. Has it been dropped? This is the patch header leftover
> in my tree:
>
> commit 936f82ad2254a6712175a36daee9517d6b7a4982
> Author: Tejun Heo<tj@kernel.org>
> Date:   Fri Jul 22 11:41:26 2011 +0200
>
>      ahci: start engine only during soft/hard resets
>
>
> I can resubmit the entire patch to you if you'd like. I'd appreciate
> it if this could make it upstream soon.

hum, neither that branch nor the patch appears to exist locally;  I bet 
I accidentally deleted #upstream-next during the move.

Will resuscitate the branch w/ that patch, at github.

	Jeff




