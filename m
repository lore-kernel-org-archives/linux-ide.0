From: Stefan Smietanowski <stesmi@stesmi.com>
Subject: Re: Promise IDE controller crashes 2.4.22
Date: Fri, 28 Nov 2003 04:22:02 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <3FC6BF5A.6050204@stesmi.com>
References: <slrnbsche8.2ir.jgoerzen@christoph.complete.org> <200311272042.19568.bzolnier@elka.pw.edu.pl> <20031127225508.GA5926@complete.org> <200311280016.48828.bzolnier@elka.pw.edu.pl> <20031128022439.GA8333@complete.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from as13-5-5.has.s.bonet.se ([217.215.179.23]:30592 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S261936AbTK1DTb
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 Nov 2003 22:19:31 -0500
In-Reply-To: <20031128022439.GA8333@complete.org>
List-Id: linux-ide@vger.kernel.org
To: John Goerzen <jgoerzen@complete.org>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-ide@vger.kernel.org

Hi John.

>>>>Can you try setting drive to use UDMA100 instead of UDMA133
>>>>(by something like 'hdparm -Xudma100 /dev/hda')?
> 
> 
> Tried that too, but I got: 
> 
> pi:~# hdparm -Xudma100 /dev/hde
> -X: missing value

Try -X69 (69 means udma100)

Formula is simple. UDMA mode you want + 64, ie UDMA5 = 5+64.

// Stefan

