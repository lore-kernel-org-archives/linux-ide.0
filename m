From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Constant ata messages on console with commit 28361c403683 ("libata: add extra internal command") (was Re: [GIT PULL 2/2] libata changes for v4.18-rc1)
Date: Mon, 18 Jun 2018 17:33:57 +1000
Message-ID: <87bmc8a6qi.fsf@concordia.ellerman.id.au>
References: <20180605190807.GE1351649@devbig577.frc2.facebook.com> <20180605191525.GF1351649@devbig577.frc2.facebook.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180605191525.GF1351649@devbig577.frc2.facebook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: linux-ide@vger.kernel.org

Tejun Heo <tj@kernel.org> writes:
...
> Jens Axboe (10):
>       libata: introduce notion of separate hardware tags
>       libata: convert core and drivers to ->hw_tag usage
>       libata: bump ->qc_active to a 64-bit type
>       libata: use ata_tag_internal() consistently
>       libata: remove assumption that ATA_MAX_QUEUE - 1 is the max
>       sata_nv: set host can_queue count appropriately
>       libata: add extra internal command

Replying here because I can't find the original mail.

The above commit is causing one of my machines to constantly spew ata
messages on the console, according to bisect:

# first bad commit: [28361c403683c2b00d4f5e76045f3ccd299bf99d] libata: add extra internal command

To get it to boot I have to also apply:

  88e10092f6a6 ("sata_fsl: use the right type for tag bitshift")


The system boots OK and seems fine, except that it's just printing
multiple of these per second:

  ata2: Signature Update detected @ 0 msecs
  ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
  ata2.00: configured for UDMA/100
  ata2: Signature Update detected @ 0 msecs
  ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
  ata2.00: configured for UDMA/100
  ata2: Signature Update detected @ 0 msecs
  ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
  ata2.00: configured for UDMA/100
  ata2: Signature Update detected @ 0 msecs
  ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
  ata2.00: configured for UDMA/100
  ata2: Signature Update detected @ 0 msecs

And it never seems to stop.

The machine is a Freescale/NXP P5020ds, using the sata_fsl driver
presumably. Any ideas?

cheers
