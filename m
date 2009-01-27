From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git patches] libata fixes
Date: Tue, 27 Jan 2009 07:50:23 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901270748290.3123@localhost.localdomain>
References: <20090127073055.GA30360@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756195AbZA0PvO@vger.kernel.org>
In-Reply-To: <20090127073055.GA30360@havoc.gtf.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org



On Tue, 27 Jan 2009, Jeff Garzik wrote:
> 
> Please pull from 'upstream-linus' branch of
> master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus
> 
> to receive the following updates:
> 
>  drivers/ata/Kconfig              |    6 ++--
>  drivers/ata/libata-sff.c         |   12 ++++++-
>  drivers/ata/pata_rb532_cf.c      |    2 -
>  drivers/ata/pata_via.c           |   22 +++++++++---
>  drivers/ata/sata_mv.c            |   56 ++++++++++++++----------------
>  drivers/ata/sata_nv.c            |   70 +++++++++++++++++++++++--------------
>  include/linux/pci_ids.h          |    4 ++
>  7 files changed, 104 insertions(+), 68 deletions(-)
>  delete mode 100644 arch/arm/mach-integrator/clock.h

Hmm. That delete of the empty file is "correct" (and probably came as a 
result of somebody doing "make distclean" which deletes empty files), but 
should not have been committed as part of "libata-sff: fix incorrect EH 
message".

Seems to be a mistake, and a small one, but still.. Be more careful.

			Linus
