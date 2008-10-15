From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: [patch 1/2] allow user to power off unused ports via sysfs
Date: Wed, 15 Oct 2008 09:43:58 -0700
Message-ID: <20081015094358.6af8dfec@appleyard>
References: <1222639114.12062.10.camel@hannibal>
	<20080929164913.6489445c@appleyard>
Reply-To: kristen.c.accardi@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:3035 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751757AbYJOQpz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Oct 2008 12:45:55 -0400
In-Reply-To: <20080929164913.6489445c@appleyard>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Jeffrey W. Baker" <jwbaker@gmail.com>, linux-ide@vger.kernel.org

On Mon, 29 Sep 2008 16:49:13 -0700
Kristen Carlson Accardi <kristen.c.accardi@intel.com> wrote:

> On Sun, 28 Sep 2008 14:58:34 -0700
> "Jeffrey W. Baker" <jwbaker@gmail.com> wrote:
> 
> > 
> > The problem is I didn't save any power this way :(  ThinkPad X61t was
> > using minimum 7.6W on a one-minute average before power_off, and same
> > power after power_off.  I'd been led to believe that disabling these
> > ports would have a substantial power saving effect.
> > 
> > -jwb
> > 
> 
> Hi Jeffrey - the reason you are not seeing any power savings is 
> that this patch isn't actually powering off the ports.  I swear this
> used to work... but I confirmed today it is not doing what it is
> supposed to do.  I'll send out a reworked patch as soon as I figure
> out what the problem is.
> 
> Kristen
> 

Hi - I took another look at this patch - and I was wrong, it is 
working just fine for me.  the reason I thought it wasn't working
was because I was trying to power off a dummy port (doh).  I
confirmed with a power meter that you should see .2 Watts per
port saved when powering down an unused port.  Just keep in mind
that you can't power off an occupied port, and don't do like I
did and try to power off a dummy port.  
