From: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: sata_promise: port is slow to respond, reset failed
Date: Sun, 2 Sep 2007 19:02:14 +0200 (MEST)
Message-ID: <200709021702.l82H2Ef5022024@harpo.it.uu.se>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from aun.it.uu.se ([130.238.12.36]:63652 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751478AbXIBRCU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 2 Sep 2007 13:02:20 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@how.dk, linux-ide@vger.kernel.org, mikpe@it.uu.se

On Sun, 2 Sep 2007 17:11:36 +0200 (MEST), Mikael Pettersson wrote:
> On Sun, 02 Sep 2007 13:12:42 +0200, Peter Favrholdt wrote:
> > I'm still experiencing the same "port is slow to respond" problem using 
> > sata_promise in linux-2.6.22.6 with my Promise Technology, Inc. PDC40718 
> > (SATA 300 TX4) (rev 02) and 4 Seagate 500GB ES drives:
> >          Model Number:       ST3500630NS
> >          Firmware Revision:  3.AEE
> >          (with 1.5/3.0Gbps jumper removed = 3.0Gbps)
> > 
> > After doing:
> > 
> > dd if=/dev/sda of=/dev/null bs=1M &
> > dd if=/dev/sdb of=/dev/null bs=1M &
> > dd if=/dev/sdc of=/dev/null bs=1M &
> > dd if=/dev/sdd of=/dev/null bs=1M &
> > 
> > it runs fine for a while, then:
> > 
> > [  810.545909] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x1380000 
> > action 0x2 frozen
> > [  810.545923] ata1.00: cmd c8/00:00:00:33:e6/00:00:00:00:00/e1 tag 0 
> > cdb 0x0 data 131072 in
> > [  810.545926]          res 40/00:28:00:00:00/00:00:00:00:00/40 Emask 
> > 0x4 (timeout)
> > [  815.913113] ata1: port is slow to respond, please be patient (Status 
> > 0xff)
> > [  820.590706] ata1: device not ready (errno=-16), forcing hardreset
> > [  820.590716] ata1: hard resetting port
> > [  826.137780] ata1: port is slow to respond, please be patient (Status 
> > 0xff)
> > [  830.635488] ata1: COMRESET failed (errno=-16)
> > [  830.635497] ata1: hard resetting port
> > [  836.182563] ata1: port is slow to respond, please be patient (Status 
> > 0xff)
> > [  840.680236] ata1: COMRESET failed (errno=-16)
> > [  840.680245] ata1: hard resetting port
> > [  846.227361] ata1: port is slow to respond, please be patient (Status 
> > 0xff)
> > [  875.672028] ata1: COMRESET failed (errno=-16)
> > [  875.672037] ata1: limiting SATA link speed to 1.5 Gbps
> > [  875.672041] ata1: hard resetting port
> > [  880.679454] ata1: COMRESET failed (errno=-16)
> > [  880.679463] ata1: reset failed, giving up
> > [  880.679466] ata1.00: disabled
> > [  880.679480] ata1: EH complete
> > [  880.679545] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
> > [  880.679550] end_request: I/O error, dev sda, sector 31863552
> > [  880.679555] Buffer I/O error on device sda, logical block 3982944
> > [  880.679561] Buffer I/O error on device sda, logical block 3982945
> > [  880.679565] Buffer I/O error on device sda, logical block 3982946
> > [  880.679569] Buffer I/O error on device sda, logical block 3982947
> > [  880.679573] Buffer I/O error on device sda, logical block 3982948
> > [  880.679578] Buffer I/O error on device sda, logical block 3982949
> > [  880.679582] Buffer I/O error on device sda, logical block 3982950
> > [  880.679586] Buffer I/O error on device sda, logical block 3982951
> > [  880.679590] Buffer I/O error on device sda, logical block 3982952
> > [  880.679594] Buffer I/O error on device sda, logical block 3982953
> > [  880.680296] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
> > [  880.680301] end_request: I/O error, dev sda, sector 31863808
> > [  880.680877] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
> > [  880.680882] end_request: I/O error, dev sda, sector 31863552
> > [  880.681383] sd 0:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
> > [  880.681388] end_request: I/O error, dev sda, sector 31863552
> > 
> > The "funny" thing is that it runs fine using linux-2.6.21-rc2 with 
> > Mikael Pettersson's "1.5Gbps only" patch.
> 
> Hmm, obviously a fatal problem, but not one I've seen before or
> have an explanation for at this time. We do know however that the
> SATA300 chips are prone to have "issues" especially in 3Gbps mode.
> 
> A couple of things you can do:
> 1. Provide a complete dmesg.
> 2. Force 1.5Gbps mode, using either jumpers or the driver patch (there's
>    one for 2.6.22 in http://user.it.uu.se/~mikpe/linux/patches/2.6/).
> 3. Try to narrow down where the problem started, i.e., test 2.6.21 final
>    and the 2.6.22-rc kernels.

I'm easily able to reproduce this problem on my sata_promise test rig.
Using 2.6.23-rc5 to dd read a single Seagate disk on a SATA300 TX4 card
quickly fails as Peter described.

Applying the 1.5Gbps patch to the driver appears to make things stable.

Those SATAII chips really don't seem to like 3Gbps mode. Or else we're
missing some critical documentation on how to make them work.

/Mikael
