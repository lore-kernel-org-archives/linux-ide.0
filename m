From: "Stanislav Brabec" <sbrabec@novell.com>
Subject: Re: regression: ide-floppy doesn't work with IOMEGA IDE ZIP
	drive
Date: Wed, 14 Mar 2007 11:19:07 +0100
Message-ID: <45F7DA2B0200002D0001585E@emea5-mh.id5.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:44701 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161049AbXCNKTS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Mar 2007 06:19:18 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: jeff@garzik.org, bzolnier@gmail.com, htejun@gmail.com, alan@lxorguk.ukuu.org.uk, paul@paulbristow.net, chrubis@suse.cz, linux-ide@vger.kernel.org

Albert Lee wrote:
> Tejun Heo wrote:

> > Hmmm... weird.  Your drive bears the same model name as Stanislav's.  I
> > don't think the low level driver is causing the difference.  They both
> > use the standard libata HSM implementation.  Any ideas?  Stanislav, can
> > you try to connect that zip drive to another IDE controller?

> Maybe it's also worth a try to replace the medium, cable or even the
> drive itself to rule out the possibility of hardware problem.

I'll try it. I cannot replace the drive, I don't have any spare one, but
my colleague has. He will try it on his machine. So let's wait for
result.

Looking at the syslog in Novell bug 232086 in detail, following line may
indicate hardware failure:
usb 5-1: string descriptor 0 read error: -22

My drive is a slave on bus, where master is a modern Seagate ST3160812A.

On my system I see two regressions:
- One between year 2002 kernels and SuSE Linux 10.0:
  Delay with "packet command initiated yet DRQ isn't asserted" before
  first read access, then the read will succeed.
  I did not yet reproduce this regression just now on my hardware.
- Second between SuSE 10.1 and 10.2:
  Delay with "packet command initiated yet DRQ isn't asserted" before
  any attempt to access, then it will fail.
  This regression is reproducible just now on my hardware, but still may
  be caused by hardware problems raised by a slightly different
  initialization order.

Tejun Heo wrote:
> [libata]
> And, as the device requires custom high level driver, libata fails
> miserably.  Would it be worth to try support these devices?  Or are
> they just too outdated to put the effort in?

As far as I remember, it was working without any special driver with
ide-scsi.

-- 
Best Regards,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec@suse.cz
Lihovarska 1060/12                            tel: +420 284 028 966
190 00 Praha 9                                fax: +420 284 028 951
Czech Republic                                http://www.suse.cz/

