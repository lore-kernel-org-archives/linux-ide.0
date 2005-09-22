From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2.6.13] drivers/ide: Enable basic VIA VT6410 IDE
	functionality
Date: Thu, 22 Sep 2005 15:28:17 +0100
Message-ID: <1127399297.18840.92.camel@localhost.localdomain>
References: <op.sxg2dxd5wc4mme@new.robertk.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030356AbVIVOB6@vger.kernel.org>
In-Reply-To: <op.sxg2dxd5wc4mme@new.robertk.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Kesterson <robertk@robertk.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Mer, 2005-09-21 at 16:38 -0500, Robert Kesterson wrote:
> This patch enables plain IDE functionality on the VIA VT6410 IDE controller
> (such as used on the Asus P4P800 Deluxe motherboard). 

Mathias Kretschmer posted a patch several months ago, and Daniel Drake
reposted it on August 30th if you check the archive. Bartlomiej was
asked to respond to/merge it but if he responded I didn't see it so it
was probably a private reply.

You can pull it from the Gentoo tree and it'll drop into other vendor
trees cleanly.

Alan
