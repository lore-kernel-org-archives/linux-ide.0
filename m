From: Tejun Heo <htejun@gmail.com>
Subject: sata_sil Mod15Write quirk workaround patch for vanilla kernel avaialble.
Date: Fri, 01 Apr 2005 00:01:23 +0900
Message-ID: <424C10C3.9080102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.204]:20593 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261490AbVCaPBa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 31 Mar 2005 10:01:30 -0500
Received: by wproxy.gmail.com with SMTP id 68so648511wri
        for <linux-ide@vger.kernel.org>; Thu, 31 Mar 2005 07:01:28 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Cc: mage@adamant.ua


 Hello, guys.

 I  generated m16w workaround patch for 2.6.11.6 (by just removing two
lines :-) and set up a page regarding m15w quirk and the workaournd.
I'm planning on updating m15w patch against the vanilla tree until it
gets into the mainline so that impatient users can try out and it gets
more testing.

 http://home-tj.org/m15w

 Thanks.

-- 
tejun

