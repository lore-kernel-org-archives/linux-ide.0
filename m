From: Daniel Nilsson <gnuffel@gmail.com>
Subject: Intel ICH8 errata for ata_piix.c
Date: Mon, 1 Mar 2010 19:31:48 +0100
Message-ID: <ba87a861003011031o5fd78d25n492cddf7a2bdeb2c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f220.google.com ([209.85.219.220]:60653 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905Ab0CASbu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Mar 2010 13:31:50 -0500
Received: by ewy20 with SMTP id 20so1453613ewy.21
        for <linux-ide@vger.kernel.org>; Mon, 01 Mar 2010 10:31:49 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hi,

I have a laptop running Linux 2.6.33 with the following SATA chip:
"Intel Corporation 82801HBM/HEM (ICH8M/ICH8M-E) IDE Controller (rev
03)", and I am experiencing random loss of data and a bouncing SATA
link.

The problem seems to be described by other people in
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/297058 . After
investigating for a while, I found the errata
http://www.intel.com/Assets/PDF/specupdate/313057.pdf , see especially
errata #19 which handles MSI. Is this something that is handled in the
driver?

I have disabled MSI interrupts by using "pci=nomsi" on the kernel boot
line for now, and will see if it fixes anything - hopefully it does.
