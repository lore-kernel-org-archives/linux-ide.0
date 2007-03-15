From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: regression: ide-floppy doesn't work with IOMEGA IDE ZIP drive
Date: Thu, 15 Mar 2007 20:58:44 +0100
Message-ID: <200703152058.45159.bzolnier@gmail.com>
References: <45F7DA2B0200002D0001585E@emea5-mh.id5.novell.com> <45F80841.EMEA5.EMEA5-1.100.1396E6E.1.3873.1@1:7.EMEA5.EMEA5-1.100.0.1.0.1@16> <1173904909.5181.16.camel@utx.utx.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:48826 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933797AbXCOUUk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Mar 2007 16:20:40 -0400
Received: by ug-out-1314.google.com with SMTP id 44so480723uga
        for <linux-ide@vger.kernel.org>; Thu, 15 Mar 2007 13:20:34 -0700 (PDT)
In-Reply-To: <1173904909.5181.16.camel@utx.utx.cz>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Stanislav Brabec <sbrabec@novell.com>
Cc: albertl@mail.com, jeff@garzik.org, htejun@gmail.com, alan@lxorguk.ukuu.org.uk, paul@paulbristow.net, chrubis@suse.cz, linux-ide@vger.kernel.org


On Wednesday 14 March 2007, Stanislav Brabec wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > On Wednesday 14 March 2007, Stanislav Brabec wrote:
> > > Albert Lee wrote:
> > > > Tejun Heo wrote:
> > > 
> > > > > Hmmm... weird.  Your drive bears the same model name as Stanislav's.  I
> > > > > don't think the low level driver is causing the difference.  They both
> > > > > use the standard libata HSM implementation.  Any ideas?  Stanislav, can
> > > > > you try to connect that zip drive to another IDE controller?
> > > 
> > > > Maybe it's also worth a try to replace the medium, cable or even the
> > > > drive itself to rule out the possibility of hardware problem.
> > > 
> > > I'll try it. I cannot replace the drive, I don't have any spare one, but
> > > my colleague has. He will try it on his machine. So let's wait for
> > > result.
> > > 
> > > Looking at the syslog in Novell bug 232086 in detail, following line may
> > > indicate hardware failure:
> > > usb 5-1: string descriptor 0 read error: -22
> > > 
> > > My drive is a slave on bus, where master is a modern Seagate ST3160812A.
> > > 
> > > On my system I see two regressions:
> 
> > 
> > It is reproduceable, SuSE 10.1 kernel is "good" and SuSE 10.2 is "bad".
> > So even if this is caused by some hardware problems or different
> > initialization order git-bisect on 2.6.16-2.6.20 should tell us what
> > change caused the problem.
> 
> After more kernels testing I am inclined to suspect broken hardware.
> 
> 2.4.20 (SuSE 8.1) and newer kernels  exhibits this "DRQ isn't asserted"
> error. The latest kernel working without any problem is five years old
> 2.4.18 (SuSE 8.0).
> 
> In some older systems the delay was "hidden" somewhere in the boot
> process, now userspace processes repeatedly scan all media, which makes
> delay permanent.

I'm lost, weren't you saying that there are two problems actually:

* "DRQ isn't asserted" one which has always been there (but ide-floppy works)

* the 2.6.16->2.6.20 (SuSE 10.1->10.2) regression (ide-floppy doesn't work)

?

Bart
