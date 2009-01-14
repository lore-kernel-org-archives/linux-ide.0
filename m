From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: IDE: fix sparse signed-ness errors with host->host_busy
Date: Wed, 14 Jan 2009 18:21:11 +0100
Message-ID: <200901141821.11834.bzolnier@gmail.com>
References: <20090113172808.616407105@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:48204 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757533AbZANRW1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Jan 2009 12:22:27 -0500
Received: by bwz14 with SMTP id 14so2109953bwz.13
        for <linux-ide@vger.kernel.org>; Wed, 14 Jan 2009 09:22:26 -0800 (PST)
In-Reply-To: <20090113172808.616407105@fluff.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ben Dooks <ben-linux@fluff.org>
Cc: linux-ide@vger.kernel.org

On Tuesday 13 January 2009, Ben Dooks wrote:
> The host_busy field in struct ide_host defaults to a
> signed-long, where most arch's test_and_set_bit_*
> macros use an unsigned long.
> 
> Change to using an unsigned long, which on ARM removes
> the following sparse errors:
> 
> drivers/ide/ide-io.c:681:8: warning: incorrect type in argument 2 (different signedness)
> drivers/ide/ide-io.c:681:8:    expected unsigned long volatile *p
> drivers/ide/ide-io.c:681:8:    got long volatile *<noident>
> drivers/ide/ide-io.c:681:8: warning: incorrect type in argument 2 (different signedness)
> drivers/ide/ide-io.c:681:8:    expected unsigned long volatile *p
> drivers/ide/ide-io.c:681:8:    got long volatile *<noident>
> drivers/ide/ide-io.c:695:3: warning: incorrect type in argument 2 (different signedness)
> drivers/ide/ide-io.c:695:3:    expected unsigned long volatile *p
> drivers/ide/ide-io.c:695:3:    got long volatile *<noident>
> drivers/ide/ide-io.c:695:3: warning: incorrect type in argument 2 (different signedness)
> drivers/ide/ide-io.c:695:3:    expected unsigned long volatile *p
> drivers/ide/ide-io.c:695:3:    got long volatile *<noident>
> drivers/ide/ide-io.c:695:3: warning: incorrect type in argument 2 (different signedness)
> drivers/ide/ide-io.c:695:3:    expected unsigned long volatile *p
> drivers/ide/ide-io.c:695:3:    got long volatile *<noident>
> drivers/ide/ide-io.c:695:3: warning: incorrect type in argument 2 (different signedness)
> drivers/ide/ide-io.c:695:3:    expected unsigned long volatile *p
> drivers/ide/ide-io.c:695:3:    got long volatile *<noident>
> drivers/ide/ide-io.c:695:3: warning: incorrect type in argument 2 (different signedness)
> drivers/ide/ide-io.c:695:3:    expected unsigned long volatile *p
> drivers/ide/ide-io.c:695:3:    got long volatile *<noident>
> drivers/ide/ide-io.c:695:3: warning: incorrect type in argument 2 (different signedness)
> drivers/ide/ide-io.c:695:3:    expected unsigned long volatile *p
> drivers/ide/ide-io.c:695:3:    got long volatile *<noident>
> drivers/ide/ide-io.c:695:3: warning: incorrect type in argument 2 (different signedness)
> drivers/ide/ide-io.c:695:3:    expected unsigned long volatile *p
> drivers/ide/ide-io.c:695:3:    got long volatile *<noident>
> drivers/ide/ide-io.c:695:3: warning: incorrect type in argument 2 (different signedness)
> drivers/ide/ide-io.c:695:3:    expected unsigned long volatile *p
> drivers/ide/ide-io.c:695:3:    got long volatile *<noident>
> 
> Signed-off-by: Ben Dooks <ben-linux@fluff.org>

thanks, applied
