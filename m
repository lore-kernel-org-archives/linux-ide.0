From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: sata_mv: Another source code review around exception handling?
Date: Fri, 25 Dec 2015 17:00:30 +0100
Message-ID: <567D681E.7050903@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <566ABCD9.1060404@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-ide@vger.kernel.org, Tejun Heo <tj@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-ide@vger.kernel.org

Hello,

I have looked at the source file for the Marvell SATA support driver once more.
I would appreciate if a specific implementation detail can be clarified there.

Static source code analysis can point out that functions like the following
are called by the mv_platform_probe() function.
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/tree/drivers/ata/sata_mv.c?id=80c75a0f1d81922bf322c0634d1e1a15825a89e6#n4055

* ata_host_alloc_pinfo
  http://lxr.free-electrons.com/source/drivers/ata/libata-core.c?v=4.3#L5768

* devm_kzalloc
  http://lxr.free-electrons.com/source/include/linux/device.h?v=4.3#L645


The value "-ENOMEM" will be returned if one of these function calls failed.
Can it be that any system resources (like memory) are not appropriately
released if any calls of this sequence succeeded before the failure?


Is the use of the single jump label "err" also suspicious here?

Regards,
Markus
