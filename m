From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [Bug 49151] New: NULL pointer dereference in pata_acpi
Date: Thu, 15 Nov 2012 23:50:38 -0500
Message-ID: <50A5C61E.2050502@pobox.com>
References: <bug-49151-11633@https.bugzilla.kernel.org/> <20121020120047.GC17563@liondog.tnic> <50841CFC.2030802@talktalk.net> <20121021165756.GA20642@liondog.tnic> <50856AA8.1000607@talktalk.net> <20121022202734.GA16169@liondog.tnic> <20121023110549.06f9c2e8@pyramind.ukuu.org.uk> <20121023101751.GA24656@liondog.tnic> <5087B4CA.1030502@talktalk.net> <20121024115746.3d41fce7@pyramind.ukuu.org.uk> <20121103042635.GA21829@liondog.tnic> <20121103164819.14c71bb5@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:60317 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283Ab2KPEum (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Nov 2012 23:50:42 -0500
Received: by mail-vc0-f174.google.com with SMTP id fk26so2484697vcb.19
        for <linux-ide@vger.kernel.org>; Thu, 15 Nov 2012 20:50:42 -0800 (PST)
In-Reply-To: <20121103164819.14c71bb5@pyramind.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Borislav Petkov <bp@alien8.de>, phillip.wood@dunelm.org.uk, phillip.wood@talktalk.net, "Anton V. Boyarshinov" <boyarsh@altlinux.org>, bugzilla-daemon@bugzilla.kernel.org, linux-ide@vger.kernel.org

On 11/03/2012 12:48 PM, Alan Cox wrote:
> On Sat, 3 Nov 2012 05:26:35 +0100
> Borislav Petkov <bp@alien8.de> wrote:
>
>> On Wed, Oct 24, 2012 at 11:57:46AM +0100, Alan Cox wrote:
>>> Which is an ATA layer bug - adev->dma_mode should never be called
>>> without a DMA mode in normal use.
>>
>> Ok, it looks like this would take a while to fix.
>
> So a 30 second glance says that the problem is that you seem to have
> dma_mode uninitialised as zero which is bogus.
>
> That means either ata_acpi_gtm_xfermask broke (it should have set the
> bits to 0xFF if no mode is found), ata_dma_enabled is broken, or
> pacpi_qc_issue got called before pacpi_port_start (which seems wildly
> unlikely)
>
> Needs someone to go and dump the relevant values in the right places and
> see what is breaking in the pata_acpi setup logic.

Agreed -- though the WARN_ONCE() will at least give us trivially better 
poops.

	Jeff




