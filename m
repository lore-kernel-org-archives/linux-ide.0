From: amruth pattanada <amruth.vamadev@gmail.com>
Subject: silicon image 3124 support PATA
Date: Sat, 16 Jan 2010 02:31:26 -0800
Message-ID: <9edb119c1001160231v3081a2e4u79884988fc5e2359@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:64919 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462Ab0APKb1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Jan 2010 05:31:27 -0500
Received: by pwj9 with SMTP id 9so810777pwj.21
        for <linux-ide@vger.kernel.org>; Sat, 16 Jan 2010 02:31:26 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Jeff Garzik <jeff@garzik.org>, Tejun Heo <tj@kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.uk>

Hi
I am currently working on porting linux sata silicon image 3124 to
RTOS based kernel. I have checked the code and found that it supports
native sata mode only.
I have legacy ide driver and want to integrate 3124 controller. I
wanted to run 3124 in PATA mode. I checked libata and found that it
only supports 3112.
Can anybody please point what steps needs to be taken for making 3124
run in PATA mode.
Here is my observation so far.
I have MMIO for both port and host using PCI configuration space.
I can read global control register and after reset I can see that the
default values are set correctly.
I have port map of 8192
bytes(0-2000,2000-4000,4000-6000,6000-8000)ports 0..3 respectively,
and planning to reset the port, followed steps from linux code but
unable to validate if the port is successfully reset.
I have PRB mapped but after softreset, reading low,mid and high LBA
but signature is not as per data sheet.
Can I can use default standard ATA PRB and map it to legacy ide driver
or is there any register setting needs to be done to bring in PATA
mode.
Any pointers will be appreciated.
Thanks
Amruth p.v
Sr.Embedded Engineer
