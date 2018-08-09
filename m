From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: linux: sata_nv: adma support
Date: Thu, 9 Aug 2018 13:48:52 +0200
Message-ID: <20180809114852.cwvyqeuilxv4qbsq@pali>
References: <201412232051.07067@pali>
 <201508021108.52978@pali>
 <CADLC3L3eym59Agpm2J_Oy_Eyfq=9iUTwi2BPxnLxoEM_Yx9cfw@mail.gmail.com>
 <201508042006.57727@pali>
 <20180510135157.awgoymyr2p5vbmlq@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180510135157.awgoymyr2p5vbmlq@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Robert Hancock <hancockrwd@gmail.com>, Jeff Garzik <jeff@garzik.org>, Robert Hancock <hancockr@shaw.ca>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

On Thursday 10 May 2018 15:51:57 Pali Rohár wrote:
> On Tuesday 04 August 2015 20:06:57 Pali Rohár wrote:
> > On Monday 03 August 2015 05:02:15 Robert Hancock wrote:
> > > On Sun, Aug 2, 2015 at 3:08 AM, Pali Rohár <pali.rohar@gmail.com>
> > > wrote:
> > > > On Sunday 02 August 2015 03:45:32 Robert Hancock wrote:
> > > >> On Sat, Aug 1, 2015 at 2:09 PM, Pali Rohár <pali.rohar@gmail.com>
> > > >> 
> > > >> wrote:
> > > >> > On Thursday 25 December 2014 07:22:13 Robert Hancock wrote:
> > > >> >> On Tue, Dec 23, 2014 at 1:51 PM, Pali Rohár
> > > >> >> <pali.rohar@gmail.com>
> > > >> >> 
> > > >> >> wrote:
> > > >> >> > Hello,
> > > >> >> > 
> > > >> >> > I have nvidia nforce4 motherboard with nvidia sata
> > > >> >> > controller:
> > > >> >> > 
> > > >> >> > 00:07.0 IDE interface [0101]: NVIDIA Corporation CK804 Serial
> > > >> >> > ATA Controller [10de:0054] (rev f3)
> > > >> >> > 00:08.0 IDE interface [0101]: NVIDIA Corporation CK804 Serial
> > > >> >> > ATA Controller [10de:0055] (rev f3)
> > > >> >> > 
> > > >> >> > I manually enabled adma mode (which is disabled by default)
> > > >> >> > by adding sata_nv.adma=1 to grub cmdline. In git history I
> > > >> >> > found that enabling adma mode includes NCQ support and
> > > >> >> > reduced CPU overhead. It looks like adma mode is working,
> > > >> >> > but at every boot I see one same error message in dmesg:
> > > >> >> > 
> > > >> >> > [   16.823514] ata1.00: exception Emask 0x1 SAct 0x0 SErr 0x0
> > > >> >> > action 0x0
> > > >> >> > [   16.823520] ata1.00: CPB resp_flags 0x11: , CMD error
> > > >> >> > [   16.823524] ata1.00: failed command: SET FEATURES
> > > >> >> > [   16.823530] ata1.00: cmd
> > > >> >> > ef/05:fe:00:00:00/00:00:00:00:00/40 tag 16
> > > >> >> > [   16.823530]          res
> > > >> >> > 51/04:fe:00:00:00/00:00:00:00:00/40 Emask 0x1 (device error)
> > > >> >> > [   16.823533] ata1.00: status: { DRDY ERR }
> > > >> >> > [   16.823535] ata1.00: error: { ABRT }
> > > >> >> > 
> > > >> >> > When adma is disabled then this error message is not
> > > >> >> > generated.
> > > >> >> 
> > > >> >> It looks like something is trying to issue a command to disable
> > > >> >> APM power management on the drive, and the command fails
> > > >> >> (likely because it doesn't support that command). I'm not sure
> > > >> >> where that would be coming from - I'm pretty sure the kernel
> > > >> >> doesn't issue that command itself. Something that's part of
> > > >> >> your distro perhaps?
> > > >> >> 
> > > >> >> I don't know why it would only be failing in ADMA mode either,
> > > >> >> though depending on where the command is coming from, maybe
> > > >> >> it's not being issued otherwise for some reason?
> > > >> >> 
> > > >> >> > What does that error message means? It is critical? What is
> > > >> >> > that command SET FEATURES doing? Are there any problems with
> > > >> >> > adma mode on nforce4 motherboards? Because I did not see any
> > > >> >> > problems (except that one error message).
> > > >> >> > 
> > > >> >> > --
> > > >> >> > Pali Rohár
> > > >> >> > pali.rohar@gmail.com
> > > >> > 
> > > >> > Hello,
> > > >> > 
> > > >> > now after long time I did more investigation and that error is
> > > >> > reported for every connected HDD. I identified that it comes
> > > >> > from udev script
> > > >> > 
> > > >> >  /lib/udev/rules.d/85-hdparm.rules
> > > >> > 
> > > >> > which just call script /lib/udev/hdparm for every one connected
> > > >> > HDD.
> > > >> > 
> > > >> > Script /lib/udev/hdparm just call:
> > > >> >  /sbin/hdparm -B254 $DRIVE
> > > >> > 
> > > >> > And that -B254 cause above error message in dmesg log. Output
> > > >> > from
> > > >> > 
> > > >> > hdparm is:
> > > >> >  /dev/sda:
> > > >> >   setting Advanced Power Management level to 0xfe (254)
> > > >> >   APM_level      = not supported
> > > >> > 
> > > >> > Any idea why in ADMA mode it cause above error (APM unsupported)
> > > >> > and in non ADMA mode it is working fine? Maybe APM ATA commands
> > > >> > should not be sent via ADMA?
> > > >> > 
> > > >> > Here is another output:
> > > >> >  $ sudo hdparm -I /dev/sda | grep -i power
> > > >> >  
> > > >> >             *    Power Management feature set
> > > >> >             
> > > >> >                  Power-Up In Standby feature set
> > > >> >             
> > > >> >             *    SET_FEATURES required to spinup after power up
> > > >> >             *    Host-initiated interface power management
> > > >> 
> > > >> The "set features" command is a non-data command so based on our
> > > >> current knowledge, it should work in ADMA mode. However, these
> > > >> NVIDIA SATAs are black boxes, and rather buggy ones at that, so
> > > >> it's possible there's an unknown issue there.
> > > > 
> > > > Maybe I should note that hdparm -I did not generated any error
> > > > message. I post is here because it show "Power Management feature
> > > > set" is supported by HDD. This indicate that HDD supports -B (APM)
> > > > command, right?
> > > 
> > > As far as I know, yes.
> > > 
> > > >> The easiest way to test that would be to take out the condition
> > > >> check for qc->tf.protocol == ATA_PROT_NODATA in
> > > >> nv_adma_use_reg_mode in drivers/ata/sata_nv.c. That would force
> > > >> it to disable ADMA for all non-data commands.
> > > > 
> > > > Ok, as now I have just SSH access to that machine, I will do kernel
> > > > patching later (when I have physical access to it).
> > > > 
> > > >> I really don't know why Ubuntu is disabling APM on all drives on
> > > >> bootup however. Especially for laptops, that seems like a silly
> > > >> thing to do explicitly. Sounds like one of the silly things
> > > >> Ubuntu is known to do without consulting people.
> > > > 
> > > > Looks like this comes from upstream udev/systemd project :-(
> > > > Anyway, for laptops on battery ubuntu has another set of scripts
> > > > which turn on APM (based on connected/disconnected AC adapter).
> > > 
> > > There's no such scripts in Fedora, so either they removed it, or it's
> > > something that either Debian or Ubuntu has added in.
> > > 
> > > > That udev script which turn off APM is called when any disk is
> > > > attached to system (so at boot time it is called for every one
> > > > disk).
> > > > 
> > > > Now I just masked that udev script and it is no longer called...
> > > > 
> > > > Anyway if I call hdparm -B /dev/sda I get output:
> > > > 
> > > > APM_level      = not supported
> > > > 
> > > > And important is that there is no error message in dmesg. I get it
> > > > only if I call hdparm -B with parameter (set option). But APM
> > > > should be supported, right?
> > > 
> > > Does the get command work without ADMA enabled?
> > 
> > I requested to boot that machine with turned off ADMA. I verified it is 
> > turned off as I found sata_nv.adma=0 in /proc/cmdline and file 
> > /sys/module/sata_nv/parameters/adma contains big N.
> > 
> > I called hdparm:
> > 
> > $ sudo hdparm -B254 /dev/sda
> > 
> > /dev/sda:
> >  setting Advanced Power Management level to 0xfe (254)
> >  HDIO_DRIVE_CMD failed: Input/output error
> >  APM_level      = not supported
> > 
> > It failed, but I do not see any error message in dmesg. There is nothing 
> > new in dmesg.
> > 
> > So looks like I'm not able to set APM... But why in ADMA mode it 
> > generates some error and in non ADMA mode no error? Strange!
> > 
> 
> Hi Robert!
> 
> After long time I tested it again. I have there two SATA disks connected
> to that computer. Running hdparm -B (without number) just print "not
> supported" and hdparm -B254 still cause above kernel dmesg error.
> 
> But second disk print via hdparm -B current APM level and via -B<num> I
> can set a new APM level. And it does not print any error (nor in dmesg
> or on stdout).
> 
> Therefore first disk probably does not support APM and above kernel
> dmesg error is caused only when I'm trying to set APM level on disk
> without APM support.
> 
> So... is not this problem in kernel libata or sata_nv modules which
> parses error messages for unsupported operations?

Tejun, you are libata maintainer, can you look or check if this is a
problem in kernel's libata? I guess that this is problem in propagating
APM errors. At least disk without APM support should not cause such
errors...

-- 
Pali Rohár
pali.rohar@gmail.com
