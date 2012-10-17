From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: ata4.00: failed to get Identify Device Data, Emask 0x1
Date: Wed, 17 Oct 2012 09:38:34 +0800
Message-ID: <507E0C1A.1010705@intel.com>
References: <20121016144932.GA24044@aftab.osrc.amd.com> <20121016155824.00d5b618@pyramind.ukuu.org.uk> <20121016151830.GB24044@aftab.osrc.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:63265 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755928Ab2JQBio (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Oct 2012 21:38:44 -0400
In-Reply-To: <20121016151830.GB24044@aftab.osrc.amd.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bp@amd64.org>, Shane Huang <shane.huang@amd.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On 10/16/2012 11:18 PM, Borislav Petkov wrote:
> On Tue, Oct 16, 2012 at 03:58:24PM +0100, Alan Cox wrote:
>> Can you check whether 3.6 works on them. I know 3.6 is horribly broken
>> on several brands of AHCI controller (Jmicron for example). Dunno
>> where Jeff is on fixing the regressions ?
> 
> If by "works" you mean I don't see the message there, then yes, it does.
> Logs say the message started appearing on Oct 4th after me building
> Linus master after the merge window started.
> 
> Ok, let me test 3.6.2 just in case ...<tests>... yes, no error message
> there.

This is brought by commit: 65fe1f0f66a57380229a4ced844188103135f37b,
ahci: implement aggressive SATA device sleep support.

Shane, got time to take a look? This debug message made people
uncomfortable :-)

Thanks,
Aaron

