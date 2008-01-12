From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: 40-wire cable detected when directly connected
Date: Sat, 12 Jan 2008 17:14:37 +0100
Message-ID: <200801121714.37342.bzolnier@gmail.com>
References: <200801101824.04863.Tobias_Mueller@twam.info> <4788CECE.5090207@twam.info> <200801121709.26920.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:15127 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbYALQDH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Jan 2008 11:03:07 -0500
Received: by ug-out-1314.google.com with SMTP id z38so618168ugc.16
        for <linux-ide@vger.kernel.org>; Sat, 12 Jan 2008 08:03:05 -0800 (PST)
In-Reply-To: <200801121709.26920.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tobias =?utf-8?q?M=C3=BCller?= <Tobias_Mueller@twam.info>
Cc: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Saturday 12 January 2008, Bartlomiej Zolnierkiewicz wrote:

[...]

> I've re-read the whole thread and it seems that the possible solution for
> Addonics card would be to detect it by PCI Subsystem Vendor/Device IDs.

It seems I wasn't paying enough attention, Tejun already thought of this
but unfortunately Addonics didn't set custom Subsystem IDs.

> Could you send the output of 'lspci -vvv -xxx' command?

Still may be useful.

Bart
