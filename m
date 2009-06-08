From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] sl82c105: add printk() logging facility
Date: Mon, 8 Jun 2009 21:56:54 +0200
Message-ID: <200906082156.54431.bzolnier@gmail.com>
References: <200702140101.26639.sshtylyov@ru.mvista.com> <200906082146.19522.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f210.google.com ([209.85.219.210]:56994 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754867AbZFHT6b (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 8 Jun 2009 15:58:31 -0400
Received: by mail-ew0-f210.google.com with SMTP id 6so4476043ewy.37
        for <linux-ide@vger.kernel.org>; Mon, 08 Jun 2009 12:58:33 -0700 (PDT)
In-Reply-To: <200906082146.19522.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Monday 08 June 2009 19:46:19 Sergei Shtylyov wrote:
> Add missing printk() logging facility in sl82c105_dma_lost_irq().
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
