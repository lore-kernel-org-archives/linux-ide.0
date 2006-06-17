From: Tejun Heo <htejun@gmail.com>
Subject: [PATCHSET] sata_nv: convert to new EH and add hotplug support, take 2
Date: Sat, 17 Jun 2006 15:49:55 +0900
Message-ID: <11505269953650-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0102.google.com ([64.233.162.205]:23604 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932414AbWFQGuA (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 17 Jun 2006 02:50:00 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1303342nze
        for <linux-ide@vger.kernel.org>; Fri, 16 Jun 2006 23:49:59 -0700 (PDT)
In-Reply-To: 
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, htejun@gmail.com

Hello,

This is the second take of convert-sata_nv-to-new-EH patchset.
Changes from the last take[1] are...

* controllers are differentiated by standard port_info/poert_ops
  instead of nv_host/host_desc

* thaw() fixed such that only the affected port's irq status is
  cleared.

I've tested it on ASUS A8N-E (nForce4, CK804, 10de:0054), and
everything works fine.  However, the controller doesn't have
protection against data transfer hang (IORDY hang) and the machine
completely locks up if a device is removed during active data
transfer.  I don't think it can be worked around without using the
better interface (ADMA).

This patchset contains 6 patches.

#01-03: prep sata_nv
#04   : improve irq handler
#05   : implement new EH
#06   : add hotplug support

This patchset is against

     upstream (db9ca5803566078aafe63cf364ef98b5097e4194)

Thanks.

--
tejun

[1] http://article.gmane.org/gmane.linux.ide/11381


