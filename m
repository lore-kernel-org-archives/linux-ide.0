From: Derry Bryson <derry@high-rely.com>
Subject: RE: Problem w/ hotplug on sata_sil24 w/ PMP (sil3726)
Date: Fri, 22 Jul 2011 19:34:37 +0000
Message-ID: <359604ECF8F440408B9634E6146249B4322F26B6@mail.scl.local>
References: <359604ECF8F440408B9634E6146249B4321BDEE6@mail.scl.local>
 <20110712150113.GC4347@mtj.dyndns.org>
 <359604ECF8F440408B9634E6146249B4321C2569@mail.scl.local>
 <20110713133425.GP2872@htj.dyndns.org>
 <20110713143936.GQ2872@htj.dyndns.org>
 <359604ECF8F440408B9634E6146249B4321C2695@mail.scl.local>
 <20110714071459.GB3455@htj.dyndns.org>
 <359604ECF8F440408B9634E6146249B4322F1E0A@mail.scl.local>
 <20110721090022.GF3455@htj.dyndns.org>
 <359604ECF8F440408B9634E6146249B4322F2566@mail.scl.local>
 <20110722095037.GJ2622@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cal3-mh484-a.smtproutes.com ([208.70.89.247]:36287 "EHLO
	cal3-mh484-a.smtproutes.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755166Ab1GVTe6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 Jul 2011 15:34:58 -0400
In-Reply-To: <20110722095037.GJ2622@htj.dyndns.org>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "tj@kernel.org" <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

I did some testing with a PMP board containing a Sil3726 with firmware
Version 1.0124 and a PMP/Raid board with a JMicron 393 configured as
PMP only.  I am connecting to a Sil3124 esata pci controller.  

The Sil3726 board acted the same as the previous Sil3726 board with the 1.0114
firmware.

The JMicron board worked much better.  It works properly with a stock 
kernel and does not fail the IDENTIFY after hotplugging and does
not require retries.  It seems to wait for the drive to spin up before
doing anything so it works properly the first time without retries or
hard resets.  The only problem I saw was that it seemed to not work at
all a couple of times if not powered up/connected before booting Linux.  
Couldn't see it at all, even after several power cycles and unplugging/pluggin
esata cable.  I need  to test this more as it is inconsistent and may 
have to do with the Sil3124 controller rather than the JMicron PMP.

Derry Bryson
Sr. Software Engineer 

Highly Reliable Systems
www.High-Rely.com
"Making Backup Invisible"

Phone: 775.329.5139 X129
Fax:     775.370.1001

Sales & Support: 877.384.6838

This e-mail and any files transmitted with it are the property of Highly Reliable Systems, Inc. This (email) information is confidential, and is intended solely for the use of the individual or entity to whom this e-mail is addressed. If you are not one of the named recipient(s) or otherwise have reason to believe that you have received this message in error, please notify the sender and delete this message immediately from your computer. Any other use, disclosure, retention, dissemination, forwarding, printing, distribution or copying of this e-mail is strictly prohibited.



> -----Original Message-----
> From: Tejun Heo [mailto:htejun@gmail.com] On Behalf Of tj@kernel.org
> Sent: Friday, July 22, 2011 2:51 AM
> To: Derry Bryson
> Cc: linux-ide@vger.kernel.org
> Subject: Re: Problem w/ hotplug on sata_sil24 w/ PMP (sil3726)
> 
> Hello,
> 
> On Thu, Jul 21, 2011 at 04:22:07PM +0000, Derry Bryson wrote:
> > Here are the specs on the port multiplier board:
> >
> > Lycom ST-126RM (http://www.lycom.com.tw/)
> > Sil3726 chip revision 17
> > EEPROM FW Version: 1.0114
> >
> > Also there is another problem:  ports that are not connected at power
> on
> > are ignored until a port that was connected at power on is
> hotplugged.  So,
> > for instance, if I turn the unit on with only a drive on the first
> port, the
> > other four ports will not work and I don't even see kernel messages
> when
> > hotplugging until I hotplug the first port.  I haven't looked into
> this yet,
> > but it would seem the driver must be disabling the ports and they are
> not
> > looked at again until the hard reset is performed.
> 
> That's most likely the sil pmp itself.  It has been known to show
> erratic behavior if the first port is not occupied during power up.  I
> don't know whether later firmware updates fixed that tho.  Can you get
> hold of a marvell PMP and see how it behaves?
> 
> Thanks.
> 
> --
> tejun
> 
> 
> -----
> No virus found in this message.
> Checked by AVG - www.avg.com
> Version: 10.0.1390 / Virus Database: 1518/3779 - Release Date: 07/21/11

