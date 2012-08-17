From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: whitelist entry for device with known good pata-sata bridge
Date: Fri, 17 Aug 2012 13:39:08 -0400
Message-ID: <502E81BC.2020900@pobox.com>
References: <5010077C.5050509@eitelwein.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:63284 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758624Ab2HQRjM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Aug 2012 13:39:12 -0400
Received: by yenl14 with SMTP id l14so4224995yen.19
        for <linux-ide@vger.kernel.org>; Fri, 17 Aug 2012 10:39:12 -0700 (PDT)
In-Reply-To: <5010077C.5050509@eitelwein.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Michael Eitelwein <michael@eitelwein.net>
Cc: linux-ide@vger.kernel.org

On 07/25/2012 10:49 AM, Michael Eitelwein wrote:
> I have an external SATA drive that was slowed down by bridge limits. I
> found a solution in a thread on this list posted in 2008: It introduces
> whitelist entries in libata-core.c for devices with well working bridges
> (e.g. email on Fri, 31 Oct 2008 01:45:27 -0400).
>
> I added my device to this whitelist in a custom built kernel and it
> works fine for weeks now. How can I have this device added on the
> whitelist within the official kernel? Is this whitelist mechanism still
> supported or is there a smarter way to achieve whitelisting?
>
> I added the following whitelist entry for my Buffalo DriveStation
> Quattro "BUFFALO HD-QSU2/R5":
>
>          /* Devices that do not need bridging limits applied */
>          { "MTRON MSP-SATA*",            NULL,   ATA_HORKAGE_BRIDGE_OK, },
>          { "BUFFALO HD-QSU2/R5",         NULL,   ATA_HORKAGE_BRIDGE_OK, },

added to quirk list


