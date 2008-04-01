From: Tomas Lund <tlund@nxs.se>
Subject: Re: Need help understanding SATA error message.
Date: Tue, 1 Apr 2008 09:11:44 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0804010834280.5510@envy.nxs.se>
References: <Pine.LNX.4.61.0803271554050.5510@envy.nxs.se> <47ED136F.9010501@rtr.ca>
 <47ED15D2.3080403@rtr.ca> <Pine.LNX.4.61.0803282315330.5510@envy.nxs.se>
 <47EDBC87.8090109@rtr.ca> <Pine.LNX.4.61.0803301659300.5510@envy.nxs.se>
 <47F0376F.2090000@gmail.com> <47F0FAD3.9060001@rtr.ca> <47F18127.8070509@gmail.com>
 <47F19764.9080705@rtr.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from envy.nxs.se ([212.247.200.182]:49853 "EHLO envy.nxs.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751963AbYDAHL4 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 1 Apr 2008 03:11:56 -0400
In-Reply-To: <47F19764.9080705@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org

On Mon, 31 Mar 2008, Mark Lord wrote:

> Mmm.. the one Tomas Lund has is on what appears to be AHCI (ICH9R).

Yes, indeed:

# lspci -v -nn -s 00:1f.2
00:1f.2 SATA controller [0106]: Intel Corporation 82801IR/IO/IH (ICH9R/DO/DH) 6 port SATA AHCI Controller [8086:2922] (rev 02) (prog-if 01 [AHCI 1.0])
         Subsystem: Super Micro Computer Inc Unknown device [15d9:d180]
         Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 379
         I/O ports at 1c30 [size=8]
         I/O ports at 1c24 [size=4]
         I/O ports at 1c28 [size=8]
         I/O ports at 1c20 [size=4]
         I/O ports at 18e0 [size=32]
         Memory at d8601000 (32-bit, non-prefetchable) [size=2K]
         Capabilities: [80] Message Signalled Interrupts: Mask- 64bit- Queue=0/4 Enable+
         Capabilities: [70] Power Management version 3
         Capabilities: [a8] #12 [0010]
         Capabilities: [b0] #13 [0306]

(dmesg output available at http://tlund.pp.se/envy4_dmesg.txt)

> Tomas, if you move the "problem drive" to another port, does the error 
> follow the drive, or stay with the same port?
>
> (Hopefully you can try that)

Yes, the drive has already been moved, and the problem did indeed move 
with the drive. However, I am currently stressing the drives by copying 
large amounts of files, in paralel sessions, and issuing "sync" every 30 
seconds, and I have not seen the error since Mar 28 18:17 (current time 
here is Apr 1 09:10).

The system does not have any data on it yet, and I am not really in a 
hurry to get it into production. Willing to try anything to track this 
problem down.

//tlund
