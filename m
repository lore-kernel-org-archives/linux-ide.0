From: Ricky Cheng <rickycheng@qnap.com.tw>
Subject: Problem with sil chip tests
Date: Mon, 22 Aug 2005 13:15:30 +0000 (UTC)
Message-ID: <loom.20050822T145903-249@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zeus1.kernel.org ([204.152.191.4]:35970 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751265AbVHVVoo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 22 Aug 2005 17:44:44 -0400
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j7MDL4aY014377
	for <linux-ide@vger.kernel.org>; Mon, 22 Aug 2005 06:21:04 -0700
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1E7CCZ-0001Kc-JK
	for linux-ide@vger.kernel.org; Mon, 22 Aug 2005 15:18:59 +0200
Received: from 211-75-85-27.HINET-IP.hinet.net ([211-75-85-27.HINET-IP.hinet.net])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 22 Aug 2005 15:18:59 +0200
Received: from rickycheng by 211-75-85-27.HINET-IP.hinet.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 22 Aug 2005 15:18:59 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Him I have some problems with the process of test.

I did some tests one 3 machine.

1. CPU: VIA 800 MHz, with 4 IDE HD
2. CPU: VIA 800 MHz, 2 Sil3512 chip with 4 SATA HD
3. CPI: INTER 3.0 GHz, 1 sil3114 chip with 4 SATA HD

kernel version: 2.4.30, 2.6.12
They have almost the same

I do 2 kind of tests on a mounted and formated file-system.
  (1). On the mounted dir dd 500M from /dev/zero and use time to calculate the 
system and real time: 
         time dd if=/dev/zero of=500M bs=25M count=20
  (2). use hdparm -t /dev/sda

Those are the result of 3 machine.
1. IDE: (1)real: 10~12 sec
           user: 0
           sys: 5~6 sec
        (2)hdparm: ~48MB/sec

2.SATA: (1)real: 10~13 sec
           user: 0
           sys: 9~10 sec
        (2)hdparm: almost 32MB/sec
3.INTEL 3.0G with SiL 3114 chip
        (1)real: 18~30 sec
           user: 0
           sys: 0.9 sec  <--confused
        (2)hdparm: ~45MB/sec

Those result confused me. 
I use the IDE drive is faster than SATA drive?

Does anybody can correct me the correct process of tests? Because those 
experiments I tried get a strange result.
Especially, I use the 3.0G CPU and I get higher hdparm read values. But When I 
try to write data, it shows me a very bad value. Sometime write 500M to HD 
almost need 30 secs. I think it is bad? right?But the sys time is very short.

   
Thanks for help.
Ricky        

