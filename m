From: Tejun Heo <htejun@gmail.com>
Subject: Re: ata, pcmcia: problem with irq and ata_dev_read_id()
Date: Fri, 02 Jul 2010 17:01:23 +0200
Message-ID: <4C2DFF43.6050502@gmail.com>
References: <4C034FAE.9090605@denx.de> <4C044C8F.8050406@gmail.com> <4C2833B2.3040209@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49102 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758785Ab0GBPB3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Jul 2010 11:01:29 -0400
Received: by bwz1 with SMTP id 1so1638773bwz.19
        for <linux-ide@vger.kernel.org>; Fri, 02 Jul 2010 08:01:27 -0700 (PDT)
In-Reply-To: <4C2833B2.3040209@denx.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: hs@denx.de
Cc: Robert Hancock <hancockrwd@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org

Hello,

Can you please give a shot at the following branch and report
the kernel log?

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/misc.git libata-irq-expect

Thanks.

-- 
tejun
