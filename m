From: Tejun Heo <htejun@gmail.com>
Subject: Re: ASUS M2A-VM - AMD690G - SB600 Non-Raid-5 SATA - problem
Date: Tue, 08 May 2007 13:16:52 +0200
Message-ID: <46405C24.9040603@gmail.com>
References: <41255.7661.qm@web52612.mail.re2.yahoo.com> <46405B16.3000502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:49847 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934196AbXEHLRE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 May 2007 07:17:04 -0400
Received: by py-out-1112.google.com with SMTP id a29so1446196pyi
        for <linux-ide@vger.kernel.org>; Tue, 08 May 2007 04:17:02 -0700 (PDT)
In-Reply-To: <46405B16.3000502@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Cc: linux-ide@vger.kernel.org, conke.hu@gmail.com

Tejun Heo wrote:
> Yeap, I'll forward it upstream and probably to -stable too.  The problem
> here is that I'm not sure whether the problem is in the ahci controller
> itself or some bridge chip above it.  It would be best if Conke Hu can
> verify this but you can also test it by buying a ATA controller which
> can do 64bit and whether it works properly on the machine.  :-)

Just in case, can you post the result of 'lspci -nntv'?

-- 
tejun
