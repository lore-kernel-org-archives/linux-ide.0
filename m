From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] add PATA host controller support for Cirrus Logic's EP93xx CPUs
Date: Wed, 2 Dec 2009 02:06:59 +0100
Message-ID: <200912020206.59659.bzolnier@gmail.com>
References: <200911261651.40928.bzolnier@gmail.com> <4B15BAA1.2010408@bluewatersys.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:48923 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754809AbZLBBHz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Dec 2009 20:07:55 -0500
In-Reply-To: <4B15BAA1.2010408@bluewatersys.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ryan Mallon <ryan@bluewatersys.com>
Cc: linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.montavista.com>, Joao Ramos <joao.ramos@inov.pt>, H Hartley Sweeten <hsweeten@visionengravers.com>

On Wednesday 02 December 2009 01:53:53 am Ryan Mallon wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > Based on the older IDE host driver by Joao Ramos and review comments
> > for it from Sergei Shtylyov.  Not yet tested with the real hardware.
> >
> 
> Hi Bartlomiej,
> 
> I have got as far as patching this into my kernel and doing a build test
> (still need to find a hard-disk to test). I got some build errors, see
> below:

Hi,

Many thanks for picking this driver up.

The following preparatory libata one-liner is needed to make it build:

	http://patchwork.kernel.org/patch/62926/

and you may also need to update ep93xx ide gpio patch:

	http://thread.gmane.org/gmane.linux.ports.arm.kernel/57688/focus=58730

to current kernels to make the hardware work.

--
Bartlomiej Zolnierkiewicz
