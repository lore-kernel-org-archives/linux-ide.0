From: "tea4two" <tea4two@tin.it>
Subject: siI3112 on A7N8X ASUS
Date: Wed, 9 Jul 2003 00:08:37 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <beffbo$o6s$1@main.gmane.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.224.249]:9433 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S268536AbTGIS2m (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Jul 2003 14:28:42 -0400
Received: from root by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 19aJrm-0000rl-00
	for <linux-ide@vger.kernel.org>; Wed, 09 Jul 2003 20:40:34 +0200
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I'm using Redhat 9.0 on A7N8X Deluxe with MaxtorDiamondPlus 9 120 Gb SATA
HD, the only way to obtain more disk performance is to run before install
"hdparm -d1 -Xudma2 /tmp/hde" and after create in /etc/sysconfig the
harddiskhde file with
DMA = 1 and EXTRA PARAMETER = -Xudma2.

Using hdparm -t /dev/hde HD speed increase from 1.3 MB/sec to 50.50 Mb/sec.
installation go faster and PC are really usable.

It's the better way to tune HD performance or someone know a better once ?

When linux boot siI3112A controller fail DMA test and set SATA controller in
pio mode, this is the reason for very poor performance.

Please write your experience.

Thanks in advance.

Pierluigi



