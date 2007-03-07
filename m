From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [3/6] 2.6.21-rc2: known regressions
Date: Wed, 07 Mar 2007 06:12:57 -0500
Message-ID: <45EE9E39.3010800@garzik.org>
References: <Pine.LNX.4.64.0702272105220.12485@woody.linux-foundation.org> <20070305015036.GH3441@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20070305015036.GH3441@stusta.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, =?UTF-8?B?TWF0?= =?UTF-8?B?aGlldSBCw6lyYXJk?= <Mathieu.Berard@crans.org>, linux-ide@vger.kernel.org, Michal Jaegermann <michal@ellpspace.math.ualberta.ca>, Fabio Comolli <fabio.comolli@gmail.com>, Tejun Heo <htejun@gmail.com>, Janosch Machowinski <jmachowinski@gmx.de>, Lukas Hejtmanek <xhejtman@fi.muni.cz>, Meelis Roos <mroos@linux.ee>, Olivier Mondoloni <darkcore71@yahoo.fr>, Thomas Renninger <trenn@suse.de>, Robert Moore <robert.moore@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Adrian Bunk wrote:
> Subject    : NCQ problem with ahci and Hitachi drive
> References : http://lkml.org/lkml/2007/3/4/178
> Submitter  : Mathieu B=C3=A9rard <Mathieu.Berard@crans.org>
> Status     : unknown

according to the last message in that thread, it sounds like ACPI and=20
interrupt problems


> Subject    : SATA_ACPI errors during kernel boot
> References : http://bugzilla.kernel.org/show_bug.cgi?id=3D8080
>              http://bugzilla.kernel.org/show_bug.cgi?id=3D8046
>              http://bugzilla.kernel.org/show_bug.cgi?id=3D8095
>              http://lkml.org/lkml/2007/2/22/159
> Submitter  : Janosch Machowinski <jmachowinski@gmx.de>
>              Lukas Hejtmanek <xhejtman@fi.muni.cz>
>              Meelis Roos <mroos@linux.ee>
>              Olivier Mondoloni <darkcore71@yahoo.fr>
> Handled-By : Thomas Renninger <trenn@suse.de>
>              Tejun Heo <htejun@gmail.com>
>              Robert Moore <robert.moore@intel.com>
> Status     : problem is being debugged

Note that there WILL be an increase in ACPI diagnostic output.  The key=
=20
difference is whether the users are seeing scary printks, or whether th=
e=20
boot is actually breaking.

	Jeff


-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
