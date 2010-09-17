From: Murali N <nalajala.murali@gmail.com>
Subject: On SoC SATA controller driver implementation!!!
Date: Fri, 17 Sep 2010 15:24:15 +0530
Message-ID: <AANLkTin-bG72N9TSzRFOFYusa+9xZfYOA75zAP0chSFH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:55598 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921Ab0IQJyR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Sep 2010 05:54:17 -0400
Received: by ewy23 with SMTP id 23so922077ewy.19
        for <linux-ide@vger.kernel.org>; Fri, 17 Sep 2010 02:54:15 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide <linux-ide@vger.kernel.org>

Hi All,

I am implementing  a SATA driver for my SATA controller which is part of SoC.
I had seen a generic AHCI controller driver in .35 (ahci_platform.c)
which is used by SATA controllers part of the SoC and interacting to
local bus.

My doubts is:
1. Can i make use of above framework to implement my own controller
driver? I know that i have to take care of the "init", "exit" and
power management routines specific to my controller. Will this work?
OR do i need to take care of any other additional considerations while
implementing?

I would like to see a reference drivers code which uses the platform
AHCI controller driver(ahci_platform.c). Can anyone point me to the
sources.
My aim is to leverage already existing code as much as possible to
make my controller works better.

Please provide me any suggestions.

--
Regards,
Murali N
