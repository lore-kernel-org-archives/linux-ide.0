From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: new tool:  blktool
Date: Sun, 15 Aug 2004 21:55:22 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <1092603321.18410.5.camel@localhost.localdomain>
References: <411FD744.2090308@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from the-village.bc.nu ([81.2.110.252]:16097 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267184AbUHOV5l (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Aug 2004 17:57:41 -0400
In-Reply-To: <411FD744.2090308@pobox.com>
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On Sul, 2004-08-15 at 22:36, Jeff Garzik wrote:
> 	$ hdparm -c1 /dev/hda
> 		becomes
> 	$ blktool /dev/hda pio-data 32-bit

So you've replaced hdparm's weird but unixish command line with an
even more demented non linuxish one that doesn't handle regexps for
drive names ?

Whatever happened to

	blktool /dev/hda --pio-data=32

