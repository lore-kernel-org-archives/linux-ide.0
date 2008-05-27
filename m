From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
Subject: Re: Linux 2.6.26-rc4
Date: Tue, 27 May 2008 12:01:28 +0200
Message-ID: <20080527120128.7074c1bc@werewolf.home>
References: <alpine.LFD.1.10.0805261127030.2958@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.ono.com ([62.42.230.12]:60024 "EHLO resmaa02.ono.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755296AbYE0KB7 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 May 2008 06:01:59 -0400
In-Reply-To: <alpine.LFD.1.10.0805261127030.2958@woody.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux-Kernel <linux-kernel@vger.kernel.org>, Linus-IDE <linux-ide@vger.kernel.org>

On Mon, 26 May 2008 11:41:35 -0700 (PDT), Linus Torvalds <torvalds@linux-foundation.org> wrote:

> 
> You know the drill by now: another week, another -rc.
> 
> There's a lot of small stuff in here, most people won't even notice. The 
> most noticeable thing is for all you 32-bit x86 people who use PAE 
> (enabled by the HIGHMEM64G config option) due to having too much memory in 
> your machine - mprotect() was broken due to some of the PAT fix/cleanup 
> patches, causing the NX bit to be not set correctly.
> 
> So if you had PAE enabled _and_ a recent enough CPU to have NX, but not 
> recent enough to be 64-bit (or you were just perverse and wanted to run a 
> 32-bit kernel despite having a chip that could do 64-bit and enough memory 
> that you _really_ should have used a 64-bit kernel), you'd get various 
> random program failures with SIGSEGV. It ranged from X not starting up to 
> apparently OpenOffice not working if it did.
> 
> But most of the changes, as usual, are in drivers, at 60%, with some DRI 
> changes leading the way (fixing a number of other regressions, mainly by 
> reverting the under-cooked vblank update). Network, MMC, USB, watchdog and 
> IDE drivers also got updates.
> 
> We had CIFS and NFS updates, and some arch updates as usual. The dirstat 
> gives the overview:
> 

I have this patchsets collected from LKML, that still apply ontop of -rc4.
Are they not so urgent or are they not needed any more ?

JBD[2] races
http://marc.info/?l=linux-ext4&m=121141319601650&w=2
http://marc.info/?l=linux-ext4&m=121141319701660&w=2

libata EH timeout handling
http://marc.info/?l=linux-ide&m=121121761530723&w=2

alignment in block DMA
http://marc.info/?l=linux-ide&m=121125981930670&w=2

-- 
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2008.1 (Cooker) for i586
Linux 2.6.23-jam05 (gcc 4.2.2 20071128 (4.2.2-2mdv2008.1)) SMP PREEMPT
