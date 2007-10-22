From: Gerhard Dirschl <gd@spherenet.de>
Subject: Re: BUG: sata_nv swncq cannot be disabled
Date: Mon, 22 Oct 2007 04:25:17 +0200
Message-ID: <200710220425.17316.gd@spherenet.de>
References: <200710220406.23790.gd@spherenet.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:59042 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532AbXJVCZ0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 21 Oct 2007 22:25:26 -0400
In-Reply-To: <200710220406.23790.gd@spherenet.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Gerhard Dirschl <gd@spherenet.de>

> Former versions of the SWNCQ patch didn't have this problem as
> ATA_FLAG_NCQ was set in nv_swncq_host_init(...). The appended patch
> restores this behaviour (or was it changed for a good reason?)
> We could also simply drop the option to enable/disable swncq.
Outch - sorry, just found the thread where you're already discussing 
the problem.

I'm not subscribed to the list so please CC me on replies.

   Gerhard



-- 
Gerhard Dirschl        PGP-Key-ID: 0x7B95AE94
Germany
