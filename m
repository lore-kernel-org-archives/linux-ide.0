From: Tejun Heo <htejun@gmail.com>
Subject: Re: ATA taskfile register returns 0xd0 on resume.
Date: Wed, 29 Apr 2009 08:30:32 +0900
Message-ID: <49F79198.2010801@gmail.com>
References: <alpine.DEB.2.00.0904141312270.8011@hungry> <alpine.DEB.2.00.0904141515010.4289@hungry> <49E509AB.9010004@gmail.com> <alpine.DEB.2.00.0904141719100.4289@hungry> <49E510B6.3080404@gmail.com> <alpine.DEB.2.00.0904150150530.4289@hungry> <49E58630.2050401@gmail.com> <alpine.DEB.2.00.0904151747180.4289@hungry> <49EFF722.7030804@gmail.com> <alpine.DEB.2.00.0904232016230.18217@hungry> <49F2BE21.702@gmail.com> <alpine.DEB.2.00.0904281700590.30659@hungry>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:40588 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752929AbZD1Xak (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 28 Apr 2009 19:30:40 -0400
Received: by ewy24 with SMTP id 24so927156ewy.37
        for <linux-ide@vger.kernel.org>; Tue, 28 Apr 2009 16:30:39 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.0904281700590.30659@hungry>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: manoj.iyer@canonical.com
Cc: linux-ide@vger.kernel.org

Hello,

manoj.iyer@canonical.com wrote:
> Sorry for the delayed reponds, I was away for the weekend. I tried the
> same tests with kernel option irqpoll and that did not make any
> difference, I get the same errors I reported earlier.

Hmm... interesting.  Looks like the device is locking up completely.
If you soft-reset the machine after the failure (reboot or sysrq-b),
can the BIOS access the device?

Thanks.

-- 
tejun
