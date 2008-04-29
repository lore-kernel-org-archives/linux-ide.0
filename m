From: speedy <speedy@3d-io.com>
Subject: Re[2]: [BUG REPORT, 2.6.22] sata controler failure on nforce 2 chipset
Date: Tue, 29 Apr 2008 02:55:43 +0200
Message-ID: <986072.20080429025543@3d-io.com>
References: <396712385.20080423011459@3d-io.com> <20080425231108.03dfa7cb.akpm@linux-foundation.org>
Reply-To: speedy <speedy@3d-io.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S935302AbYD2A4A@vger.kernel.org>
In-Reply-To: <20080425231108.03dfa7cb.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello Andrew,

Saturday, April 26, 2008, 8:11:08 AM, you wrote:

>> On Wed, 23 Apr 2008 01:14:59 +0200 speedy <speedy@3d-io.com> wrote:
>> Hello Linux kernel crew,
>> 
>>        [Consider this more as a datapoint then a bug report, as after
>>        one network and one sata/southbridge issues showing up
>>        interminnently, the ASRock motherboard involved will be
>>        scrapped for a different one]
>> 
>>        The integrated NVidia sata controller and/or the hard-drive has failed
>>        during operation with the following output:

AM> 2.6.22 is rather old.  Can you please retest 2.6.25?

    Unfortunately not, the motherboard has been changed for a
    different one in that server, as I needed to deploy it. The
    system is now behaving properly.

    If someone of the kernel developers is interested in toying with
    an NForce 2 motherboard which probably overheats the southbridge
    and crashes approx. once a day under I/O load, I could ask the
    management to donate it.

    It reproduces:

    * "RX unit hang detected" in i1000 drivers
    * SATA soft-raid (infinite?) HDD resetting loop

    ;)

    Cheers!


-- 
Best regards,
 speedy                            mailto:speedy@3d-io.com
