From: Tejun Heo <tj@kernel.org>
Subject: Re: sata_svw data corruption, strange problems
Date: Mon, 23 Jun 2008 22:05:40 +0900
Message-ID: <485F9FA4.3050608@kernel.org>
References: <20080617093602.GA28140@elf.ucw.cz>	<485EF061.3010601@kernel.org>	<20080623082055.GB1850@elf.ucw.cz>	<je63s0sfxv.fsf@sykes.suse.de>	<20080623085338.GE1850@elf.ucw.cz>	<485F6540.6000907@kernel.org>	<20080623090130.GF1850@elf.ucw.cz>	<1214211859.8011.250.camel@pasglop>	<485F7184.1030907@kernel.org> <20080623104221.3b4fb350@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755714AbYFWNGn@vger.kernel.org>
In-Reply-To: <20080623104221.3b4fb350@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: benh@kernel.crashing.org, Pavel Machek <pavel@suse.cz>, Andreas Schwab <schwab@suse.de>, kernel list <linux-kernel@vger.kernel.org>, jgarzik@pobox.com, IDE/ATA development list <linux-ide@vger.kernel.org>, Trivial patch monkey <trivial@kernel.org>
List-Id: linux-ide@vger.kernel.org

Alan Cox wrote:
>>> BTW. Tejun, I suppose that usually starting DMA after issuing the
>>> command is a standard practice of legacy/sff type controllers ? Or it's
>>> just because that's how linux did it until now ?
>> It's how the standard says it should be programmed.  Please take a look
>> at section 3 of the following document.
>>
>> http://www.centrillium-it.com/Projects/idems100.pdf
>>
>> It's a non-issue for PATA ones as the host is responsible for running
> 
> It's very much an issue for PATA. If you start the DMA before time things
> go wrong. The DMA has to start after the command is issued (or for ATAPI
> after the command and the cdb are issued). Various ATAPI devices get
> quite cross if you mess this up.
> 
> In some cases the driver code also depends upon this as we software drive
> the data clocks so have to reprogram them after command issue and before
> data transfer begins.

I was saying drive getting ready before command issue was non issue.

-- 
tejun
