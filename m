From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] pata_mpc52xx: optimizing code size by change of ATA
 timing data types
Date: Mon, 01 Mar 2010 15:18:28 -0500
Message-ID: <4B8C2114.1030806@pobox.com>
References: <200912161429.14968.roman.fietze@telemotive.de> <fa686aa41002161141v20a06768nbdcdb094293bb5b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f182.google.com ([209.85.210.182]:34468 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831Ab0CAUSd (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Mar 2010 15:18:33 -0500
In-Reply-To: <fa686aa41002161141v20a06768nbdcdb094293bb5b2@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Roman Fietze <roman.fietze@telemotive.de>, linuxppc-dev@lists.ozlabs.org, linux-ide@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 02/16/2010 02:41 PM, Grant Likely wrote:
> [cc'd linux-kernel, linux-ide and Jeff Garzik]
>
> Hi Roman.
>
> you should use ./scripts/get_maintainer.pl to make sure you're cc'ing
> the right people when posting patches.  You should repost so that Jeff
> has a copy of the patch to pick up (and add my acked-by when you do).
>
> On Wed, Dec 16, 2009 at 6:29 AM, Roman Fietze
> <roman.fietze@telemotive.de>  wrote:
>> Hello Everybody,
>>
>> A totally simple patch that reduces the text size as of the
>> ppc_6xx-size command of pata_mpc52xx by more than 10%, by reducing the
>> rodata size from 0x4a4 to 0x17e bytes. This is simply done by changing
>> the data types of the ATA timing constants.
>
> Acked-by: Grant Likely<grant.likely@secretlab>

I have the ACK, but never saw the requested repost...  req that, please?

