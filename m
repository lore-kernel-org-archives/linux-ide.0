From: Ming Lei <ming.lei@canonical.com>
Subject: [Bug] 3.16 fwdownload failure on Marvell 88SE9125 sata controller
Date: Mon, 1 Sep 2014 16:22:07 +0800
Message-ID: <CACVXFVN6f3Og+D_70M+4j_qhGNsryJWzTJK8G+rY0sxXweMqQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Tejun Heo <tj@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Gaurav <gspatel@hp.com>
List-Id: linux-ide@vger.kernel.org

Hi Guys,

When we use hdparm to download firmware on system with
Marvell 88SE9125 SATA controller, it returns failure always
and it has been observed in several systems:

#hdparm --fwdownload-mode7 fw.bin
--yes-i-kno-what-i-am-doing --please-destroy-my-drive /dev/sda

/dev/sda:
fwdownload: xfer_mode=7 min=1 max=65535 size=699392
FAILED: Input/output error


Thanks,
--
Ming Lei
