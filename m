From: Tejun Heo <htejun@gmail.com>
Subject: [git-patch] hotplug fix patches added
Date: Sun, 11 Jun 2006 11:29:17 +0900
Message-ID: <448B7FFD.9050507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:25243 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932469AbWFKC3X (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 10 Jun 2006 22:29:23 -0400
Received: by py-out-1112.google.com with SMTP id x31so1339312pye
        for <linux-ide@vger.kernel.org>; Sat, 10 Jun 2006 19:29:22 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello,

Two hotplug fix patches have been added to libata-tj #for-jeff.

* libata: add missing finish_wait() call in ata_port_wait_eh()
* libata: cosmetic change in struct ata_port

The following two patches have been dropped as it hasn't been acked yet.

* ata_piix: fix ghost device probing by honoring PCS present bits[1]
* libata: add ata_port->private_flags[2]

libata-tj #for-jeff is available at the following URL

http://htj.dyndns.org/git/?p=libata-tj.git;a=shortlog;h=for-jeff
git://htj.dyndns.org/libata-tj for-jeff

The tree is tagged with the followings

fj-misc
fj-hp-prep
fj-hp-LLDD-prep
fj-hp
fj-hp-fixes

Thanks.

-- 
tejun

[1] http://article.gmane.org/gmane.linux.ide/10937
[2] http://article.gmane.org/gmane.linux.ide/11177
