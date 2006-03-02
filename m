From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: libata queue contents
Date: Wed, 1 Mar 2006 19:27:40 -0800
Message-ID: <20060301192740.1172e579.rdunlap@xenotime.net>
References: <20060301203901.GA6915@havoc.gtf.org>
	<44063E09.1060303@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:47338 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750870AbWCBD0S (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 1 Mar 2006 22:26:18 -0500
Received: from midway.site ([71.111.157.99]) by xenotime.net for <linux-ide@vger.kernel.org>; Wed, 1 Mar 2006 19:26:17 -0800
In-Reply-To: <44063E09.1060303@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: jeff@garzik.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 01 Mar 2006 19:36:25 -0500 Mark Lord wrote:

> Jeff Garzik wrote:
> > Here's the stuff that's pending for 2.6.17, in the
> > libata-dev.git#upstream branch.  These changes are also auto-propagated
> > to Andrew Morton's -mm via the #ALL meta-branch.
> 
> Where are Randy's ACPI patches ?

I haven't generated them against #upstream.  I'll try to do that
in the next couple of days (assuming that I can git along with git).
or can I use the git-rollup patch in -mm to diff against?

---
~Randy
