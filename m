From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: Possibly SATA related freeze killed networking and RAID
Date: Thu, 29 Nov 2007 17:16:43 -0500
Message-ID: <474F3A4B.3080304@cfl.rr.com>
References: <d00698fb0711201109m23ff096eiabeb22c8f9a917dc@mail.gmail.com> <20071120220512.46b9e975@the-village.bc.nu> <20071126120649.GC4701@ucw.cz> <474CCA82.7030000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761380AbXK2WRK@vger.kernel.org>
In-Reply-To: <474CCA82.7030000@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>, noah <noah123@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Tejun Heo wrote:
> Agreed.  Nobody cared on ATA controllers is usually very effective at
> taking the whole machine down.  Is there any reason why we don't turn on
> irqpoll on turned off IRQs automatically?

Why does a single spurious interrupt cause it to be shut down?  I can 
see if the interrupt is stuck on and keeps interrupting constantly, but 
if it's just the occasional spurious interrupt, why not just ignore it 
and move on?
