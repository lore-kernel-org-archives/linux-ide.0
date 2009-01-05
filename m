From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Some IDE issues with 2.6.28 on PC-Engines ALIX2
Date: Mon, 5 Jan 2009 19:10:47 +0100
Message-ID: <200901051910.48173.bzolnier@gmail.com>
References: <49615667.9020408@iwl.com> <200901051838.37608.bzolnier@gmail.com> <20090105180048.4b00118d@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:64966 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbZAESK4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jan 2009 13:10:56 -0500
Received: by bwz14 with SMTP id 14so22969709bwz.13
        for <linux-ide@vger.kernel.org>; Mon, 05 Jan 2009 10:10:54 -0800 (PST)
In-Reply-To: <20090105180048.4b00118d@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Karl Auerbach <karl@iwl.com>, linux-ide@vger.kernel.org, karl@cavebear.com, "Martin K. Petersen" <mkp@mkp.net>

On Monday 05 January 2009, Alan Cox wrote:
> 
> > [1] in fact some SSD devices present themselves as CF devices
> 
> As do some rotating disks.

Hmm.  I now recall that Microdrives can indeed do this.

What a mess...  I'll remove CFA check for now.

Thanks,
Bart
