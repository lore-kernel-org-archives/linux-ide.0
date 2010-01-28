From: Vishal Rao <vishalrao@gmail.com>
Subject: Re: [PATCH] ata: Disable NCQ for Crucial M225 brand SSDs
Date: Thu, 28 Jan 2010 07:42:33 +0530
Message-ID: <aacba7e1001271812o3e53ba6cq3c00c95c28f48382@mail.gmail.com>
References: <aacba7e1001260704m27c99a0dy6c3f50c38ce6b430@mail.gmail.com>
	 <72dbd3151001261251s606ebf00h86c2ce63293305b6@mail.gmail.com>
	 <aacba7e1001261621v6abb4270i996a28d19c9f7d7@mail.gmail.com>
	 <72dbd3151001261632t7bbe43d0nb7490eae02185c81@mail.gmail.com>
	 <20100127010204.7976c38b@lxorguk.ukuu.org.uk>
	 <aacba7e1001261714n42a68824k62c411cd1e5d7893@mail.gmail.com>
	 <4B60C1C0.8050402@teksavvy.com>
	 <aacba7e1001271516k3bb82a0fq7e019b28f3b8972f@mail.gmail.com>
	 <72dbd3151001271541l7026389fgd2c91f9ee6502472@mail.gmail.com>
	 <aacba7e1001271624r4111908ch7a54e315ede54bbb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pz0-f190.google.com ([209.85.222.190]:59778 "EHLO
	mail-pz0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755858Ab0A1CMe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Jan 2010 21:12:34 -0500
In-Reply-To: <aacba7e1001271624r4111908ch7a54e315ede54bbb@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Rees <drees76@gmail.com>
Cc: Mark Lord <kernel@teksavvy.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, jgarzik@pobox.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, trivial@kernel.org, stable@kernel.org

2010/1/28 Vishal Rao <vishalrao@gmail.com>:
> 2010/1/28 David Rees <drees76@gmail.com>:
>>
>> badblocks <name of partition>
>>
>> See the man page for more details, but that should do a read test -
>> may want to boot from a rescue disk or from another disk if possible
>> to run the test.
>
> The first "badblocks /dev/sda7" run went ahead with no output.

here's the output, let me know if im doing something incorrect and/or
any of you need further info/testing from me:

vishal@thunderbird:~$ sudo badblocks -nv /dev/sda7 | tee badblocks.txt
[sudo] password for vishal:
Checking for bad blocks in non-destructive read-write mode
>From block 0 to 25173822
Testing with random pattern: Pass completed, 0 bad blocks found.
vishal@thunderbird:~$ cat badblocks.txt
vishal@thunderbird:~$ dmesg | grep ata1
[    0.890636] ata1: SATA max UDMA/133 abar m2048@0xe3225000 port
0xe3225100 irq 30
[    1.420680] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.420952] ata1.00: HPA unlocked: 250067567 -> 250069680, native 250069680
[    1.420959] ata1.00: ATA-8: CRUCIAL_CT128M225, 1916, max UDMA/133
[    1.420962] ata1.00: 250069680 sectors, multi 1: LBA48 NCQ (not used)
[    1.421629] ata1.00: configured for UDMA/133
vishal@thunderbird:~$ uname -a
Linux thunderbird 2.6.32-11-generic #16~vishalrao2 SMP Tue Jan 26
19:03:33 IST 2010 x86_64 GNU/Linux
vishal@thunderbird:~$
