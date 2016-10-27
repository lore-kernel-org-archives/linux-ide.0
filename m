From: Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH] ata: piix: wait for end of asynchronous probing
 before
Date: Thu, 27 Oct 2016 14:59:35 -0400
Message-ID: <20161027185935.GA17657@htj.duckdns.org>
References: <1476722704-12839-1-git-send-email-clabbe.montjoie@gmail.com>
 <20161019172848.GD18532@htj.duckdns.org>
 <CAL_Jsq+HPd2Ftm7cDD4rpT6jx=EgS9nX+_WiwRcxhpPbi=85xQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+HPd2Ftm7cDD4rpT6jx=EgS9nX+_WiwRcxhpPbi=85xQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Corentin Labbe <clabbe.montjoie@gmail.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-ide@vger.kernel.org

Hello, Rob.

On Thu, Oct 27, 2016 at 01:55:19PM -0500, Rob Herring wrote:
> Seems like this is mixing async drv probe and async scsi scan and the
> problem is in the latter? I don't think async drv probe should have
> any problems. If a driver probe starts some async operation, then it
> seems to me that it is its responsibility to wait for completion in
> remove().

I'm not sure about that.  The async operation synchronization isn't
per-driver or module.  Both during boot and module operations, they're
synchronized globally, which makes sense given its purpose and that's
also why we don't see these brekages without this debug option.  It
doesn't make sense to me to add a whole new set of behaviors just for
a debug option.

Thanks.

-- 
tejun
