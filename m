From: Stanislav Brabec <sbrabec@novell.com>
Subject: Re: regression: ide-floppy doesn't work with IOMEGA IDE ZIP drive
Date: Wed, 14 Mar 2007 21:41:48 +0100
Message-ID: <1173904909.5181.16.camel@utx.utx.cz>
References: <45F7DA2B0200002D0001585E@emea5-mh.id5.novell.com>
	 <45F80841.EMEA5.EMEA5-1.100.1396E6E.1.3873.1@1:7.EMEA5.EMEA5-1.100.0.1.0.1@16>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 7-165-207-85.strcechy.adsl-llu.static.bluetone.cz ([85.207.165.7]:53662
	"EHLO utx.utx.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964784AbXCNVP5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 Mar 2007 17:15:57 -0400
In-Reply-To: <45F80841.EMEA5.EMEA5-1.100.1396E6E.1.3873.1@1:7.EMEA5.EMEA5-1.100.0.1.0.1@16>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: albertl@mail.com, jeff@garzik.org, htejun@gmail.com, alan@lxorguk.ukuu.org.uk, paul@paulbristow.net, chrubis@suse.cz, linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Wednesday 14 March 2007, Stanislav Brabec wrote:
> > Albert Lee wrote:
> > > Tejun Heo wrote:
> > 
> > > > Hmmm... weird.  Your drive bears the same model name as Stanislav's.  I
> > > > don't think the low level driver is causing the difference.  They both
> > > > use the standard libata HSM implementation.  Any ideas?  Stanislav, can
> > > > you try to connect that zip drive to another IDE controller?
> > 
> > > Maybe it's also worth a try to replace the medium, cable or even the
> > > drive itself to rule out the possibility of hardware problem.
> > 
> > I'll try it. I cannot replace the drive, I don't have any spare one, but
> > my colleague has. He will try it on his machine. So let's wait for
> > result.
> > 
> > Looking at the syslog in Novell bug 232086 in detail, following line may
> > indicate hardware failure:
> > usb 5-1: string descriptor 0 read error: -22
> > 
> > My drive is a slave on bus, where master is a modern Seagate ST3160812A.
> > 
> > On my system I see two regressions:

> 
> It is reproduceable, SuSE 10.1 kernel is "good" and SuSE 10.2 is "bad".
> So even if this is caused by some hardware problems or different
> initialization order git-bisect on 2.6.16-2.6.20 should tell us what
> change caused the problem.

After more kernels testing I am inclined to suspect broken hardware.

2.4.20 (SuSE 8.1) and newer kernels  exhibits this "DRQ isn't asserted"
error. The latest kernel working without any problem is five years old
2.4.18 (SuSE 8.0).

In some older systems the delay was "hidden" somewhere in the boot
process, now userspace processes repeatedly scan all media, which makes
delay permanent.

-- 
Best Regards,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec@suse.cz
Lihovarska 1060/12                            tel: +420 284 028 966
190 00 Praha 9                                fax: +420 284 028 951
Czech Republic                                http://www.suse.cz/
