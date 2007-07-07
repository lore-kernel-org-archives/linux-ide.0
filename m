From: "Dan Merillat" <dan.merillat@gmail.com>
Subject: Re: sata_promise disk error 2.6.22-rc5 with hrt1 patch
Date: Sat, 7 Jul 2007 02:28:10 -0400
Message-ID: <a56dfcf00707062328v505bf738kb01e7560f3f3f6ee@mail.gmail.com>
References: <200706242130.l5OLUgY8004346@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755808AbXGGG2Y@vger.kernel.org>
In-Reply-To: <200706242130.l5OLUgY8004346@harpo.it.uu.se>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: gf435@gmx.net, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On 6/24/07, Mikael Pettersson <mikpe@it.uu.se> wrote:
> (cc: linux-ide added)
>
> The 300 TX4 model is causing transient errors for several people,
> and we don't yet know why. In your case, port_status 0x00001000
> means that "host bus is busy more than 256 clock cycles for every
> ATA I/O transfer" (quoting the docs). Basically it's a timeout.

I'm running vanilla 2.6.22-rc7 here, getting a similar error.

[  741.010863] ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
[  741.010869] ata2.00: (port_status 0x20080000)
[  741.010875] ata2.00: cmd c8/00:08:bf:01:0c/00:00:00:00:00/ef tag 0
cdb 0x0 data 4096 in
[  741.010877]          res 50/00:00:c6:01:0c/00:00:00:00:00/ef Emask
0x2 (HSM violation)
[  741.313131] ata2: soft resetting port
[  741.463831] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[  741.587208] ata2: EH complete
[  741.640472] sd 1:0:0:0: [sdb] 1465149168 512-byte hardware sectors
(750156 MB)
[  741.644141] sd 1:0:0:0: [sdb] Write Protect is off
[  741.644144] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[  741.670736] sd 1:0:0:0: [sdb] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA

Identical card to the one otto posted.    How common is this?  I
wouldn't notice if it wasn't logged - I don't notice the blip in disk
access.
