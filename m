From: Martin Michlmayr <tbm@cyrius.com>
Subject: Re: sata_mv on Orion: mv_err_intr when shutting down
Date: Sun, 22 Jun 2008 16:37:22 +0200
Message-ID: <20080622143722.GA14932@deprecation.cyrius.com>
References: <20080512132611.GA15410@deprecation.cyrius.com> <48286499.9020202@rtr.ca> <20080512154609.GI15866@deprecation.cyrius.com> <20080512191534.GA28429@deprecation.cyrius.com> <20080612181851.GA19874@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sorrow.cyrius.com ([65.19.161.204]:1899 "EHLO sorrow.cyrius.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752722AbYFVOmi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 22 Jun 2008 10:42:38 -0400
Content-Disposition: inline
In-Reply-To: <20080612181851.GA19874@deprecation.cyrius.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org, nico@cam.org, buytenh@wantstofly.org

Just got a more complete error this time in case this is of interest:

[42949696.850000] qnap_tsx09_power_off: triggering power-off...
[42949696.860000] ata1: exception Emask 0x10 SAct 0x0 SErr 0x180000 action 0x6 frozen
[42949696.870000] ata1: edma_err_cause=02000020 pp_flags=00000002, SError=00180000
[42949696.880000] ata1: SError: { 10B8B Dispar }
[42949696.880000] ata1: hard resetting link

-- 
Martin Michlmayr
http://www.cyrius.com/
