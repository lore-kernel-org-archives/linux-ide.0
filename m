From: "Huang, Shane" <Shane.Huang@amd.com>
Subject: RE: ata4.00: failed to get Identify Device Data, Emask 0x1
Date: Thu, 18 Oct 2012 09:11:05 +0000
Message-ID: <43EB3AB3EEFE8D43B525F4D2EAF507E107EA8AA9@SCYBEXDAG03.amd.com>
References: <20121016144932.GA24044@aftab.osrc.amd.com>
 <20121016155824.00d5b618@pyramind.ukuu.org.uk>
 <20121016151830.GB24044@aftab.osrc.amd.com> <507E0C1A.1010705@intel.com>
 <507E392E.2010305@gmail.com> <507E5671.6070504@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from db3ehsobe003.messaging.microsoft.com ([213.199.154.141]:10492
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751981Ab2JRJLY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 18 Oct 2012 05:11:24 -0400
In-Reply-To: <507E5671.6070504@intel.com>
Content-Language: en-US
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>, Robert Hancock <hancockrwd@gmail.com>
Cc: Borislav Petkov <bp@amd64.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "Huang, Shane" <Shane.Huang@amd.com>

> Agree. If NCQ does not imply support of this log page, we should
> definitely refine the check condition used here.
> 
> I suppose Shane will take care of this, but if he doesn't, I'll do that
> at a later time.

I tried word 78 bit 5(Hardware Feature Control) which does not work,
it is 0 on my HDD sample with log 30h page 08h and DevSlp supported.

Seems that word 78 bit 5 is only the sufficient condition, not the
essential condition. Do you guys have suggestion?

Quoting SATA spec:
> Word 78: Serial ATA features supported
> Bit 5 If bit 5 is set to one, then Hardware Feature Control is
> supported (see 13.10). If bit 5 is cleared to zero, then Hardware
> Feature Control is not supported and IDENTIFY DEVICE data
> word 79 bit 5 shall be cleared to zero.
> 
> If Hardware Feature Control is supported, then:
> a) IDENTIFY DEVICE data word 78 bit 5 (see 13.2.1.18) shall be
> set to one;
> b) the SET FEATURES Select Hardware Feature Control subcommand
> shall be supported (see 13.3.8);
> c) page 08h of the Identify Device Data log (see 13.7.7) shall
> be supported;


Thanks,
Shane

