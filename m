From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 2/3] pata_pdc202xx_old: fix UDMA mode for PDC2026x chipsets
Date: Sat, 13 Feb 2010 17:44:10 -0500
Message-ID: <4B772B3A.6030202@garzik.org>
References: <20100213133538.11564.94218.sendpatchset@localhost> <20100213133559.11564.54028.sendpatchset@localhost> <201002131444.58139.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.211.179]:56777 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543Ab0BMWoN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Feb 2010 17:44:13 -0500
In-Reply-To: <201002131444.58139.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>

On 02/13/2010 08:44 AM, Bartlomiej Zolnierkiewicz wrote:
> .sff_exec_command	= pdc202xx_exec_command,

applied patch #2 + this missing chunk

