From: Tejun Heo <htejun@gmail.com>
Subject: Re: [git patches] libata fixes
Date: Mon, 05 Mar 2007 14:13:10 +0900
Message-ID: <45EBA6E6.10907@gmail.com>
References: <00e201c75dc3$4da9d490$2101a8c0@donald>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.234]:55107 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752682AbXCEFNP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Mar 2007 00:13:15 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1650045nze
        for <linux-ide@vger.kernel.org>; Sun, 04 Mar 2007 21:13:15 -0800 (PST)
In-Reply-To: <00e201c75dc3$4da9d490$2101a8c0@donald>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: rol@as2917.net
Cc: 'Jeff Garzik' <jeff@garzik.org>, 'Andrew Morton' <akpm@linux-foundation.org>, 'Linus Torvalds' <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, 'LKML' <linux-kernel@vger.kernel.org>, "Eric D. Mudama" <edmudama@gmail.com>

[cc'ing Eric D. Mudama. Hi!]

Paul Rolland wrote:
> ata1.00: exception Emask 0x2 SAct 0xffe0 SErr 0x0 action 0x2 frozen
> ata1.00: (spurious completions during NCQ issue=0x0 SAct=0xffe0
> FIS=004040a1:00000010)
> ata1.00: cmd 60/02:28:52:ec:c4/00:00:0e:00:00/40 tag 5 cdb 0x0 data 1024 in
>          res 40/00:78:66:ec:c4/00:00:0e:00:00/40 Emask 0x2 (HSM violation)
> ata1.00: cmd 60/02:30:54:ec:c4/00:00:0e:00:00/40 tag 6 cdb 0x0 data 1024 in
>          res 40/00:78:66:ec:c4/00:00:0e:00:00/40 Emask 0x2 (HSM violation)
> ata1.00: cmd 60/02:38:56:ec:c4/00:00:0e:00:00/40 tag 7 cdb 0x0 data 1024 in
>          res 40/00:78:66:ec:c4/00:00:0e:00:00/40 Emask 0x2 (HSM violation)
> ata1.00: cmd 60/02:40:58:ec:c4/00:00:0e:00:00/40 tag 8 cdb 0x0 data 1024 in
>          res 40/00:78:66:ec:c4/00:00:0e:00:00/40 Emask 0x2 (HSM violation)
> ata1.00: cmd 60/02:48:5a:ec:c4/00:00:0e:00:00/40 tag 9 cdb 0x0 data 1024 in
>          res 40/00:78:66:ec:c4/00:00:0e:00:00/40 Emask 0x2 (HSM violation)
> ata1.00: cmd 60/02:50:5c:ec:c4/00:00:0e:00:00/40 tag 10 cdb 0x0 data 1024 in
>          res 40/00:78:66:ec:c4/00:00:0e:00:00/40 Emask 0x2 (HSM violation)
> ata1.00: cmd 60/02:58:5e:ec:c4/00:00:0e:00:00/40 tag 11 cdb 0x0 data 1024 in
>          res 40/00:78:66:ec:c4/00:00:0e:00:00/40 Emask 0x2 (HSM violation)
> ata1.00: cmd 60/02:60:60:ec:c4/00:00:0e:00:00/40 tag 12 cdb 0x0 data 1024 in
>          res 40/00:78:66:ec:c4/00:00:0e:00:00/40 Emask 0x2 (HSM violation)
> ata1.00: cmd 60/02:68:62:ec:c4/00:00:0e:00:00/40 tag 13 cdb 0x0 data 1024 in
>          res 40/00:78:66:ec:c4/00:00:0e:00:00/40 Emask 0x2 (HSM violation)
> ata1.00: cmd 60/02:70:64:ec:c4/00:00:0e:00:00/40 tag 14 cdb 0x0 data 1024 in
>          res 40/00:78:66:ec:c4/00:00:0e:00:00/40 Emask 0x2 (HSM violation)
> ata1.00: cmd 60/02:78:66:ec:c4/00:00:0e:00:00/40 tag 15 cdb 0x0 data 1024 in
>          res 40/00:78:66:ec:c4/00:00:0e:00:00/40 Emask 0x2 (HSM violation)
> ata1: soft resetting port
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata1.00: configured for UDMA/133
> ata1: EH complete
> SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
> sda: Write Protect is off
> sda: Mode Sense: 00 3a 00 00
> SCSI device sda: write cache: enabled, read cache: enabled, doesn't support
> DPO or FUA
>
> This last part was not present when booting stock 2.6.21-rc1

Your drive has some issues with NCQ and is scheduled to be blacklisted
such that it isn't enabled.  libata used to ignore the condition but now
considers it NCQ protocol violation and fails all pending commands.

libata EH should turn NCQ off automatically after a few of the above
errors.  I'd love to see how that actually works in the field (full
dmesg please).  If it doesn't, it needs fixing.

Thanks.

-- 
tejun
