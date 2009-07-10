From: pinchu <pinchu4u@gmail.com>
Subject: External port Multiplier Support in linux
Date: Fri, 10 Jul 2009 19:06:38 +0530
Message-ID: <4A5743E6.9000302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f226.google.com ([209.85.219.226]:56795 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbZGJNgo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Jul 2009 09:36:44 -0400
Received: by ewy26 with SMTP id 26so1069706ewy.37
        for <linux-ide@vger.kernel.org>; Fri, 10 Jul 2009 06:36:43 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hi Jeff,

We have an external RAID Disk Array which is having a port multiplier 
and four HDD behind the port multiplier. The RAID box is connected to 
host via SATA interface. The port multiplier we are using is implemented 
in FPGA. The linux kernel 2.6.28 is not detecting the port multiplier 
and devices behind it.

By any chance linux kernel 2.6.28 supports external port multiplier?
Does linux automatically detect port multiplier during bootup?
Di i need to write driver for detecting the port multiplier?

Thanks in advance.

Regards,
Pinchu
