From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Possible regression of LBA48 support for piix
Date: Thu, 17 Dec 2009 07:02:02 -0500
Message-ID: <4B2A1DBA.3070300@garzik.org>
References: <A9C151C7BD19EC47976D4AA14CF277A8BC64DFB2AF@HMCEXMBX01CLUS.hmcikoula.com> <19241.63911.160765.909812@pilspetsen.it.uu.se> <A9C151C7BD19EC47976D4AA14CF277A8BC64DFB2C1@HMCEXMBX01CLUS.hmcikoula.com> <4B2A1008.9070202@garzik.org> <A9C151C7BD19EC47976D4AA14CF277A8BC64DFB301@HMCEXMBX01CLUS.hmcikoula.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.211.182]:40036 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457AbZLQMCJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 17 Dec 2009 07:02:09 -0500
In-Reply-To: <A9C151C7BD19EC47976D4AA14CF277A8BC64DFB301@HMCEXMBX01CLUS.hmcikoula.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Romain Kubany <rkubany@ikoula.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

On 12/17/2009 06:34 AM, Romain Kubany wrote:
> Thanks for your concern. :)
>
> Here is the full dmesg output : http://pastebin.com/f484004a5 (2.6.28 with same config as in my previous mail)
>
> I'm going to test a 2.6.32.1 kernel and similar config

[    0.804002] ata1.00: ATA-0: Virtual HD, 1.1.0, max MWDMA2
[    0.804002] ata1.00: 267382800 sectors, multi 128: LBA

For starters, the virtual disk is reporting ATA version 0.  That means 
the disk is telling us it does not support LBA48 or other advanced 
features.  libata (and probably IDE, too) happily obliges.

That sounds like either a broken emulation, or some information returned 
from the virtual disk got zeroed somehow.

	Jeff


