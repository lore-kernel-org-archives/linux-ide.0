From: Marc MERLIN <marc@merlins.org>
Subject: Re: sil24 PMP works with ST3500641AS but not HDS721010KLA330
Date: Tue, 2 Oct 2007 19:32:13 -0700
Message-ID: <20071003023213.GB19430@merlins.org>
References: <20071002170445.GB2902@merlins.org> <20071003022857.GA19430@merlins.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from magic.merlins.org ([209.81.13.136]:41989 "EHLO
	mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753433AbXJCCcQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Oct 2007 22:32:16 -0400
Content-Disposition: inline
In-Reply-To: <20071003022857.GA19430@merlins.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com, linux-ide@vger.kernel.org

On Tue, Oct 02, 2007 at 07:28:57PM -0700, Marc MERLIN wrote:
> On Tue, Oct 02, 2007 at 10:04:45AM -0700, Marc MERLIN wrote:
> > Howdy,
> > 
> > I've had a system with 2.6.22.1 for a while, running 10 drives
> > behind a PMP on a sil24 card with no problems.
> > 
> > Recently, I swapped 5 250GB drives with 5 TB drives.
> > The 5 TB drives eventually get detected, but do not work reliably.
> > 
> > Details are below.
> > 
> > This is all on 2.6.22.1-libata-tj-20070803. 
> > I noticed that 20070808 is out, but it says it fixed NCQ over PMP,
> > and NCQ was working fine with my 500GB drives, so I'm not sure it's that.
> 
> I tried with 20070808. Boot was better, so it seems to have helped.
> I guess the NCQ fix was relevant for my TB drives but not needed for the 500GB ones.
> 
> I still got this when the array was built, but it didn't seem to prevent it from
> being built and from working:

Grr, never mind. Right as I sent this, the array died when I mke2fs'ed it.

Any other suggestions?

ata3.00: exception Emask 0x100 SAct 0x610 SErr 0x0 action 0x6 frozen
ata3.00: cmd 60/18:20:4f:00:48/00:00:02:00:00/40 tag 4 cdb 0x0 data 12288 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3.00: cmd 60/10:48:67:00:48/00:00:02:00:00/40 tag 9 cdb 0x0 data 8192 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3.00: cmd 60/28:50:77:00:48/00:00:02:00:00/40 tag 10 cdb 0x0 data 20480 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3.01: exception Emask 0x100 SAct 0x10000 SErr 0x0 action 0x6 frozen
ata3.01: cmd 60/50:80:4f:00:48/00:00:02:00:00/40 tag 16 cdb 0x0 data 40960 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3.02: exception Emask 0x100 SAct 0x20000 SErr 0x0 action 0x6 frozen
ata3.02: cmd 60/50:88:4f:00:48/00:00:02:00:00/40 tag 17 cdb 0x0 data 40960 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3.03: exception Emask 0x100 SAct 0x8020 SErr 0x0 action 0x6 frozen
ata3.03: cmd 60/50:28:4f:00:48/00:00:02:00:00/40 tag 5 cdb 0x0 data 40960 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3.03: cmd 60/10:78:3f:08:47/00:00:02:00:00/40 tag 15 cdb 0x0 data 8192 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3.04: exception Emask 0x100 SAct 0x7fc48cf SErr 0x0 action 0x6 frozen
ata3.04: cmd 61/38:00:e7:01:48/00:00:02:00:00/40 tag 0 cdb 0x0 data 28672 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3.04: cmd 61/70:08:cf:06:47/00:00:02:00:00/40 tag 1 cdb 0x0 data 57344 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3.04: cmd 61/18:10:bf:01:48/00:00:02:00:00/40 tag 2 cdb 0x0 data 12288 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3.04: cmd 61/10:18:d7:01:48/00:00:02:00:00/40 tag 3 cdb 0x0 data 8192 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3.04: cmd 61/20:30:1f:02:48/00:00:02:00:00/40 tag 6 cdb 0x0 data 16384 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3.04: cmd 61/10:38:3f:02:48/00:00:02:00:00/40 tag 7 cdb 0x0 data 8192 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3.04: cmd 61/40:58:7f:03:47/00:00:02:00:00/40 tag 11 cdb 0x0 data 32768 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3.04: cmd 61/60:70:d7:03:47/00:00:02:00:00/40 tag 14 cdb 0x0 data 49152 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3.04: cmd 61/58:90:3f:04:47/00:00:02:00:00/40 tag 18 cdb 0x0 data 45056 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3.04: cmd 61/08:98:ff:05:47/00:00:02:00:00/40 tag 19 cdb 0x0 data 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3.04: cmd 61/08:a0:5f:06:47/00:00:02:00:00/40 tag 20 cdb 0x0 data 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3.04: cmd 61/10:a8:bf:06:47/00:00:02:00:00/40 tag 21 cdb 0x0 data 8192 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3.04: cmd 61/00:b0:3f:07:47/01:00:02:00:00/40 tag 22 cdb 0x0 data 131072 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3.04: cmd 61/a8:b8:9f:00:48/00:00:02:00:00/40 tag 23 cdb 0x0 data 86016 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3.04: cmd 61/18:c0:47:01:48/00:00:02:00:00/40 tag 24 cdb 0x0 data 12288 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3.04: cmd 61/20:c8:5f:01:48/00:00:02:00:00/40 tag 25 cdb 0x0 data 16384 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3.04: cmd 61/40:d0:7f:01:48/00:00:02:00:00/40 tag 26 cdb 0x0 data 32768 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata3.15: hard resetting link
ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata3.00: hard resetting link
ata3.00: softreset failed (timeout)
ata3.00: hard resetting link
ata3.00: COMRESET failed (errno=-5)
ata3.00: reset failed, giving up
ata3.15: hard resetting link
ata3.15: softreset failed (timeout)
ata3.15: hard resetting link
ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata3.00: hard resetting link
ata3.00: softreset failed (timeout)
ata3.00: hard resetting link
ata3.00: COMRESET failed (errno=-5)
ata3.00: reset failed, giving up
ata3.15: hard resetting link
ata3.15: softreset failed (timeout)
ata3.15: hard resetting link
ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata3.00: hard resetting link
ata3.00: softreset failed (timeout)
ata3.00: hard resetting link
ata3.00: COMRESET failed (errno=-5)
ata3.00: reset failed, giving up
ata3.00: failed to recover link after 3 tries, disabling
ata3.00: disabled
ata3: failed to recover PMP, retrying in 5 secs

ata3.03: failed to recover link after 3 tries, disabling
ata3.03: disabled
ata3: failed to recover PMP, retrying in 5 secs
ata3.15: hard resetting link
ata3.15: softreset failed (timeout)
ata3.15: hard resetting link
ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata3.04: hard resetting link
ata3.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata3.05: hard resetting link
ata3.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.04: configured for UDMA/100
sd 3:0:0:0: [sdc] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
sd 3:0:0:0: [sdc] Sense Key : Aborted Command [current] [descriptor]
Descriptor sense data with sense descriptors (in hex):
        72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
        00 00 00 00 
sd 3:0:0:0: [sdc] Add. Sense: No additional sense information
end_request: I/O error, dev sdc, sector 38273103
sd 3:3:0:0: [sdf] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
sd 3:3:0:0: [sdf] Sense Key : Aborted Command [current] [descriptor]
Descriptor sense data with sense descriptors (in hex):
        72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
        00 00 00 00 
sd 3:3:0:0: [sdf] Add. Sense: No additional sense information
end_request: I/O error, dev sdf, sector 38273103
sd 3:0:0:0: [sdc] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
sd 3:0:0:0: [sdc] Sense Key : Aborted Command [current] [descriptor]
Descriptor sense data with sense descriptors (in hex):
        72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
        00 00 00 00 
sd 3:0:0:0: [sdc] Add. Sense: No additional sense information
end_request: I/O error, dev sdc, sector 38273127
sd 3:0:0:0: [sdc] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
sd 3:0:0:0: [sdc] Sense Key : Aborted Command [current] [descriptor]
Descriptor sense data with sense descriptors (in hex):
        72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
        00 00 00 00 
sd 3:0:0:0: [sdc] Add. Sense: No additional sense information
end_request: I/O error, dev sdc, sector 38273143
sd 3:0:0:0: rejecting I/O to offline device
raid5: Disk failure on sdc1, disabling device. Operation continuing on 4 devices
sd 3:3:0:0: rejecting I/O to offline device
sd 3:0:0:0: rejecting I/O to offline device
raid5: Disk failure on sdf1, disabling device. Operation continuing on 3 devices
sd 3:3:0:0: rejecting I/O to offline device
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems & security ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/  
