From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/10] ide: call clear_irq() method in ide_timer_expiry()
Date: Mon, 15 Jun 2009 18:41:18 +0200
Message-ID: <200906151841.18630.bzolnier@gmail.com>
References: <200702140101.26639.sshtylyov@ru.mvista.com> <200906131729.45000.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f210.google.com ([209.85.219.210]:38270 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763686AbZFOQta (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Jun 2009 12:49:30 -0400
Received: by ewy6 with SMTP id 6so5181908ewy.37
        for <linux-ide@vger.kernel.org>; Mon, 15 Jun 2009 09:49:32 -0700 (PDT)
In-Reply-To: <200906131729.45000.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Saturday 13 June 2009 15:29:44 Sergei Shtylyov wrote:
> Now the clear_irq() method is called only from ide_intr() but ide_timer_expiry()
> also should call this method in case when drive_is_ready() succeeds...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied 1-10
