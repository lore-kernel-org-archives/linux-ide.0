From: Derry Bryson <derry@high-rely.com>
Subject: RE: Problem w/ hotplug on sata_sil24 w/ PMP (sil3726)
Date: Thu, 21 Jul 2011 16:22:07 +0000
Message-ID: <359604ECF8F440408B9634E6146249B4322F2566@mail.scl.local>
References: <359604ECF8F440408B9634E6146249B42923805F@mail.scl.local>
 <20110628095723.GC3386@htj.dyndns.org>
 <359604ECF8F440408B9634E6146249B4321BDEE6@mail.scl.local>
 <20110712150113.GC4347@mtj.dyndns.org>
 <359604ECF8F440408B9634E6146249B4321C2569@mail.scl.local>
 <20110713133425.GP2872@htj.dyndns.org>
 <20110713143936.GQ2872@htj.dyndns.org>
 <359604ECF8F440408B9634E6146249B4321C2695@mail.scl.local>
 <20110714071459.GB3455@htj.dyndns.org>
 <359604ECF8F440408B9634E6146249B4322F1E0A@mail.scl.local>
 <20110721090022.GF3455@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cal3-mh481-a.smtproutes.com ([208.70.89.235]:55849 "EHLO
	cal3-mh481-a.smtproutes.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751949Ab1GUQW2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 21 Jul 2011 12:22:28 -0400
In-Reply-To: <20110721090022.GF3455@htj.dyndns.org>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "tj@kernel.org" <tj@kernel.org>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Tejun: 

Here are the specs on the port multiplier board:

Lycom ST-126RM (http://www.lycom.com.tw/)
Sil3726 chip revision 17
EEPROM FW Version: 1.0114

Also there is another problem:  ports that are not connected at power on
are ignored until a port that was connected at power on is hotplugged.  So,
for instance, if I turn the unit on with only a drive on the first port, the
other four ports will not work and I don't even see kernel messages when
hotplugging until I hotplug the first port.  I haven't looked into this yet,
but it would seem the driver must be disabling the ports and they are not
looked at again until the hard reset is performed.

Let me know if I can help in any way.

Thanks,

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
> Sent: Thursday, July 21, 2011 2:00 AM
> To: Derry Bryson
> Cc: linux-ide@vger.kernel.org
> Subject: Re: Problem w/ hotplug on sata_sil24 w/ PMP (sil3726)
> 
> On Thu, Jul 14, 2011 at 05:37:37PM +0000, Derry Bryson wrote:
> > Hi:
> >
> > Dmesg with second timing value set to 1000 always, hotplugging WD 3TB
> drive:
> >
> > [  139.145917] ata5.00: exception Emask 0x10 SAct 0x0 SErr 0x4050000
> action 0xf
> > [  139.156180] ata5.00: SError: { PHYRdyChg CommWake DevExch }
> > [  139.166619] ata5.00: hard resetting link
> > [  140.430401] ata5.00: SATA link up 3.0 Gbps (SStatus 123 SControl
> 320)
> > [  140.430453] ata5.00: issuing IDENTIFY
> > [  140.430480] ata5.00: IDENTIFY failed, irq_stat=0x60002 cerr=4
> > [  140.430521] ata5.00: failed to IDENTIFY (I/O error, err_mask=0x11)
> ...
> > [  145.431276] ata5.00: hard resetting link
> > [  145.431298] ata5.00: XXXX hardreset hotplugged = false
> > [  145.431304] ata5.00: XXX0 hardreset debounce 5 100 2000
> > [  145.431310] ata5.00: XXX1 hardreset debounce 5 1000 2000
> > [  146.690413] ata5.00: SATA link up 3.0 Gbps (SStatus 123 SControl
> 320)
> ...
> > [  152.940451] ata5.00: issuing IDENTIFY
> > [  152.940477] ata5.00: IDENTIFY failed, irq_stat=0x60002 cerr=4
> > [  152.940518] ata5.00: failed to IDENTIFY (I/O error, err_mask=0x11)
> 
> So, no change.  Weird.  I think we need to implement retry backoff
> properly anyways but am still wondering why probing failure behaves
> differently for you.  I'll try with similar drive but maybe it's
> difference in PMP firmware?
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
> Version: 10.0.1390 / Virus Database: 1518/3777 - Release Date: 07/20/11

