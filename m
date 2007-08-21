From: Brandon Philips <brandon@ifup.org>
Subject: Re: Question about "Disk might not be spun down properly"
Date: Tue, 21 Aug 2007 09:59:28 -0700
Message-ID: <20070821165928.GA15287@ifup.org>
References: <17631.80.127.80.206.1187693752.squirrel@webmail.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hu-out-0506.google.com ([72.14.214.237]:17291 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754224AbXHUQ7g (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 21 Aug 2007 12:59:36 -0400
Received: by hu-out-0506.google.com with SMTP id 19so2261388hue
        for <linux-ide@vger.kernel.org>; Tue, 21 Aug 2007 09:59:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <17631.80.127.80.206.1187693752.squirrel@webmail.xs4all.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Vahid <vahid@xs4all.nl>
Cc: linux-ide@vger.kernel.org

On 12:55 Tue 21 Aug 2007, Vahid wrote:
> Recently I noticed that I have been getting the following message
> everytime I shutdown my PC.
> 
> "DISK MIGHT NOT BE SPUN DOWN PROPERLY. UPDATE SHUTDOWN UTILITY"
> 
> I have also checked your website at http://linux-ata.org/shutdown.html.
> 
> I just recently reinstalled Linux (Debian Etch), and noticed that I have
> been getting this problem, currently I am using kernel 2.6.22.2. I must
> say that I am pretty new to this issue and currently can't seem to figure
> out how to resolve this. I do see a warning during shutdown and am also
> using a new kernel.

The Debian bug is here:
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=426224

However, it looks like things are moving slowly.  :(  Other distros are
carrying fixes so it seems like it should be a non-issue getting this
fixed.

In any case, this has been annoying me also so I will try and help out
when I get a chance.

Hope that helps.

	Brandon
