From: Paulo Fidalgo <kanniball@zmail.pt>
Subject: [Sil31112 + Seagate drive] patch testing report
Date: Mon, 23 May 2005 15:52:34 +0100
Message-ID: <200505231552.34521.kanniball@zmail.pt>
Reply-To: kanniball@zmail.pt
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from [81.92.212.1] ([81.92.212.1]:52232 "EHLO zmail.pt")
	by vger.kernel.org with ESMTP id S261876AbVEWOtb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 May 2005 10:49:31 -0400
Received: from 80.172.45.18
	by zmail.pt
	(MDaemon.PRO.v6.8.4.R)
	with ESMTP id 30-md50000000002.tmp
	for <linux-ide@vger.kernel.org>; Mon, 23 May 2005 15:47:22 +0100
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi!

I've been testing my system with the reference patch from Silicon Image and 
with Tejun Heo's one.
[http://marc.theaimsgroup.com/?l=linux-kernel&m=111173514717575&w=2]
[http://marc.theaimsgroup.com/?l=linux-ide&m=111260146423451&w=2]

and I've got better performance on reading.. althougth this is still far from 
normal expected performance. I've tested with copy and moving files (small 
and big ones), and found no problems at all.
Thanks for all developers for you great work.

Since this looks like an permanent problem of hardware combination, I will 
avoid all products from both brand names (Silicon Image and Segeate), and 
alert my friends on that... in my opinion a bug like this is unacceptable, so 
bye bye Seagate and Silicon Image.

Best regards,
Paulo Fidalgo

