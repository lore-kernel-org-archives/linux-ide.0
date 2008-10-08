From: "Rob Whitton" <rwhitton@bluearc.com>
Subject: RE: "SCR access via SIDPR is available but doesn't work"
Date: Wed, 8 Oct 2008 11:37:09 +0100
Message-ID: <3D76E016F4A2A749A1EB1A3FD83E22BC01E0D723@uk-email.terastack.bluearc.com>
References: <3D76E016F4A2A749A1EB1A3FD83E22BC01D6E466@uk-email.terastack.bluearc.com> <48E6D8F4.2080207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from p01c12o143.mxlogic.net ([208.65.145.66]:43190 "EHLO
	p01c12o143.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248AbYJHLGi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Oct 2008 07:06:38 -0400
Content-class: urn:content-classes:message
In-Reply-To: <48E6D8F4.2080207@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org



> -----Original Message-----
> From: Tejun Heo [mailto:htejun@gmail.com]
> Sent: 04 October 2008 03:46
> To: Rob Whitton
> Subject: Re: "SCR access via SIDPR is available but doesn't work"
> 
> Hello,
> 
> Sorry for the late reply.  I was traveling.  Can you please cc
> linux-ide@vger.kernel.org when replying?  And if possible please use
> plain text instead of html.
> 
> Rob Whitton wrote:
> > I'm sorry to trouble you but I believe that you were the author of
> > the patch that generates the message in the subject of this
> > email. This patch appears to have been giving us considerable
> > problems on motherboards using the Intel ICH9R IO chip under some
> > circumstances.  When we have a sata disk attached to the second sata
> > controller (address xxxx:xx:1f.5) in the intel device then (it seems
> > to depend on timing we can get it to work sometimes) this piece of
> > code activates and Linux then fails to boot from the sata disk
> > although we can see from the log that it has managed to get as far
> > as querying the manufacturer info from the disk.
> >
> > We have worked around the problem by forcing AHCI mode in the BIOS
> > so we are using the Linux ahci driver rather than ata_piix this
> > works fine.
> >
> > I have attached two boot log files. One shows Linux booting fine
> > with the sata disk plugged into SATA port 0 which uses the first
> > sata controller (address 0000:00:1f.2) and one with the sata disk
> > plugged into SATA port 5 which uses the second sata controller
> > (address 0000:00:1f.5). In the failing case the last output in the
> > boot log is Attached SCSI disk. Linux makes no further progress to
> > boot after this point. All other aspects of the test are identical,
> > the only change is to move the SATA disk from port 0 to port 5.
> >
> > As I mentioned we have a work around for the problem so this email
> > is just for your information. I would be interested in your thoughts
> > of course.
> 
> That's one strange failure mode.  I can't really think of anything
> libata can do to cause such behavior.  After the booting stops, is the
> machine alive?  Can you turn the numlock LED on/off by pressing the
> numlock button?  Can you capture the output of sysrq-t
> (ctrl-alt-sysrq-t)?
> 
> Thanks.
> 
> --
> tejun

I have run this test and I can confirm that NumLock does still work,
although unreliably. What I mean by this is that once we get to this
point often it takes a number of presses of numlock to get the state of
the LED to change. Before we get to this point it seems to behave fine.
Ctrl-alt-sysrq-t doesn't appear to dump anything to the console. After
doing ctrl-alt-sysrq-t numlock no longer functions at all.

Something I forgot to mention in my original email is that using
"noapic" at boot is also a work around for the problem. It isn't an
option for us as we are going to be using advanced features such as MSI
that are only available via the APIC route.

I hope this helps.

Cheers

Rob




