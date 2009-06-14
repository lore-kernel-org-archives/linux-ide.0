From: Andrea Bravetti <andreabravetti@gmail.com>
Subject: NCQ blacklist
Date: Mon, 15 Jun 2009 00:40:23 +0200
Message-ID: <5cf1b7b10906141540k6336730ep93bba3d97fda7680@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:58213 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744AbZFNWq6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 14 Jun 2009 18:46:58 -0400
Received: by fg-out-1718.google.com with SMTP id 16so1003192fgg.17
        for <linux-ide@vger.kernel.org>; Sun, 14 Jun 2009 15:47:00 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Please add "WDC WD3200BEVT-22ZCT0" to the NCQ blacklist.

I had some performance problem and I added this line:

        { "WDC WD3200BEVT-22ZCT0", NULL, ATA_HORKAGE_NONCQ },

around line 4184 of drivers/ata/libata-core.c (linux 2.6.30),
and now it work quite well...

Also "WDC WD5000AACS-00ZUB0" may have this problem, but I can't be sure...
You can see here: "https://bugs.launchpad.net/ubuntu/+source/linux/+bug/343371"

bye,
Andrea
