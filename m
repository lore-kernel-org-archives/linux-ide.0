From: "Huang, Shane" <Shane.Huang@amd.com>
Subject: RE: 65fe1f0 (ahci: implement aggressive SATA...) fail to boot
Date: Mon, 24 Dec 2012 08:10:16 +0000
Message-ID: <43EB3AB3EEFE8D43B525F4D2EAF507E107F3EE40@SCYBEXDAG04.amd.com>
References: <20121021175717.GA3543@bill-the-cat>
	<43EB3AB3EEFE8D43B525F4D2EAF507E107EAB746@SCYBEXDAG03.amd.com>
	<CA+M6bXmLcAh_1dQN_y9cu3C+umvsKNTX57nYfTm2ZL2SMvMvWw@mail.gmail.com>
 <CA+M6bXmMeY_M9GZ_9JRtMeT7T47SCcYchyz_-=C0RbnEGQCAjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:18900 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752884Ab2LXIK0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 24 Dec 2012 03:10:26 -0500
In-Reply-To: <CA+M6bXmMeY_M9GZ_9JRtMeT7T47SCcYchyz_-=C0RbnEGQCAjw@mail.gmail.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tom Rini <tom.rini@gmail.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Aaron Lu <aaron.lwe@gmail.com>, Jeff Garzik <jgarzik@redhat.com>, "Huang, Shane" <Shane.Huang@amd.com>

> > I beat my kernel config into enough submission so that I could
> > interact this early and it's the RevoDrive 3 X2 that's not showing all
> > drives and thus failing.  The dmesg is at
> > http://pastebin.com/ZcKK3Rb4
> 
> And to compare, 3.6.0  http://pastebin.com/HybBiQAE

Tom,

Sorry for my late response, I was busy with other urgent tasks.
Can you check whether my patch in BZ #51881 help or not?

https://bugzilla.kernel.org/show_bug.cgi?id=51881

Thanks,
Shane

