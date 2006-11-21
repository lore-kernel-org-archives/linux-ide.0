From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] drivers/ide: PATA driver	for Celleb
Date: Tue, 21 Nov 2006 19:07:16 +0900
Message-ID: <4562CFD4.6040702@gmail.com>
References: <200611210959.kAL9x8eH026223@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:4996 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030810AbWKUKH0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Nov 2006 05:07:26 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1456902ugc
        for <linux-ide@vger.kernel.org>; Tue, 21 Nov 2006 02:07:24 -0800 (PST)
In-Reply-To: <200611210959.kAL9x8eH026223@toshiba.co.jp>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org, kou.ishizaki@toshiba.co.jp

Akira Iguchi wrote:
> Dear everyone,
> 
> This is the patch (based on 2.6.19-rc4) for PATA controller of
> Toshiba Cell reference set(Celleb). The reference set consists
> of Cell, 512MB memory, Super Companion Chip(SCC) and some
> peripherals such as HDD, GbE, etc. You can see brief explanation
> and picture of Cell reference set at following URLs.
> 
>     http://www.toshiba.co.jp/about/press/2005_09/pr2001.htm
>     http://cell-industries.com/toshiba_announces.php
> 
> We use a drivers/ide driver because its design is more suitable for
> SCC IDE controller than libata driver. Since SCC supports only 32bit
> read/write, we must override many callbacks of ata_port_operations
> by modifying generic helpers. Each time the libata common code is
> updated, we must update those modified helpers. It is very hard for us.
> But we will try to implement the libata driver as needed.
> 
> This patch set is intended to be merged to 2.6.20.
> If you have any comment, please write to me.

Care to post libata version (even if it's not complete)?  Let's work 
something out.

-- 
tejun
