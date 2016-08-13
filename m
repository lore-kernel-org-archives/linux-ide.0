From: Sitsofe Wheeler <sitsofe@gmail.com>
Subject: SATA port multipliers and max_channel
Date: Sat, 13 Aug 2016 09:56:17 +0100
Message-ID: <CALjAwximVtXe8BYBpqOXST9UkR79vCdrNd2PMAQYnYaXYPx_Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ua0-f195.google.com ([209.85.217.195]:35569 "EHLO
	mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644AbcHMI4T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Aug 2016 04:56:19 -0400
Received: by mail-ua0-f195.google.com with SMTP id 109so689139uat.2
        for <linux-ide@vger.kernel.org>; Sat, 13 Aug 2016 01:56:18 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, linux-ide@vger.kernel.org

Hi,

I was browsing through the kernel while looking at
https://github.com/systemd/systemd/issues/3943#issuecomment-239608897
and I noticed that in libata-scsi.c shost->max_channel is set to 1.
I'm unsure as to why it's one rather than 0 because it doesn't look
like two channels are used and the code in
http://lxr.free-electrons.com/source/drivers/scsi/scsi_error.c#L1595
loops over the 0th channel.

Further, if a SATA port multiplier is being used aren't channels used
to represent the port multiplier ports
(http://lxr.free-electrons.com/source/drivers/ata/libata-scsi.c?v=4.6#L3726
)? If so does max_channel need to be increased to one less than
SATA_PMP_MAX_PORTS? If so, would this explain the results seen in
https://www.usenix.org/system/files/fastpw13-paper7_0.pdf ?
