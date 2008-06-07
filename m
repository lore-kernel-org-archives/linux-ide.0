From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 4/4] ide: tighten checks on PCI BARs in
 ide_hwif_configure()
Date: Sat, 7 Jun 2008 01:12:19 +0100
Message-ID: <20080607011219.360dbd78@core>
References: <200806062341.26708.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:45720 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752131AbYFGA2H (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 6 Jun 2008 20:28:07 -0400
In-Reply-To: <200806062341.26708.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 6 Jun 2008 23:41:26 +0200
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> Alan has fixed PCI layer handling of PCI IDE in Compatibility mode so
> PCI BAR 0/1 (and/or 2/3) content reported by kernel should never be zero.

Providing you are in compatability mode - you might see 0 for a native
mode port that has not been assigned, and now and then a bios will lob
you one of those just to see what happens 8)
