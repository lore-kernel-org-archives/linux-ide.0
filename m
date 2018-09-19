From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 1/2] libata: add ledtrig support
Date: Thu, 20 Sep 2018 05:49:28 +0800
Message-ID: <201809200503.I1K1HjLD%fengguang.wu@intel.com>
References: <1537328730-9156-2-git-send-email-aditya@kobol.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1537328730-9156-2-git-send-email-aditya@kobol.io>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@01.org, linux-ide@vger.kernel.org, linux-leds@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Russell King <linux@armlinux.org.uk>, Jens Axboe <axboe@kernel.dk>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Daniel Golle <daniel@makrotopia.org>, Aditya Prayoga <aditya@kobol.io>
List-Id: linux-ide@vger.kernel.org

Hi Daniel,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on block/for-next]
[also build test WARNING on v4.19-rc4 next-20180919]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Aditya-Prayoga/Add-support-per-ATA-port-ledtrigger-on-armada-38x/20180920-002037
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next


coccinelle warnings: (new ones prefixed by >>)

>> drivers/ata/libata-core.c:6101:3-4: Unneeded semicolon

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
