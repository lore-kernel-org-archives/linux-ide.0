From: Martin Michlmayr <tbm@cyrius.com>
Subject: sata_mv on Orion: mv_err_intr when shutting down
Date: Mon, 12 May 2008 15:26:12 +0200
Message-ID: <20080512132611.GA15410@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sorrow.cyrius.com ([65.19.161.204]:1870 "EHLO sorrow.cyrius.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750803AbYELNzo (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 May 2008 09:55:44 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org
Cc: nico@cam.org, buytenh@wantstofly.org

With 2.6.26-rc1 on an Orion based platform (QNAP TS-209) I sometimes
get the following during shut down:

[42949439.950000] qnap_ts209_power_off: triggering power-off...
[42949439.960000] ata1: mv_err_intr: err_cause=02000020 pp_flags=0x2
[42949439.970000] ata1: exception Emask 0x10 SAct 0x0 SErr 0x190002 action 0xe fro

I never got this with 2.6.25.  With 2.6.26-rc1 I get this message from
time to time, but not always.  The disk spins down properly.  I think
it wants to print a 3rd line because once it was printed "[42949439"
once but the machine got shut off because the full line was printed.

<tries some more>

I just got:

[42949421.700000] qnap_ts209_power_off: triggering power-off...
[42949421.710000] ata1: mv_err_intr: err_cause=02000020 pp_flags=0x2
[42949421.720000] ata1: exception Emask 0x10 SAct 0x0 SErr 0x190002 action 0xe frozen
[42949421.720000] ata1: edma_err_cause=02000020 pp_flags

Any idea?
-- 
Martin Michlmayr
http://www.cyrius.com/
