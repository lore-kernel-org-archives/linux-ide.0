From: Tejun Heo <tj@kernel.org>
Subject: Re: Red leds at harddisk bays on SR1530HSH after update to 2.6.27.x
Date: Mon, 22 Dec 2008 16:15:19 +0900
Message-ID: <494F3E87.1070204@kernel.org>
References: <494A34CA.9030906@bigtelecom.ru> <20081219223246.b0aea84d.akpm@linux-foundation.org> <494EF9A1.90002@kernel.org> <494F3D7D.9010002@bigtelecom.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:48733 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752056AbYLVHPb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 22 Dec 2008 02:15:31 -0500
In-Reply-To: <494F3D7D.9010002@bigtelecom.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Badalian Vyacheslav <slavon@bigtelecom.ru>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Badalian Vyacheslav wrote:
> echo 0 > /sys/module/ahci/parameters/ahci_em_messages
> -bash: /sys/module/ahci/parameters/ahci_em_messages: Permission denied
> ls -la /sys/module/ahci/parameters/ahci_em_messages
> -r--r--r-- 1 root root 4096 Dec 22 10:04
> /sys/module/ahci/parameters/ahci_em_messages
> 
> Any other chance to change without it reboot? Or i can change it only at
> boot? I will reboot server at night.

You can unload and reload ahci but that often isn't too different
from rebooting.

-- 
tejun
