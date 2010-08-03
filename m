From: Tomas Lund <tlund@nxs.se>
Subject: Re: sata_sil24 failed command: READ FPDMA QUEUED (resolved)
Date: Tue, 3 Aug 2010 07:33:44 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.1008030732251.24693@envy.nxs.se>
References: <Pine.LNX.4.61.1007132245000.24693@envy.nxs.se> <4C3D134B.2090604@gmail.com>
 <Pine.LNX.4.61.1007140955080.24693@envy.nxs.se> <Pine.LNX.4.61.1007152103081.24693@envy.nxs.se>
 <Pine.LNX.4.61.1007171422530.24693@envy.nxs.se> <Pine.LNX.4.61.1007211404480.24693@envy.nxs.se>
 <Pine.LNX.4.61.1007211433360.24693@envy.nxs.se> <4C531A40.6080804@gmail.com>
 <Pine.LNX.4.61.1008011625490.24693@envy.nxs.se>
 <AANLkTikCqugAgM7zd=8H-hchN8b8tmZsP=NHgf+mNvc0@mail.gmail.com>
 <Pine.LNX.4.61.1008020720250.24693@envy.nxs.se>
 <AANLkTi=YDuEYt4BK4T4bJH3cY5GujC-tCV4D-ORcbDVT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from envy.nxs.se ([212.247.200.182]:52191 "EHLO envy.nxs.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755173Ab0HCFdp (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 3 Aug 2010 01:33:45 -0400
In-Reply-To: <AANLkTi=YDuEYt4BK4T4bJH3cY5GujC-tCV4D-ORcbDVT@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-ide@vger.kernel.org

On Mon, 2 Aug 2010, Robert Hancock wrote:

> On Mon, Aug 2, 2010 at 1:21 AM, Tomas Lund <tlund@nxs.se> wrote:
>
>> I have unlocked and tested a total of 4 disks now, both the samsung 1TB 
>> and 3 of the WDC 2TB disks. Thank you very much! Left to do: test that 
>> everything is working with the PMP aswell.
>
> Good to hear.

I now have all of my drives up and working, running on the PMP and 
everything is looking perfectly. Thanks again for your help.

>> Question: Would it be unreasonable to request that the kernel would 
>> issue the apropriate ATA-commands to a disk as soon as it is detected, 
>> and not try to read from it if it is locked? It would have been really, 
>> really nice to just get the error message "drive is locked".
>
> It should be possible to indicate that, yes. I'll look into it when I 
> get a chance, if someone doesn't beat me to it..

Perfect!

//tlund
