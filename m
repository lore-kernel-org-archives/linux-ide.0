From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ATA: pata_at91.c bugfixes
Date: Sun, 24 Apr 2011 11:35:22 -0400
Message-ID: <4DB4433A.5000609@pobox.com>
References: <1303299877-12088-1-git-send-email-plyatov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:62486 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757576Ab1DXPf0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 24 Apr 2011 11:35:26 -0400
In-Reply-To: <1303299877-12088-1-git-send-email-plyatov@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Igor Plyatov <plyatov@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, stf_xl@wp.pl

On 04/20/2011 07:44 AM, Igor Plyatov wrote:
> * Fix "initial_timing" structure initialisation. The "struct ata_timing" must
>    contain 10 members, but ".dmack_hold" member was not initialised.
> * The AT91SAM9 microcontrollers use special coding scheme for SMC_SETUP,
>    SMC_PULSE, SMC_CYCLE registers.
>    Old driver operates correctly only with low master clock values, but
>    with high master clock it incorrectly calculates SMC values and stops
>    to operate, because SMC can be setup only to admissible ranges in special
>    format.
>    New code correctly calculates SMC registers values, adjusts calculated
>    to admissible ranges, enlarges cycles if required and converts values
>    into SMC's format.
> * Old driver calculates CS_SETUP and CS_PULSE cycles incorrectly
>    because of wrong assumptions.
>    New code calculates:
>        CS_SETUP = SETUP/2
>        CS_PULSE = PULSE + SETUP/2 + HOLD/2
> * This fixes allows to correctly operate with any master clock frequency.
>
> Signed-off-by: Igor Plyatov<plyatov@gmail.com>
> ---
>   drivers/ata/pata_at91.c |  223 ++++++++++++++++++++++++++++++++---------------
>   1 files changed, 154 insertions(+), 69 deletions(-)

FYI, the two previous "v4" patches are now applied.

Based on the comments from Stanislaw, this patch would need to be 
updated anyway.
