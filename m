From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: make ata_port_operations const
Date: Mon, 7 Aug 2017 09:29:21 -0700
Message-ID: <20170807162920.GA537256@devbig577.frc2.facebook.com>
References: <1502101922-13313-1-git-send-email-bhumirks@gmail.com>
 <20170807150727.GD4050379@devbig577.frc2.facebook.com>
 <CAOH+1jEQy3PrExruDLWetVd=iWYX3sf13Ku5G5CUUbJGADsNvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:35458 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751443AbdHGQ3Z (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 7 Aug 2017 12:29:25 -0400
Content-Disposition: inline
In-Reply-To: <CAOH+1jEQy3PrExruDLWetVd=iWYX3sf13Ku5G5CUUbJGADsNvw@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>, b.zolnierkie@samsung.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello,

On Mon, Aug 07, 2017 at 08:54:21PM +0530, Bhumika Goyal wrote:
> I compiled the .o files and checked the size before and after
> compilation. After making the structure const, bytes should move from
> data to text segment of the memory and this is what happened. So, this
> is how I tested it.

Ah, I see, so the port_operations is never used directly.  I'm not
sure whether it'd be a good idea to selectively pick these and makr
them const.  Let's just leave them be.

Thanks.

-- 
tejun
