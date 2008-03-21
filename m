From: osb972ww-linuxczmil@yahoo.com
Subject: Re: Fw: 2.6.24.X: SATA/AHCI related boot delay. - not with 2.6.24.3
Date: Thu, 20 Mar 2008 20:04:13 -0700 (PDT)
Message-ID: <217535.99274.qm@web34505.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754338AbYCUDE0@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org


HI Tejun,

  setting irqpoll fixed both problems, and there are no "nasty grams" in dmesg now.   The original reason I was trying to use the hdparm -u on /dev/sda was because it was hanging for a few seconds when doing writes to the CFdisk, and in the past that was the kind of thing that hdparm -u would generally fix.   Now with the irqpoll kernel option, the /dev/sdb SATA drive was found, and I can mount it and write to it.  The CFcard /dev/sda is also responding to writes better than before.

Thanks for the suggestion to use irqpoll.    What is the problem within the driver(s) that is requiring irqpoll. ?

Best regards,
C. W. Wright



----- Original Message ----
> From: Tejun Heo <htejun@gmail.com>
> To: osb972ww-linuxczmil@yahoo.com
> Cc: linux-kernel@vger.kernel.org; IDE/ATA development list <linux-ide@vger.kernel.org>
> Sent: Thursday, March 20, 2008 10:23:50 PM
> Subject: Re: Fw: 2.6.24.X: SATA/AHCI related boot delay. - not with 2.6.24.3
> 
> Hello,
> 
> osb972ww-linuxczmil@yahoo.com wrote:
> >  Greetings,
> >   I'm having a problem with 2.6.23.1-42 (Fedora 8) properly driving a SATA 
> > drive.  Although it is detected during boot as indicated by the dmesg below, 
> > once the sytstem is up and running, the drive is not accessible.   The second 
> > issue is with the CFdrive on the the primary IDE.  It works, but I can't 
> enable 
> > interrupts with hdparm -u 1 /dev/sda.   
> > 
> >  The interesting thing is when I put in a Fedora 5 system with a 2.6.17 
> kernel, 
> > everything works as expected.  I can hdparm -u 1 /dev/hda and it works as  
> expected, and
> >  the SATA drive is detected and works properly all on the exact  same 
> hardware.  
> >  
> >  I've tried several different SATA drives also.   Thery all work on the old 
> >  Fedora 5/ 2.6.17 system, and none work on Fedora 8/2.6.23 or 2.6.24 kernels.
> 
> Does irqpoll kernel parameter help?
> 
> -- 
> tejun
> 
