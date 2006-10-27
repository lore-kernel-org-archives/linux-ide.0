From: Vasily Averin <vvs@sw.ru>
Subject: Re: [Q] ide cdrom in native mode leads to irq storm?
Date: Fri, 27 Oct 2006 17:17:34 +0400
Message-ID: <454206EE.9080206@sw.ru>
References: <453DC2A9.8000507@sw.ru> <453DC65C.8000408@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752180AbWJ0NTd@vger.kernel.org>
In-Reply-To: <453DC65C.8000408@sw.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-ide@vger.kernel.org
Cc: devel@openvz.org
List-Id: linux-ide@vger.kernel.org

Vasily Averin wrote:
> Vasily Averin wrote:
>> there is node with Intel 7520-based motherboard (MSI-9136), IDE cdrom (hda) and
>> SATA disc and 2.6.19-rc3 linux kernel.
>>
>> When I set IDE controller into the native mode, I get irq storm on the node and
>> this interrupt is disabled. If this interrupt is shared, the other subsystems
>> are stop working too.
>>
>> When I switch the IDE controller into legacy mode, all works correctly.

I have reproduced the same issue on the another node:

ASUSTeK P5GD1-VM,
Intel 915G chipset,
ICH6 IDE controller,
IDE dvdrom: SONY DVD-ROM DDU1615 (hda),
sata disk: WDC WD1600JS-00M

when I switch IDE controller to the native mode, I see "Disabling IRQ" message,
then kernel generates an oops in create_empty_buffers(), like I've reported earlier.

Could somebody please help me to troubleshoot this issue? I've seen this issue
on the customer nodes and would like to know how I can work-around this issue
without any changes inside motherboard BIOS.

thank you,
	Vasily Averin
