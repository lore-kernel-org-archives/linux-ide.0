From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] prevent module unloading for legacy IDE chipset drivers
Date: Thu, 22 Apr 2004 16:35:12 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200404221635.12490.bzolnier@elka.pw.edu.pl>
References: <200404212219.24622.bzolnier@elka.pw.edu.pl> <200404220250.15078.bzolnier@elka.pw.edu.pl> <20040422103355.GC15176@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-S264088AbUDVOgm@vger.kernel.org>
In-Reply-To: <20040422103355.GC15176@harddisk-recovery.com>
Content-Disposition: inline
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: andersen@codepoet.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Thursday 22 of April 2004 12:33, Erik Mouw wrote:
> On Thu, Apr 22, 2004 at 02:50:15AM +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Thursday 22 of April 2004 02:41, Erik Andersen wrote:
> > > Out of curiosity, what would be needed to make it safe to unload
> > > all ide modules from a system with a scsi rootfs?
> >
> > It doesn't matter - you still may end up unloading modules which are in
> > use.
>
> FWIW, with the old IDE code I've been unloading IDE modules for years
> without a single problem.

IDE chipset drivers were made 'modular' in 2.4.21
(release date 13-Jun-2003) and this complicated things

> What makes IDE sufficiently different from SCSI that we can't unload
> IDE host drivers?

- no reference counting
- lack of release() method
- insufficient locking

Cheers,
Bartlomiej
