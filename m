From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: Limiting DMA speeds for individual IDE drives
Date: Tue, 08 Sep 2009 22:04:22 +0400
Message-ID: <4AA69CA6.9050909@ru.mvista.com>
References: <Pine.LNX.4.44L0.0909081157520.2653-100000@iolanthe.rowland.org> <20090908161204.GA3113@gambetta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752048AbZIHSCR@vger.kernel.org>
In-Reply-To: <20090908161204.GA3113@gambetta>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Frederik Deweerdt <frederik.deweerdt@xprog.eu>, linux-ide@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Hello.

Frederik Deweerdt wrote:

>>Is there any simple way to force the old IDE driver to limit the DMA
>>speed for a particular device?

    No, you can only disable DMA totally, and then set the needed speed via 
hdparm.

>>I've got a situation where a drive claims to be capable of supporting
>>UDMA/100, but it's in a noisy environment and gets lots of errors at
>>that speed.  I'd like to limit it to UDMA/66 or even UDMA/33.

    Are you sure that it's all because of the noise and not a cable type 
misdetection?

>>The hdparm command should be able to do this but I can't run it until 
>>the system has booted, by which time a bunch of CRC and possibly other 
>>errors have already occurred.  Ideally it should be possible to limit 
>>the speed starting as early as device detection, but I can't find any 
>>way to do it.  Is there support for such a thing or will I have to hack 
>>it in?

> Does passing ide=nodma at bootime, and then having init set the DMA at
> the right speed, would work?

    ide=nodma is now obsolete -- use ide_core.nodma=<interface>,<device> 
instead. Read Documentation/ide/ide.txt before advising. ;-)

> Regards,
> Frederik

WBR, Sergei
