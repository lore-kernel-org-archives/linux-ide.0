From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: new tool:  blktool
Date: Sun, 15 Aug 2004 18:07:37 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <411FDEA9.2010802@pobox.com>
References: <411FD744.2090308@pobox.com> <1092603321.18410.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5003 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267171AbUHOWH6
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Aug 2004 18:07:58 -0400
In-Reply-To: <1092603321.18410.5.camel@localhost.localdomain>
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Alan Cox wrote:
> On Sul, 2004-08-15 at 22:36, Jeff Garzik wrote:
> 
>>	$ hdparm -c1 /dev/hda
>>		becomes
>>	$ blktool /dev/hda pio-data 32-bit
> 
> 
> So you've replaced hdparm's weird but unixish command line with an
> even more demented non linuxish one that doesn't handle regexps for
> drive names ?
> 
> Whatever happened to
> 
> 	blktool /dev/hda --pio-data=32


Yep, it's more like ethtool(8) or cvs(1) in its syntax.  There is big 
difference in usability (for me anyway) between "command [options]..." 
and an unordered list of --args.  Especially as the list of commands 
grows longer.  It provides more structure.

Each command can have options, --foo-bar=baz if you like, I suppose.

	Jeff


