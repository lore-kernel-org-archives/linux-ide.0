From: Matthew Kent <mkent@magoazul.com>
Subject: Re: [Qemu-devel] fedora 7, cdrom and
	GPCMD_GET_EVENT_STATUS_NOTIFICATION
Date: Mon, 30 Jul 2007 11:43:22 -0700
Message-ID: <1185821002.6486.238.camel@fuego>
References: <1185574745.6486.166.camel@fuego>
	 <46AD7557.3020608@filteredperception.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zero.voxel.net ([69.9.191.6]:49677 "EHLO zero.voxel.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967925AbXG3THR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 30 Jul 2007 15:07:17 -0400
In-Reply-To: <46AD7557.3020608@filteredperception.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: qemu-devel@nongnu.org
Cc: linux-ide@vger.kernel.org

[cc'ing the linux-ide list if they have any suggestions as to possible
causes, original post
http://marc.info/?l=qemu-devel&m=118557513905049&w=2 ]

On Mon, 2007-30-07 at 00:21 -0500, dmc wrote:
> Matthew Kent wrote:
> > Been digging around for a solution or confirmation of this for a while
> > now without much luck. Forgive me if there's a solution to this I'm just
> > not seeing.
> > 
> > Getting some ugly libata related errors in my guest like
> > 
> > ata2: DRQ=1 with device error, dev_stat 0x49
> > ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> > ata2.00: cmd a0/00:00:00:00:20/00:00:00:00:00/a0 tag 0 cdb 0x4a data 8
> > in
> >          res 41/50:03:00:00:20/00:00:00:00:00/a0 Emask 0x3 (HSM
> > violation)
> > ata2: soft resetting port
> > ata2.00: configured for MWDMA2
> > ata2: EH complete
> > 
> > when running a stock install of Fedora 7 (x86_64) in qemu (the stock
> > fedora package of qemu 0.9.0 or kvm-33). Tried upgrading to the latest
> > updated kernel 2.6.22.1-33.fc7, then the latest development one with no
> > change.
> > 
> > Tracked it down to hald-addon-storage which is polling the cdrom with
> > SG_IO and GPCMD_GET_EVENT_STATUS_NOTIFICATION which is trying to "check
> > if eject button was pressed". 
> > 
> > In my search I found a brief example program in this ticket
> > https://bugzilla.novell.com/show_bug.cgi?id=145147 which replicates the
> > issue reliably here without involving hal.
> > 
> > The workaround I found was to run
> > 
> > hal-disable-polling --device /dev/scd0
> > 
> > but given the lack of success I had finding other people reporting this
> > exact issue in libata proper, I'm guessing it might be something with
> > the cd-rom emulation of which fixing is way over my head :)
> > 
> > Guest dmesg and test case attached.
> > 
> > Anyone else seeing this?
> 
> 
> Yeah.  I mentioned it on fedora-devel@redhat.com.  I was forwarded to a link 
> which mentioned the workaround you mentioned, as well as prefixing it with a 
> 'killall hald-addon-storage'.
> 
> I also ran across this little patch, which I haven't bothered to try yet.
> 
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=431829
> 
> If you try it, let me know if it works.
> 
> -dmc

Came across the same one and tried it, no such luck unfortunately.
-- 
Matthew Kent <mkent@magoazul.com>
http://magoazul.com

