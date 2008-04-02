From: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: No IDE drivers loaded for Toshiba Satellite 320 CDS
Date: Wed, 2 Apr 2008 22:34:58 +0200
Message-ID: <200804022235.01433.linux@rainbow-software.org>
References: <200804021524.27222.elendil@planet.nl> <200804022210.26736.linux@rainbow-software.org> <20080402202225.GJ24237@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.atlantis.sk ([80.94.52.35]:45384 "EHLO mail.atlantis.sk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763079AbYDBUfI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 2 Apr 2008 16:35:08 -0400
In-Reply-To: <20080402202225.GJ24237@csclub.uwaterloo.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Frans Pop <elendil@planet.nl>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

On Wednesday 02 April 2008 22:22:25 Lennart Sorensen wrote:
> On Wed, Apr 02, 2008 at 10:10:23PM +0200, Ondrej Zary wrote:
> > I mean S320BIDE.EXE - that's for this machine only.
>
> Hmm, I missed that one.  I wonder how they do it.  Well ISA did support
> bus mastering DMA although it seems rare to implement it.  Or it could
> be VLB style.

I suspect that the IDE controller is integrated into the Toshiba chipset but 
does not appear as a separate PCI device. It could be controlled by some 
registers of the "host-bridge" or some other device.

-- 
Ondrej Zary
