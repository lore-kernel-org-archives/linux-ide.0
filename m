From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.31-rc1 with ide-tape / STT2000A
Date: Sun, 9 Aug 2009 21:58:34 +0100
Message-ID: <20090809215834.7849c6da@lxorguk.ukuu.org.uk>
References: <h5kn9c$51r$1@ger.gmane.org>
	<4A7DE735.6090409@gmail.com>
	<h5krje$ec7$1@ger.gmane.org>
	<20090809175840.0705f2d0@lxorguk.ukuu.org.uk>
	<h5n93s$pnr$1@ger.gmane.org>
	<20090809212120.329e29b2@lxorguk.ukuu.org.uk>
	<h5nbbo$veb$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:38741 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751745AbZHIV50 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Aug 2009 17:57:26 -0400
In-Reply-To: <h5nbbo$veb$1@ger.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jim Duda <jim@duda.tzo.com>
Cc: linux-ide@vger.kernel.org

> When I load st, I don't get any /dev/st0 device with 2.6.31.
> 
> linux> lsmod | grep st
> st                     31272  0
> scsi_mod              136336  4 st,sg,libata,sd_mod
> 
> Might there be some other bug preventing st from detection the ATAPI tape drive?

Quite possibly - what does dmesg show when ata_piix is loaded ?
