From: Seed <seedrubbish@gmail.com>
Subject: Re: [BUG] libahci returns stale result tf much of the time.
Date: Fri, 24 Sep 2010 15:49:37 +1000
Message-ID: <AANLkTi=85A9ueu9YYrh0jOKFgc+fqbaUhkRLt7=Bzx2M@mail.gmail.com>
References: <4C9C3878.9010206@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54593 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999Ab0IXFt7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Sep 2010 01:49:59 -0400
Received: by wyb28 with SMTP id 28so1597269wyb.19
        for <linux-ide@vger.kernel.org>; Thu, 23 Sep 2010 22:49:58 -0700 (PDT)
In-Reply-To: <4C9C3878.9010206@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <kernel@teksavvy.com>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

010 at 3:34 PM, Mark Lord <kernel@teksavvy.com> wrote:
> I am totally lost when looking at libahci code though.
> Anyone got any ideas where the bug might be there??

Maybe in libata-scsi.c function ata_scsi_pass_thru?

--
