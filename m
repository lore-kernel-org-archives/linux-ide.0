From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH] ide-tape: Don't leak kernel stack information
Date: Mon, 20 Jul 2009 14:49:12 +0200
Message-ID: <9ea470500907200549y24abd998p85440321e6c2f8a9@mail.gmail.com>
References: <200907192115.19958.mb@bu3sch.de>
	 <200907211206.55708.bzolnier@gmail.com>
	 <9ea470500907200345y79911526m15106c755a15b697@mail.gmail.com>
	 <200907211410.11262.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:37269 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753003AbZGTMtO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 20 Jul 2009 08:49:14 -0400
Received: by fxm18 with SMTP id 18so1940164fxm.37
        for <linux-ide@vger.kernel.org>; Mon, 20 Jul 2009 05:49:13 -0700 (PDT)
In-Reply-To: <200907211410.11262.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Michael Buesch <mb@bu3sch.de>, davem@davemloft.net, linux-ide@vger.kernel.org

On Tue, Jul 21, 2009 at 2:10 PM, Bartlomiej
Zolnierkiewicz<bzolnier@gmail.com> wrote:

[..]

> Either it stays the way it is or we may eventually remove it completely
> (if really nothing uses it, though I still don't see much point in it
> given "the deep maintenance" mode of IDE subsystem).

Ok, let's opt for the less intrusive/no breakage option. The deep
maintenance mode argument clearly prevails here.

Acked-by: Borislav Petkov <petkovbb@gmail.com>.

-- 
Regards/Gruss,
Boris
