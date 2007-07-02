From: Tejun Heo <htejun@gmail.com>
Subject: Re: State of Port Multiplier Support in libata?
Date: Mon, 02 Jul 2007 16:20:43 +0900
Message-ID: <4688A74B.7000604@gmail.com>
References: <4684D54A.8030307@enhance-it.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.225]:30127 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbXGBHUv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 2 Jul 2007 03:20:51 -0400
Received: by qb-out-0506.google.com with SMTP id e11so2215288qbe
        for <linux-ide@vger.kernel.org>; Mon, 02 Jul 2007 00:20:50 -0700 (PDT)
In-Reply-To: <4684D54A.8030307@enhance-it.dk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stefan Skotte <stefan.skotte@gmail.com>
Cc: linux-ide@vger.kernel.org

Stefan Skotte wrote:
> Hi,
> 
> I was wondering what the odds are that my setup could be supported:
> 
> * Stardom/Raidon SOHOTANK ST-6600 (5 disk SATA array)
> (http://www.stardom.com.tw/sohotank%20st6600.htm)
> * STLab Silicon Image 3531 NCQ/FIS PMP PCIe adapter with one eSATA port
> (uses sata_sil24).
> (http://www.st-lab.com/assign.asp?keyid=bf9)
> 
> The classical example of it not working properly is that only one disk
> in bay 2 is recognized; all other does not respond at all:

Get 2.6.22-rc6 and apply patches from the following page.

  http://home-tj.org/wiki/index.php/Libata-tj-stable

It should work.

-- 
tejun
