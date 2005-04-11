From: Dmitry Sanarin <sanarin@nikiet.ru>
Subject: libata-dev bugreport (Promise TX2plus PATA)
Date: Mon, 11 Apr 2005 14:48:01 +0400
Message-ID: <200504111448.01849.sanarin@nikiet.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from alpha.nikiet.ru ([195.128.70.10]:38482 "HELO alpha.nikiet.ru")
	by vger.kernel.org with SMTP id S261769AbVDKKtb (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 11 Apr 2005 06:49:31 -0400
Received: (from uucp@localhost) by  alpha.nikiet.ru (950413.SGI.8.6.12/950213.SGI.AUTOCF) id OAA00181 for <linux-ide@vger.kernel.org>; Mon, 11 Apr 2005 14:48:18 -0200
Received: from oitt.nikiet.ru (root@localhost)
	by oitt.nikiet.ru (8.12.10/8.12.10) with SMTP id j3BAlCwe011721
	for <linux-ide@vger.kernel.org>; Mon, 11 Apr 2005 14:47:12 +0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

 I have Promise TX2plus controller. This controller has 3 interfaces : 2 SATA 
and PARA. SATA interfaces works fine. PATA work correctly only with one 
drive. Adding second PATA drive causes seriuos filesystem damage.
 Linux kernel 2.6.11 + latest libata-dev patch from  
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/.

