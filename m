From: Tejun Heo <htejun@gmail.com>
Subject: Re: UDMA with CS5530 using IBM Netvista N2200 (8363)
Date: Mon, 15 Sep 2008 01:49:53 -0700
Message-ID: <48CE21B1.6070808@gmail.com>
References: <48C45BEF.5090502@gmail.com>	 <20080908094332.7b021b4e@lxorguk.ukuu.org.uk>	 <48C5BD49.6090204@gmail.com>	 <20080909115248.580eba78@lxorguk.ukuu.org.uk>	 <48C70313.6080704@gmail.com>	 <20080910093840.0fc9df68@the-village.bc.nu> <43e9b8530809100614t616154caldb32c4207b5b44ad@mail.gmail.com> <48C7DFEC.1090109@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.185]:5029 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbYIOIvS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Sep 2008 04:51:18 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1097648tic.23
        for <linux-ide@vger.kernel.org>; Mon, 15 Sep 2008 01:51:17 -0700 (PDT)
In-Reply-To: <48C7DFEC.1090109@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Antonio Martins <digiplan.pt@gmail.com>, linux-ide@vger.kernel.org

Sergei Shtylyov wrote:
>    There's "libata.dma=" option (if you can pass it), set it to 0
> and DMA won't ever be used.
>    Note that the "old" IDE code also has the parameter controlling
> DMA usage (even per drive) -- look for "nodma" in
> Documentation/ide/ide.txt.

libata.force can do per device or per-port speed override.

  libata.force=1.00:pio4

-- 
tejun
