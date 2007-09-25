From: "Berck E. Nash" <flyboy@gmail.com>
Subject: Re: 2.6.23-rc7-mm1 AHCI ATA errors -- won't boot
Date: Tue, 25 Sep 2007 12:14:11 -0600
Message-ID: <46F94FF3.1000400@gmail.com>
References: <46F7FBCB.4030803@gmail.com> <46F8665A.4000206@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:17780 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbXIYSOR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Sep 2007 14:14:17 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2488861wah
        for <linux-ide@vger.kernel.org>; Tue, 25 Sep 2007 11:14:17 -0700 (PDT)
In-Reply-To: <46F8665A.4000206@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

Jeff Garzik wrote:

> The first step would be to clone the "upstream" branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git
> 
> and see if the problem is reproducible there.  If yes, then you have
> narrowed down the problem to something my ATA devel tree has introduced
> into -mm.

Nope, you're off the hook.  The libata tree works great, so it must be
something else in -mm conflicting.
