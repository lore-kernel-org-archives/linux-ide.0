From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [Bug 13520] WARNING: at lib/dma-debug.c:576 check_for_illegal_area+0xd3/0xfd()
Date: Wed, 17 Jun 2009 15:51:53 +0200
Message-ID: <200906171551.53400.bzolnier@gmail.com>
References: <bug-13520-11633@http.bugzilla.kernel.org/> <200906161028.n5GAS1f6030224@demeter.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f210.google.com ([209.85.219.210]:56438 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754466AbZFQNqL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 17 Jun 2009 09:46:11 -0400
Received: by ewy6 with SMTP id 6so516332ewy.37
        for <linux-ide@vger.kernel.org>; Wed, 17 Jun 2009 06:46:12 -0700 (PDT)
In-Reply-To: <200906161028.n5GAS1f6030224@demeter.kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bugzilla-daemon@bugzilla.kernel.org
Cc: linux-ide@vger.kernel.org

On Tuesday 16 June 2009 12:28:01 bugzilla-daemon@bugzilla.kernel.org wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=13520
> 
> 
> 
> 
> 
> --- Comment #3 from Joerg Roedel <joro@8bytes.org>  2009-06-16 10:27:59 ---
> Ok, this was a dma-debug bug. The two warnings above are for memory areas which
> exactly ends at the beginning of the kernel text segment. I queued a fix in my
> tree and send it out when -rc1 is released. I also marked the patch for stable
> backporting.

Could you please post a link to the fix and then close the bug?  Thanks.
