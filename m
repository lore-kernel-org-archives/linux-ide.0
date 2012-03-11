From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 0/4] pata_cmd64x: interrupt handling
Date: Sun, 11 Mar 2012 22:17:30 +0300
Message-ID: <201203112217.30704.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:59434 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753307Ab2CKSSY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Mar 2012 14:18:24 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jgarzik@pobox.com

Hello.

   Here's long postponed series of patches to the 'pata_cmd64x' driver
which should bring its interrupt handling code on the same "level"
that the IDE 'cmd64x' driver has.

Patch 1 prepares grounds for patch 2.
Patch 2 is equivalent to the commit 66602c83dcb6a5d82772d88ae7a32cd4a1213528
(cmd64x: use interrupt status from MRDMODE register (take 2)).
Patch 3 is equivalent to the commit 30e5ffc368ff7d96fbc7a51ede10809642b0a6df
(cmd64x: implement clear_irq() method (take 2)).
Patch 4 is equivalent to the commit 628df2f33d99dace08838779d8a02bf1deaff100
(cmd64x: implement test_irq() method).

WBR, Sergei
