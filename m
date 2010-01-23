From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATA port not detected when using AHCI on Intel 82801GB/GR/GH
Date: Sat, 23 Jan 2010 10:14:57 +0000
Message-ID: <20100123101457.7f8cbb3f@lxorguk.ukuu.org.uk>
References: <4B591D61.8030003@infernix.net>
	<4B593128.1040104@gmail.com>
	<4B59A0CD.4000801@infernix.net>
	<4B5A4F7A.4040709@gmail.com>
	<4B5A5F09.1070300@infernix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:52081 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754715Ab0AWKMz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Jan 2010 05:12:55 -0500
In-Reply-To: <4B5A5F09.1070300@infernix.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: infernix <infernix@infernix.net>
Cc: Robert Hancock <hancockrwd@gmail.com>, linux-ide@vger.kernel.org

> Can we force ata_piix to pick up the IDE controller? I mean the old IDE 
> PIIX driver can do it (albeit terribly slow), so why can't ata_piix? I 

I doubt PIIX is doing it - the legacy IDE bits are.

What I think is going on is this (and I don't have docs so I am guessing)

	- The SOHO NAS has the IDE DOM wired to the LPC bus somewhere
	  directly (as legacy IDE)
	- The PATA port is intentionally disabled by the firmware to make
	  room for the DOM.

In which case loading "pata_legacy" ought to make the right magic occur.
Can you send me an

If that is the case I suspect the PIIX PATA port is not used at all
by the sytstem (is it even wired to pins anywhere ?). If it is used then
presumably the original NAS firmware does something truely hideous along
the lines of

-	Load boot image from DOM
-	Turn off DOM/on PIIX
-	Start using PIIX

Alan
