From: Borislav Petkov <bp@alien8.de>
Subject: Re: Which disk is ata4?
Date: Thu, 30 Aug 2012 18:29:38 +0200
Message-ID: <20120830162938.GA24523@x1.osrc.amd.com>
References: <CALCETrW-LFzcHYgx=thQiuTfU8RdRBrtXwE7QboWpNrjz4An4A@mail.gmail.com>
 <alpine.LNX.2.01.1208301809370.25988@frira.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:50293 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750961Ab2H3Q33 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 30 Aug 2012 12:29:29 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.01.1208301809370.25988@frira.zrqbmnf.qr>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jan Engelhardt <jengelh@inai.de>
Cc: Andy Lutomirski <luto@amacapital.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Bjoern Franke <bjo@nord-west.org>, Tim Nufire <linux_ide_tim@ibink.com>

On Thu, Aug 30, 2012 at 06:14:46PM +0200, Jan Engelhardt wrote:
> This tells me everything to replace a disk.
> 1. sdparm -C stop /dev/sdb
> 2. Removing Z1F0KR3H from the chassis.

Yep, the serial number is the best suggestion so far.

Are we sure this serial number is always programmed in by the hdd
vendors so that sdparm can read it out?

I'm thinking here of the DMI debacle of some vendors.

Thanks.

-- 
Regards/Gruss,
Boris.
