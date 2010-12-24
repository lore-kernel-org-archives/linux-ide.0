From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: Slow disks.
Date: Fri, 24 Dec 2010 14:01:29 +0100
Message-ID: <m3aajvz5na.fsf@intrepid.localdomain>
References: <20101220141553.GA6088@bitwizard.nl>
	<20101220190630.66084e1d@neptune.home>
	<AANLkTi=VAJbVSzX_DH9_==a3RonLJmawYu3MzF-uqGXC@mail.gmail.com>
	<20101222104306.GB30941@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101222104306.GB30941@bitwizard.nl> (Rogier Wolff's message of
	"Wed, 22 Dec 2010 11:43:06 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Greg Freemyer <greg.freemyer@gmail.com>, Bruno =?utf-8?Q?Pr=C3=A9mont?= <bonbons@linux-vserver.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Rogier Wolff <R.E.Wolff@BitWizard.nl> writes:

> ata6.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 0/32)
> scsi 5:0:0:0: Direct-Access     ATA      WDC WD10EARS-00Y 80.0 PQ: 0 ANSI: 5
> sd 2:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 TB/931
> GiB)

WD10EARS are "green" drives, 5400 rpm. They aren't designed exactly for
speed. Never used them, though.

No NCQ? Sil 3114 doesn't support of course. ICH7 (without letters)
doesn't do AHCI either IIRC.

>   9 Power_On_Hours          0x0032   091   091   000    Old_age
> Always       -       7189
> 193 Load_Cycle_Count        0x0032   164   164   000    Old_age   Always
>       -       109955

Hmm, some agressive power savings? May reduce performance significantly.
I'd disable all this "green" crap first.

> Where it seems that WD simply says not to use these drives in a RAID.

That smells like "don't use them in any serious application".

I'd start with a RAID-1 or RAID-10 if possible.
-- 
Krzysztof Halasa
