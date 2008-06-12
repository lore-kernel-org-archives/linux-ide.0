From: Martin Michlmayr <tbm@cyrius.com>
Subject: Re: sata_mv on Orion: mv_err_intr when shutting down
Date: Thu, 12 Jun 2008 20:18:51 +0200
Message-ID: <20080612181851.GA19874@deprecation.cyrius.com>
References: <20080512132611.GA15410@deprecation.cyrius.com> <48286499.9020202@rtr.ca> <20080512154609.GI15866@deprecation.cyrius.com> <20080512191534.GA28429@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sorrow.cyrius.com ([65.19.161.204]:4042 "EHLO sorrow.cyrius.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753376AbYFLSVI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 12 Jun 2008 14:21:08 -0400
Content-Disposition: inline
In-Reply-To: <20080512191534.GA28429@deprecation.cyrius.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org, nico@cam.org, buytenh@wantstofly.org

* Martin Michlmayr <tbm@cyrius.com> [2008-05-12 21:15]:
> * Martin Michlmayr <tbm@cyrius.com> [2008-05-12 17:46]:
> > > The code that triggers this was fixed up more after -rc1, so if you can
> > > still get messages like that with, say -rc2 or later, then please post them.
> > 
> > Cool.  I'll let you know in case the message doesn't go away with rc2.
> 
> I still get the same message with rc2.

Just saw it again with 2.6.26-rc6:

[42949509.440000] Power down.
[42949509.440000] qnap_ts209_power_off: triggering power-off...
[42949509.460000] ata1: exception Emask 0x10 SAct 0x0 SErr 0x190002 action 0xe frozen
[42949509.460000] ata1: edma_err_cause=02000020 pp_f

-- 
Martin Michlmayr
http://www.cyrius.com/
