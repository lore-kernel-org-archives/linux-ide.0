From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/5] pata_hpt3x2n: always stretch UltraDMA timing
Date: Tue, 8 Dec 2009 20:28:22 +0100
Message-ID: <200912082028.22088.bzolnier@gmail.com>
References: <200912072225.52223.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f209.google.com ([209.85.219.209]:63262 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756186AbZLHTaE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Dec 2009 14:30:04 -0500
Received: by ewy1 with SMTP id 1so3176006ewy.28
        for <linux-ide@vger.kernel.org>; Tue, 08 Dec 2009 11:30:09 -0800 (PST)
In-Reply-To: <200912072225.52223.sshtylyov@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org, stable@kernel.org, alan@lxorguk.ukuu.org.uk


Hi,

On Monday 07 December 2009 08:25:52 pm Sergei Shtylyov wrote:
> The UltraDMA Tss timing must be stretched with ATA clock of 66 MHz, but the
> driver only does this when PCI clock is 66 MHz, whereas it always programs
> DPLL clock (which is used as the ATA clock) to 66 MHz.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

I've reviewed those patches and they all look fine to me.

Same with your other HPT3xx pending fixes, namely:
* hpt366: fix clock turnaround
* pata_hpt3x2n: fix clock turnaround
* hpt366: add debounce delay to cable_detect() method

PS everything is in my ATA fixes tree now
--
Bartlomiej Zolnierkiewicz
