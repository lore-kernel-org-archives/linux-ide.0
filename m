From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [cdrom_check_status] BUG: unable to handle kernel NULL pointer
 dereference at 000001c0
Date: Wed, 08 Nov 2017 17:50:41 +0100
Message-ID: <2347287.gTWU6fzh5s@amdc3058>
References: <20171107102538.mzbfdxll3fpf2kqg@wfg-t540p.sh.intel.com>
        <7885793.0mqNGdeUvE@amdc3058>
        <CGME20171108165043epcas2p2508e32c074e66a2c08b9a006f248f37c@epcas2p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:15584 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752256AbdKHQur (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Wed, 8 Nov 2017 11:50:47 -0500
In-reply-to: <7885793.0mqNGdeUvE@amdc3058>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: linux-ide@vger.kernel.org, Borislav Petkov <bp@alien8.de>, "David S. Miller" <davem@davemloft.net>, Linus Torvalds <torvalds@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bart.vanassche@sandisk.com>, linux-kernel@vger.kernel.org

On Wednesday, November 08, 2017 05:28:16 PM Bartlomiej Zolnierkiewicz wrote:

> we can see that for some reason PIIX PCI IDE controller is probed
> twice and later when we attach ide-cd driver to both instances of hdc
> (in parallel) it ends up badly..

Actually it ends up badly later (I don't know exactly yet how we get
into this situation but this is not that important as we know that
the root problem starts much earlier with the double probe of PCI IDE
host controller)..

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

