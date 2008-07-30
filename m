From: "Tvrtko A. Ursulin" <tvrtko@ursulin.net>
Subject: Re: 2.6.26 DVD playing regression with libata
Date: Wed, 30 Jul 2008 07:57:29 +0100
Message-ID: <200807300757.29520.tvrtko@ursulin.net>
References: <200807292323.28033.tvrtko@ursulin.net> <20080730002011.21947c32@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mk-outboundfilter-5.mail.uk.tiscali.com ([212.74.114.1]:40204
	"EHLO mk-outboundfilter-5.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751208AbYG3G5d (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jul 2008 02:57:33 -0400
In-Reply-To: <20080730002011.21947c32@lxorguk.ukuu.org.uk>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Wednesday 30 July 2008 00:20:11 Alan Cox wrote:
> > Jul 29 21:10:03 media kernel: [353032.319013] sr 2:0:0:0: [sr0] unaligned
> > transfer Jul 29 21:10:03 media kernel: [353032.319013] sr 2:0:0:0: [sr0]
> > unaligned transfer
>
> This is coming from the scsi/block layer and definitely isn't good.
> Doesn't directly look like a libata bug but seems to be higher up the
> stack. What software is triggering this ?

I tried to reproduce it now but could not.

After a fresh boot into 2.6.26, I first tried mounting the DVD which was fine. Then I ran lsdvd which also worked and finally mplayer without any problems. In 
contrast to that yesterday I ran my playdvd.pl (http://www.ursulin.net/2008/06/effectively-using-mplayer-within-mythtv/) script from within MythTV and it 
exited immediately. It looked like either it triggered that failure without any delay or subsystem was already in that failure mode by simple DVD insertion. 
When ran directly lsdvd would exit being unable to open /dev/dvd (/dev/scdo). Unfortunately I didn't debug it further at the time.

The only difference is that yesterday box had an uptime of couple of days while this morning it was completely fresh. Unless mounting the disc before 
everything else somehow stabilised something. Hm let me do another reboot... no, still can't reproduce it.

One interesting thing, sometimes it detects drive capabilities like this:
[    3.498951] sr0: scsi3-mmc drive: 62x/62x writer dvd-ram cd/rw xa/form2 cdda tray

And sometimes like this:
[    3.514104] sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray

Later I think is correct according to drive datasheet.

I will keep 2.6.26 running and see if the problem comes back in following days.

Tvrtko
