From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] ide-tape: Don't leak kernel stack information
Date: Tue, 21 Jul 2009 20:36:59 -0700 (PDT)
Message-ID: <20090721.203659.87191935.davem@davemloft.net>
References: <9ea470500907200345y79911526m15106c755a15b697@mail.gmail.com>
	<200907211410.11262.bzolnier@gmail.com>
	<9ea470500907200549y24abd998p85440321e6c2f8a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:53008
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752455AbZGVDgz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Jul 2009 23:36:55 -0400
In-Reply-To: <9ea470500907200549y24abd998p85440321e6c2f8a9@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@googlemail.com
Cc: bzolnier@gmail.com, mb@bu3sch.de, linux-ide@vger.kernel.org

From: Borislav Petkov <petkovbb@googlemail.com>
Date: Mon, 20 Jul 2009 14:49:12 +0200

> On Tue, Jul 21, 2009 at 2:10 PM, Bartlomiej
> Zolnierkiewicz<bzolnier@gmail.com> wrote:
> 
> [..]
> 
>> Either it stays the way it is or we may eventually remove it completely
>> (if really nothing uses it, though I still don't see much point in it
>> given "the deep maintenance" mode of IDE subsystem).
> 
> Ok, let's opt for the less intrusive/no breakage option. The deep
> maintenance mode argument clearly prevails here.
> 
> Acked-by: Borislav Petkov <petkovbb@gmail.com>.

Agreed, applied and queued to -stable, thanks.
