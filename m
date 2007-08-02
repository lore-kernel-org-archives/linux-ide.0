From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: ST340823A disk size issue
Date: Thu, 2 Aug 2007 02:33:28 +0200
Message-ID: <200708020233.28128.bzolnier@gmail.com>
References: <20070801092903.GA1199@nalle> <20070801215003.GA1864@nalle> <200708020019.25742.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:59281 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752138AbXHBAez (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Aug 2007 20:34:55 -0400
Received: by mu-out-0910.google.com with SMTP id i10so454359mue
        for <linux-ide@vger.kernel.org>; Wed, 01 Aug 2007 17:34:53 -0700 (PDT)
In-Reply-To: <200708020019.25742.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mikko Rapeli <mikko.rapeli@iki.fi>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Thursday 02 August 2007, Bartlomiej Zolnierkiewicz wrote:

> Otherwise this patch looks fine and is a bit simpler than my patch.
> 
> If you fix the printk, add patch description (can use the one from my patch)
> and add "Signed-off-by:" I would happily apply it and dump mine version.

On the second thought - there may be real devices which have +1 native
capacity so we are better off with sticking to the version with extra drive
model check (this is of course given that the approach is right - yet to
be verified).

Thanks,
Bart
