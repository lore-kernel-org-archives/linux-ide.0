From: Tejun Heo <tj@kernel.org>
Subject: Re: Long delays when waking up from suspend-to-ram on Gigabyte MB
 with JMicron controller
Date: Thu, 6 Dec 2012 09:34:47 -0800
Message-ID: <20121206173447.GP19802@htj.dyndns.org>
References: <50BEA22A.1020300@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:57118 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423100Ab2LFRew (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Dec 2012 12:34:52 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so4591185pad.19
        for <linux-ide@vger.kernel.org>; Thu, 06 Dec 2012 09:34:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <50BEA22A.1020300@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>, butz.tsai@gmail.com
Cc: Show Lu <showlu@jmicron.com>, Mehmet Giritli <mehmet@giritli.eu>, Steven Chen <stevenchen@jmicron.com>, Orson <orson.wellies@gmail.com>, Aries Lee <arieslee@jmicron.com>, Jonathan Nieder <jrnieder@gmail.com>, linux-ide@vger.kernel.org

Let's hope Justin is still there.

On Wed, Dec 05, 2012 at 09:23:54AM +0800, Aaron Lu wrote:
> Hi Show,
> 
> Can you please take a look at the following bugzilla? Mehmet has
> problems resuming his system, the port keeps reporting connection status
> change event:
> https://bugzilla.kernel.org/show_bug.cgi?id=47831
> 
> This is kind of like the issue I found here:
> http://marc.info/?l=linux-ide&m=132609120812842&w=2
> 
> Suggestions are welcome.
> 
> The fact that Windows does not have a problem with the card made me
> think:
> 1 Either Linux's driver has a problem;
> 2 Or Windows' driver has a quirk but we don't know.
> 
> Thanks,
> Aaron
> 

-- 
tejun
