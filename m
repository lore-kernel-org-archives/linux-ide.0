From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.31-rc1 with ide-tape / STT2000A
Date: Sun, 9 Aug 2009 21:21:20 +0100
Message-ID: <20090809212120.329e29b2@lxorguk.ukuu.org.uk>
References: <h5kn9c$51r$1@ger.gmane.org>
	<4A7DE735.6090409@gmail.com>
	<h5krje$ec7$1@ger.gmane.org>
	<20090809175840.0705f2d0@lxorguk.ukuu.org.uk>
	<h5n93s$pnr$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:43855 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753322AbZHIUUL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Aug 2009 16:20:11 -0400
In-Reply-To: <h5n93s$pnr$1@ger.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jim Duda <jim@duda.tzo.com>
Cc: linux-ide@vger.kernel.org

> 00:1f.1 IDE interface: Intel Corporation 82801EB/ER (ICH5/ICH5R) IDE Controller (rev 02)
> 00:1f.2 IDE interface: Intel Corporation 82801EB (ICH5) SATA Controller (rev 02)
> 
> I want to get guess CONFIG_PATA_MPIIX.
> 
> Would you agree?

Ah its ata_piix in this case as it handles both PATA and SATA

> I'm also using 3 SATA drives.  Is it okay to mix PATA and SATA drivers?

libata handles both together as well as the various new kinds of
interface (AHCI etc) which older IDE code can't handle.

Alan
