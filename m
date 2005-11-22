From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: VIA VT8251 on Asus A8V-MV
Date: Mon, 21 Nov 2005 21:16:04 -0500
Message-ID: <20051122021604.GA32312@havoc.gtf.org>
References: <43808DAC.9030806@mgmservers.com> <20051121235516.GA8515@midnight.suse.cz> <43827C76.3000703@mgmservers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from havoc.gtf.org ([69.61.125.42]:5352 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S964862AbVKVCQF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Nov 2005 21:16:05 -0500
Content-Disposition: inline
In-Reply-To: <43827C76.3000703@mgmservers.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jason Cribbins <jason.cribbins@mgmservers.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-ide@vger.kernel.org

On Mon, Nov 21, 2005 at 09:03:34PM -0500, Jason Cribbins wrote:
> Can you explain the situation in the following URL?
> http://forums.viaarena.com/messageview.aspx?catid=28&threadid=68455&STARTPAGE=1
> 
> Also as I try to install fedora it reports that it is unable to find any 
> installed HDs.  I have found an OpenBSD patch that does get it to work 
> there but nothing for Linux that works as of right now.
> My BIOS has the controller set to SATA mode right now and its not 
> visible.  Even if I set it to RAID mode or AHCI modes I get the same 
> result using fedora core4 and what ever kernel comes bundled with their 
> installer.

The AHCI driver certainly won't work without adding PCI IDs to it...

did you try that?

These threads seem to indicate that AHCI needs updating for VIA.

	Jeff



