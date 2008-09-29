From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: [patch 1/2] allow user to power off unused ports via sysfs
Date: Mon, 29 Sep 2008 16:49:13 -0700
Message-ID: <20080929164913.6489445c@appleyard>
References: <1222639114.12062.10.camel@hannibal>
Reply-To: kristen.c.accardi@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:12559 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751896AbYI2Xtt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 29 Sep 2008 19:49:49 -0400
In-Reply-To: <1222639114.12062.10.camel@hannibal>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Jeffrey W. Baker" <jwbaker@gmail.com>
Cc: linux-ide@vger.kernel.org

On Sun, 28 Sep 2008 14:58:34 -0700
"Jeffrey W. Baker" <jwbaker@gmail.com> wrote:

> 
> The problem is I didn't save any power this way :(  ThinkPad X61t was
> using minimum 7.6W on a one-minute average before power_off, and same
> power after power_off.  I'd been led to believe that disabling these
> ports would have a substantial power saving effect.
> 
> -jwb
> 

Hi Jeffrey - the reason you are not seeing any power savings is 
that this patch isn't actually powering off the ports.  I swear this
used to work... but I confirmed today it is not doing what it is
supposed to do.  I'll send out a reworked patch as soon as I figure
out what the problem is.

Kristen

