From: "Thue Janus Kristensen" <thuejk@gmail.com>
Subject: Re: hdb: irq timeout: status=0xd0 { Busy }
Date: Fri, 23 Feb 2007 14:30:03 +0100
Message-ID: <2fa647f60702230530x48e5d558o422825892e428d1d@mail.gmail.com>
References: <2fa647f60702230519u4dc178b8s6c28948cd824272d@mail.gmail.com>
	 <20070223142840.7c771453@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.186]:45193 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932332AbXBWNaF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Feb 2007 08:30:05 -0500
Received: by mu-out-0910.google.com with SMTP id g7so428906muf
        for <linux-ide@vger.kernel.org>; Fri, 23 Feb 2007 05:30:03 -0800 (PST)
In-Reply-To: <20070223142840.7c771453@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

On 2/23/07, Alan <alan@lxorguk.ukuu.org.uk> wrote:
> > Feb 20 23:15:17 localhost kernel: hdb: irq timeout: status=0xd0 { Busy }
> > Feb 20 23:15:27 localhost kernel: ide: failed opcode was: unknown
> > Feb 20 23:15:27 localhost kernel: hdb: status timeout: status=0xd0 { Busy }
> > Feb 20 23:15:27 localhost kernel: ide: failed opcode was: unknown
>
> Your CD-ROM drive stopped responding
>
> > Feb 20 23:17:30 localhost kernel: ide: failed opcode was: unknown
> > Feb 20 23:17:30 localhost kernel: hdb: drive not ready for command
> > Feb 20 23:17:36 localhost kernel: hdb: status timeout: status=0xd0 { Busy }
> > repeats infinitely.
>
> and never came back.
>
> It would be very interesting to know if an older kernel doesn't trigger
> this.

I can keep running 2.6.16.41 for a few weeks. If the problem does not
occur by then it is reasonably probably that it is newly introduced.
As I said, I am not able to trigger the problem intentionally :(.

Would it be possible for the kernel to realize that the drive stopped
responding? And make sure that it doesn't make the whole computer
unresponsive...

Regards, Thue
