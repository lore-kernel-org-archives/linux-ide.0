From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: Fix ide on Swarm and improve it a little
Date: Sun, 28 Feb 2010 16:35:38 +0100
Message-ID: <1267371341-16684-1-git-send-email-sebastian@breakpoint.cc>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:40461 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S968705Ab0B1Pft (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Feb 2010 10:35:49 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, "David S. Miller" <davem@davemloft.net>, linux-ide@vger.kernel.org

Patch #1 fixes the ide trouble on Swarm. We don't have dcache alliasing
         there but icache does not snoop dcache so we can't execute / boot
         from ide devices unless dcache is flushed.
Patch #2 is ths' old patch rebased with a few optimizations.
Patch #3 moves the dcache flush from arch code into ide subsystem. David,
         I hope I don't break any of your sparcs. The dcache flush in
         write path looks like a nop.

The whole series was tested on MIPS BCM1250 B2 aka Swarm with its default
config and CONFIG_BLK_DEV_PLATFORM=y instead PATA. PATA seems not to work
(yet).

Sebastian
