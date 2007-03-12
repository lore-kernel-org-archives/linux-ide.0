From: Tejun Heo <htejun@gmail.com>
Subject: Re: [3/6] 2.6.21-rc2: known regressions
Date: Mon, 12 Mar 2007 20:37:04 +0900
Message-ID: <45F53B60.8020908@gmail.com>
References: <Pine.LNX.4.64.0702272105220.12485@woody.linux-foundation.org> <20070305015036.GH3441@stusta.de> <45EE9E39.3010800@garzik.org> <45F20541.9090208@crans.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <45F20541.9090208@crans.org>
Sender: linux-acpi-owner@vger.kernel.org
To: =?UTF-8?B?TWF0aGlldSBCw6lyYXJk?= <Mathieu.Berard@crans.org>
Cc: Jeff Garzik <jeff@garzik.org>, Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Michal Jaegermann <michal@ellpspace.math.ualberta.ca>, Fabio Comolli <fabio.comolli@gmail.com>, Janosch Machowinski <jmachowinski@gmx.de>, Lukas Hejtmanek <xhejtman@fi.muni.cz>, Meelis Roos <mroos@linux.ee>, Olivier Mondoloni <darkcore71@yahoo.fr>, Thomas Renninger <trenn@suse.de>, Robert Moore <robert.moore@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Mathieu B=C3=A9rard wrote:
> Jeff Garzik a =C3=A9crit :
>> Adrian Bunk wrote:
>>> Subject    : NCQ problem with ahci and Hitachi drive
>>> References : http://lkml.org/lkml/2007/3/4/178
>>> Submitter  : Mathieu B=C3=A9rard <Mathieu.Berard@crans.org>
>>> Status     : unknown
>> according to the last message in that thread, it sounds like ACPI an=
d
>> interrupt problems
>>
> Hi,
> after more testing with a 2.6.21-rc3, it appears that after several a=
ta
> errors the boot process
> somehow continued as normal, after a "NCQ disabled due to excessive
> errors" message.
> "pci=3Dnoacpi" or "noacpi" parameters workarounds the problem "irqpol=
l"
> does nothing.

I was mistaken.  It can't be IRQ routing problem.  I somehow thought th=
e
port was a ata_piix one.  Considering the reported broken NCQ feature o=
n
the device GTF might be mangling with the drive to disable NCQ or
something.  Does giving "libata.noacpi=3D1" make any difference?

Thanks.

--=20
tejun
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
