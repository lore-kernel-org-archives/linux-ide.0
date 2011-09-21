From: Sujit Reddy <sujitreddy243@gmail.com>
Subject: SATA: Data requests which cross 1K boundary on AXI bus causing data
 integrity failures.
Date: Wed, 21 Sep 2011 13:26:26 +0530
Message-ID: <CA+b=54y4ifRbK07WNQ=PhmszAHE6dXT7Fjy6CiJ2mQ2Da1a9uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:62697 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873Ab1IUH41 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 21 Sep 2011 03:56:27 -0400
Received: by yxl31 with SMTP id 31so933843yxl.19
        for <linux-ide@vger.kernel.org>; Wed, 21 Sep 2011 00:56:27 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jeff@garzik.org

Hi,

I have a query regarding 1KB boundary crossing of AXI bus. We have a
sata master port connected to AXI bus via IB2AXI bridge. The Internal
Bus (IB) doesn't handle requests that cross 1KB boundary. It works
well with AHB bus but not with AXI bus. To my knowledge, AHB splits up
transfers into 1KB boundary and then send it to the device. But as per
ARM AXI protocol it is not guaranteed that the transfers are split
into 1KB bursts. We don't have the IB bus compliant to this protocol
and still accepts only 1KB bursts. This is causing data integrity
failures whenever the data sizes cross 1KB boundary and I would like
to have a software workaround for this.

My SATA master port is AHCI compliant and we use ahci_platform.c as
LLD. The workaround I can think of is to have the PRD entry size limit
to 1KB instead of 4MB (but not sure where to do this in the code).
This would lead to higher RAM consumption for large data but it is
okay for me to live with it. Also, I would like to make the data
buffers aligned to 1KB (for ex: if I have a last request as 512bytes,
I would like to pad with extra bytes to make it aligned with 1KB and
send it to the device).

Please let me know if you have any inputs regarding this. I have
little knowledge of libata framework in Linux so any suggestions to
find a different workaround or a pointer to a driver which handles
similar case are welcome.

Thanks
Sujit
