From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch v3] amd74xx: fix hang on resume from ram
Date: Thu, 27 Jul 2006 13:35:07 -0700
Message-ID: <200607271335.08245.david-b@pacbell.net>
References: <20060715210518.GA3263@opus.vpn-dev.reflex> <200607251727.12678.david-b@pacbell.net> <20060726031446.GD4829@opus.vpn-dev.reflex>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:34915 "HELO
	smtp108.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750755AbWG0Ugh (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 Jul 2006 16:36:37 -0400
In-Reply-To: <20060726031446.GD4829@opus.vpn-dev.reflex>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jason Lunz <lunz@falooley.org>
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@suse.cz>, linux-ide@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>

Your v3 patch worked for me on an NF3 system, modulo video issues
I've yet to track down.  It looks like that was otherwise the "last"
bug blocking S3 from working on that box.

I can't say the same for an NF2 system, unfortunately.  :(

- Dave
