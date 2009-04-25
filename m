From: Tejun Heo <htejun@gmail.com>
Subject: Re: ATA taskfile register returns 0xd0 on resume.
Date: Sat, 25 Apr 2009 16:39:13 +0900
Message-ID: <49F2BE21.702@gmail.com>
References: <alpine.DEB.2.00.0904141312270.8011@hungry> <alpine.DEB.2.00.0904141515010.4289@hungry> <49E509AB.9010004@gmail.com> <alpine.DEB.2.00.0904141719100.4289@hungry> <49E510B6.3080404@gmail.com> <alpine.DEB.2.00.0904150150530.4289@hungry> <49E58630.2050401@gmail.com> <alpine.DEB.2.00.0904151747180.4289@hungry> <49EFF722.7030804@gmail.com> <alpine.DEB.2.00.0904232016230.18217@hungry>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gx0-f166.google.com ([209.85.217.166]:60930 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbZDYHjV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 25 Apr 2009 03:39:21 -0400
Received: by gxk10 with SMTP id 10so3103390gxk.13
        for <linux-ide@vger.kernel.org>; Sat, 25 Apr 2009 00:39:20 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.0904232016230.18217@hungry>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: manoj.iyer@canonical.com
Cc: linux-ide@vger.kernel.org

manoj.iyer@canonical.com wrote:
> 
> Tejun,
> 
> I compiled 2.6.29 with your patch, and ran the suspend resume tests.
> 
> 1. Suspend with AC power connected - resume with AC connected - ok
> 2. suspend with AC power disconnected - resume with AC disconnected - ok
> 3. suspend with AC power connected - resume with AC connected - ATA errors.
> 
> I have attached the dmesg output and the kern.log output as you requested.

Hmmm... does irqpoll help?

-- 
tejun
