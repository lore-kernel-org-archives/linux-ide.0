From: Mark Lord <mlord@pobox.com>
Subject: Re: SATA hdd refuses to reallocate a sector?
Date: Mon, 24 Jun 2013 08:18:15 -0400
Message-ID: <51C83907.2020202@pobox.com>
References: <20130623101940.GA4448@amd.pavel.ucw.cz> <51C76858.4060906@pobox.com> <20130623215100.GA7414@amd.pavel.ucw.cz> <201306240914.29502.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43607 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426Ab3FXMSe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Jun 2013 08:18:34 -0400
In-Reply-To: <201306240914.29502.linux@rainbow-software.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Pavel Machek <pavel@ucw.cz>, Marcus Overhagen <marcus.overhagen@gmail.com>, kernel list <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, tj@kernel.org

On 13-06-24 03:14 AM, Ondrej Zary wrote:
..
> Being tired of using hdparm manually, I created a simple hdd_realloc utility
> that reads the disk in big blocks (1 MB). When there's a read error, it reads
> the failed block sector-by-sector and tries to rewrite the sectors that fail
> to read. It work fine for disks with just a couple of pending sectors.

Something like that would work very well if it used the hdparm approach
(directly to the drive) for the sector-by-sector part.

Going through the block layer isn't always going to work,
because the kernel likes to do I/O in PAGE_SIZE multiples.

And the SCSI stack in Linux has rather atrocious error handling.
It lumps multiple requests together, and can fail the entire lot even
if only a single sector is bad.

Cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com
