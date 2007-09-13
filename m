From: Tejun Heo <htejun@gmail.com>
Subject: Re: HSM violation on bootup, ICH7 + ata_piix 2.6.22
Date: Thu, 13 Sep 2007 22:09:22 +0200
Message-ID: <46E998F2.8070301@gmail.com>
References: <46E254D7.5020902@gmail.com> <1189414783.13360.16.camel@ukabzc383.uk.saic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:9521 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755675AbXIMULS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Sep 2007 16:11:18 -0400
Received: by wa-out-1112.google.com with SMTP id v27so733423wah
        for <linux-ide@vger.kernel.org>; Thu, 13 Sep 2007 13:11:08 -0700 (PDT)
In-Reply-To: <1189414783.13360.16.camel@ukabzc383.uk.saic.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Eamonn Hamilton <EAMONN.HAMILTON@saic.com>
Cc: linux-ide@vger.kernel.org, ballen@gravity.phys.uwm.edu

Eamonn Hamilton wrote:
> Thanks for that, I checked the disks and sure enough they were in an
> extended self test, I aborted that and it's all back to normal.
> 
> the only problem, however, is that the system is already running version
> 5.37 of the smartmontools package, which is the most recent as I
> understand it? I don't really want to leave the system with it's disks
> unmonitored, is there anything I can be doing to prevent this behaviour?

Hmmm... That gotta be a different issue then.  Cc'ing Bruce and quoting
the original report.

Eamonn Hamilton wrote:
> > Hi,
> >
> > I'm looking ta a Dell SC440 system for a friend, and it's giving HSM
> > violations at startup.
> >
> > The system itself has an ICH7 chipset, with two seagate ST3160812AS
> > drives attached along with a single ST3400832AS, running kernel 2.6.22
> > and the ata_piix driver.
> >
> > I'm guessing this isn't good  :(
> >
> > Anybody gt any suggestions?
> >
> > The violations are :
> >
> >
> > ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> > ata1.00: cmd b0/d2:f1:00:4f:c2/00:00:00:00:00/00 tag 0 cdb 0x0 data
> > 123392 in
> >          res 50/00:f1:00:4f:c2/00:00:00:00:00/00 Emask 0x202 (HSM
> > violation)

-- 
tejun
