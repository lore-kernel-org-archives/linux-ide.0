From: Markku Pesonen <tourula@gmail.com>
Subject: pata_atiixp regression in 4.11-rc1
Date: Sun, 26 Mar 2017 10:31:17 +0300
Message-ID: <22571b6e-a8f3-05bc-d68b-a728f595af1d@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35774 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbdCZHc0 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 26 Mar 2017 03:32:26 -0400
Received: by mail-wm0-f65.google.com with SMTP id z133so5329676wmb.2
        for <linux-ide@vger.kernel.org>; Sun, 26 Mar 2017 00:32:24 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

Hello,

While testing Linux 4.11-rc1, I noticed that the IDE port on my
Asrock 980DE3/U3S3 motherboard stopped working.

Reverting commit 5946fdaee4ba449e8fbb5d403e1ed69437f916e8
(pata_atiixp: Don't use unconnected secondary port on SB600/SB700)
made things work again.

Apparently the secondary port is used on this motherboard.

