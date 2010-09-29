From: Richard <tuxbox.guru@gmail.com>
Subject: Marvel PMP SATA controller
Date: Wed, 29 Sep 2010 07:56:59 +0100
Message-ID: <4CA2E33B.70001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55435 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333Ab0I2G5D (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 29 Sep 2010 02:57:03 -0400
Received: by wyb28 with SMTP id 28so433241wyb.19
        for <linux-ide@vger.kernel.org>; Tue, 28 Sep 2010 23:57:01 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Morning all,

Using the Marvel Port Multiplier I am stuck trying to get it working 
with some Hard drives.. I am stuck trying to figure out how to write the 
command to the SCR register on the device as there seems to be multiple 
methods used in the code I dont understand.

the procedure I need to follow is - Init_SATA, classify_device, if 
(special PMP) set mode to SATA-GEN1, then only can it continue.

using a ata_taskfile this early in the init causes a major explosion so 
my next option is to use writel/b() to the SCR registers..  this is the 
piece I dont understand is how the bytes are structured in the writel 
command.  I need to write 0xe80211 (Write value 0x11 to position 2) to 
force the chip to go in to Gen1 mode so that it can work with some older 
Maxtor Hard drives

Is there any HOWTO on the structure of the commands (target,port,c,h,s 
etc etc)

Thanks in Advance
Richard

