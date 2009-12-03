From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: add comment documenting PIO latency issues on
 UP
Date: Thu, 03 Dec 2009 02:36:31 -0500
Message-ID: <4B176A7F.2060100@garzik.org>
References: <200911261711.16954.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f116.google.com ([209.85.211.116]:55714 "EHLO
	mail-yw0-f116.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991AbZLCHuz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 3 Dec 2009 02:50:55 -0500
In-Reply-To: <200911261711.16954.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 11/26/2009 11:11 AM, Bartlomiej Zolnierkiewicz wrote:
>
> Based on:
> http://lkml.indiana.edu/hypermail/linux/kernel/0908.2/01420.html
>
> Signed-off-by: Bartlomiej Zolnierkiewicz<bzolnier@gmail.com>
> ---
>   drivers/ata/libata-core.c |    7 +++++++
>   1 file changed, 7 insertions(+)

applied


