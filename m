From: Frans Pop <elendil@planet.nl>
Subject: Re: No IDE drivers loaded for Toshiba Satellite 320 CDS
Date: Wed, 2 Apr 2008 16:29:40 +0200
Message-ID: <200804021629.41153.elendil@planet.nl>
References: <200804021524.27222.elendil@planet.nl> <20080402135729.GB24239@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758601AbYDBO3z@vger.kernel.org>
In-Reply-To: <20080402135729.GB24239@csclub.uwaterloo.ca>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
List-Id: linux-ide@vger.kernel.org

On Wednesday 02 April 2008, Lennart Sorensen wrote:
> How old is that system?

Not sure. As the system only has 32MB RAM I'd say sometime late 1990s.

> Maybe the IDE isn't even PCI based.  That would explain why nothing shows
> in lspci, but the IDE ports are still present and working.

Could be. What would it be then? ISA? Any way to recognize that?

I did find a product page, but it's low on real specs:
http://www.toshiba.ca/web/product.grp?lg=en&section=1&group=223&product=1605

> One could always just manually tell the system to always load
> ide-generic, since deciding what to load does seem to be a userspace
> choice these days.

Well, in the Debian Installer we prefer to load things automatically 
whenever possible. If the kernel does not do it, that's fine.

But to have the installer itself automatically load ide-generic for the 
user, we'd still have to somehow recognize that we need the driver.
Any ideas/suggestions what to look for?

Cheers,
FJP
