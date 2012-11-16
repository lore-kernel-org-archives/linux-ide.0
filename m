From: "Huang, Shane" <Shane.Huang@amd.com>
Subject: RE: ata4.00: failed to get Identify Device Data, Emask 0x1
Date: Fri, 16 Nov 2012 16:02:45 +0000
Message-ID: <43EB3AB3EEFE8D43B525F4D2EAF507E107EF3D53@SCYBEXDAG04.amd.com>
References: <20121016144932.GA24044@aftab.osrc.amd.com>
 <20121016155824.00d5b618@pyramind.ukuu.org.uk>
 <20121016151830.GB24044@aftab.osrc.amd.com> <507E0C1A.1010705@intel.com>
 <507E392E.2010305@gmail.com> <507E5671.6070504@intel.com>
 <43EB3AB3EEFE8D43B525F4D2EAF507E107EA8AA9@SCYBEXDAG03.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:57792
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752550Ab2KPQDI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 16 Nov 2012 11:03:08 -0500
In-Reply-To: <43EB3AB3EEFE8D43B525F4D2EAF507E107EA8AA9@SCYBEXDAG03.amd.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>, Robert Hancock <hancockrwd@gmail.com>, Jeff Garzik <jgarzik@pobox.com>
Cc: Borislav Petkov <bp@amd64.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Huang, Shane" <Shane.Huang@amd.com>

> I tried word 78 bit 5(Hardware Feature Control) which does not work,
> it is 0 on my HDD sample with log 30h page 08h and DevSlp supported.
> 
> Seems that word 78 bit 5 is only the sufficient condition, not the
> essential condition. Do you guys have suggestion?

Eventually I received the confirmation from the DevSlp HDD vendor,
bit 5 should be and will be set in production drives with log 30h
page 08h supported. So I will submit a patch to use it instead.


Hi Jeff,

I don't know when I will receive some production drives to verify
my patch, are you okay if I submit my patch first without testing
so as to meet kernel 3.7 bug fix window?

Thanks,
Shane

