From: "Rodrigo Severo" <rodrigo@fabricadeideias.com>
Subject: Re: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen on SATA hd
Date: Mon, 16 Apr 2007 13:14:31 -0300
Message-ID: <a7108f870704160914g22b648bey39a9523a6d8a4800@mail.gmail.com>
References: <a7108f870704150703p1f0da000k22f7b70605cec595@mail.gmail.com>
	 <a7108f870704150708g741b7e2fmd52be8b53b358113@mail.gmail.com>
	 <a7108f870704160745l4296fe8bt74e94d6c5bf8504e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.238]:3578 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030811AbXDPQOd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Apr 2007 12:14:33 -0400
Received: by nz-out-0506.google.com with SMTP id s1so1249539nze
        for <linux-ide@vger.kernel.org>; Mon, 16 Apr 2007 09:14:32 -0700 (PDT)
In-Reply-To: <a7108f870704160745l4296fe8bt74e94d6c5bf8504e@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On 4/16/07, Rodrigo Severo <rodrigo@fabricadeideias.com> wrote:
> On 4/15/07, Rodrigo Severo <rodrigo@fabricadeideias.com> wrote:
> >
> > I have this cheap SATA addon card with an ULI chipset.
> >
> > A have a linear raid over 3 disks one PATA, hda and two SATAs, sda and sdb.
> >
> > When copying data to the raid device I get log messages like the following:
> >
> > Apr 15 10:54:20 [kernel] ata1.00: exception Emask 0x0 SAct 0x0 SErr
> > 0x0 action 0x2 frozen
> > Apr 15 10:54:20 [kernel] ata1.00: cmd
> > 35/00:00:df:90:0e/00:04:0b:00:00/e0 tag 0 cdb 0x0 data 524288 out
> > Apr 15 10:54:20 [kernel]          res
> > 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> > Apr 15 10:54:27 [kernel] ata1: port is slow to respond, please be
> > patient (Status 0xd0)
> > Apr 15 10:54:48 [kernel] ata1: port failed to respond (30 secs, Status 0xd0)
> > Apr 15 10:54:48 [kernel] ata1: soft resetting port
> > Apr 15 10:54:48 [kernel] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> > Apr 15 10:54:48 [kernel] ATA: abnormal status 0xD0 on port 0x9007
> >                 - Last output repeated 6 times -
> > Apr 15 10:54:48 [kernel] ata1.00: configured for UDMA/133
> > Apr 15 10:54:48 [kernel] ata1: EH complete
> > Apr 15 10:54:48 [kernel] SCSI device sda: 488397168 512-byte hdwr
> > sectors (250059 MB)
> > Apr 15 10:54:48 [kernel] sda: Write Protect is off
> > Apr 15 10:54:48 [kernel] SCSI device sda: write cache: enabled, read
> > cache: enabled, doesn't support DPO or FUA
> >
> > All references I found to this kind of message where related to some
> > driver issue and not hardware problems. Can this be the case?
>
> In search for a solution for this issue I bought a new HD to replace
> the one presenting the problem above.
>
> Now I have a SAMSUNG HD400LJ in place of the previous ST3250820AS. The
> problem remains the same.
>
> When I put a Maxtor 6L300S0 to perform the same hole as the Samsung or
> the Seagate, I couldn't trigger the exception. I bet this happened
> because Maxtor is immune to this issue and the Samsung (which seems to
> be affected) was barely used.

Now with kernel 2.6.21-rc6, addon board reattached and cables changed
I still get messages like the following every 10 minutes or so under
high load:

Apr 16 13:03:27 [kernel] ata1.00: exception Emask 0x0 SAct 0x0 SErr
0x0 action 0x2 frozen
Apr 16 13:03:27 [kernel] ata1.00: cmd
35/00:00:91:fd:06/00:04:0b:00:00/e0 tag 0 cdb 0x0 data 524288 out
Apr 16 13:03:27 [kernel]          res
40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
Apr 16 13:03:35 [kernel] ata1: port is slow to respond, please be
patient (Status 0xd0)
Apr 16 13:03:58 [kernel] ata1: port failed to respond (30 secs, Status 0xd0)
Apr 16 13:03:58 [kernel] ata1: soft resetting port
Apr 16 13:03:58 [kernel] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
Apr 16 13:03:58 [kernel] ata1.00: configured for UDMA/133
Apr 16 13:03:58 [kernel] ata1: EH complete
Apr 16 13:03:58 [kernel] SCSI device sda: 781422768 512-byte hdwr
sectors (400088 MB)
Apr 16 13:03:58 [kernel] sda: Write Protect is off
Apr 16 13:03:58 [kernel] SCSI device sda: write cache: enabled, read
cache: enabled, doesn't support DPO or FUA

Is this expected behavior?


Rodrigo Severo
