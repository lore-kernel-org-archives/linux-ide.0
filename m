From: MisterE <MisterE2002@zonnet.nl>
Subject: Re[2]: Sata Sil3512 bug?
Date: Fri, 28 Sep 2007 17:25:36 +0200
Message-ID: <1619914792.20070928172536@zonnet.nl>
References: <1097480701.20070927155135@zonnet.nl> <46FCF2A1.30204@gmail.com>
Reply-To: MisterE <MisterE2002@zonnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.publishnet.nl ([212.241.49.8]:4933 "EHLO smtp.pn.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752045AbXI1PW0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 28 Sep 2007 11:22:26 -0400
Received: from localhost ([84.246.52.165])
	by smtp.pn.nl (smtp.pn.nl [212.241.49.8])
	(MDaemon.PRO.v8.1.3.R)
	with ESMTP id 32-md50000100560.msg
	for <linux-ide@vger.kernel.org>; Fri, 28 Sep 2007 17:22:19 +0200
In-Reply-To: <46FCF2A1.30204@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, benh@kernel.crashing.org

Hello Tejun,

I've tried with 2 sata cables. Cables which don't give problems with
the Asus motherboard.
I also now use a new decent power supply (corsair vx450) for the
intel. Before it, i used an Fortron supply. But it had no sata
connectors so i used converter adapters. But replacing the supply
did'nt solve it.

btw. If i copy/delete from the Western Digital to my Windows pc (via winscp
or samba) i don't get error messages. Only when i write to it.
The data itself seems to get corrupted; tested with par2. uploaded
with winscp (windows) to the western digital (sda1). Uploaded the same data
to hda1. Tested the data on both drives with par2verify. Most files on
sda1 are corrupted (2 to 4 blocks missing). Copying that data back to
Windows and it give the same results in Quickpar. So reading does not
have problems. The data written to hda1 is correct.


I now inserted a videocard, instead of using the onboard card. And at
first hand it looked solved, but some (much less) errors still happens.
I did not change anything in the bios. The card:
02:00.0 VGA compatible controller: nVidia Corporation NV10 [GeForce 256 SDR] (rev 10)
How can a videocard influence this?

I wanted to build a fileserver, using the intel motherboard. Bacause
of the fact that it has a onboard videocard. I can use the asus if i
have to. But if it is a bug it can better be solved :)

I have some other similar motherboards like the intel laying around.
With and without onboard videocard. I also have a second D815EEA
(probably still has an older BIOS, i have updated the current one because
when i inserted my second 128MB memory it did not gave any picture on
the onboard video card). So i can do some experiments if i have to.

Hope, this helps...

Friday, September 28, 2007, 2:25:05 PM, you wrote:

> Hello,

> MisterE wrote:
>> I've tried the controller in another motherboard, the ASUS CUSL2 (with similar specs)
>> and i don't have any problems. Can you help? I've included some logs
>> with may be of use.

> Did you use the same cable on both machines?  Also, does the problem go
> away if you power the hard drive from the power supply of the other machine?




-- 
Best regards,
 MisterE                            mailto:MisterE2002@zonnet.nl


