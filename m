From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH 01/64] libata: fix CFA handling in ide_timing_compute()
Date: Wed, 20 Jan 2010 23:06:31 -0500
Message-ID: <4B57D2C7.1000007@garzik.org>
References: <20100118171349.14623.90030.sendpatchset@localhost> <20100118171357.14623.36435.sendpatchset@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:58696 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143Ab0AUEGe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Jan 2010 23:06:34 -0500
In-Reply-To: <20100118171357.14623.36435.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 01/18/2010 12:13 PM, Bartlomiej Zolnierkiewicz wrote:
> From: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
> Subject: [PATCH] libata: fix CFA handling in ide_timing_compute()
>
> Use standard cycle timing for CFA PIO5 and PIO6 modes.
>
> Based on commit 74638c8 for IDE subsystem.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
> ---
>   drivers/ata/libata-core.c |   17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)

applied


