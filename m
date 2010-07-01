From: Mark Lord <kernel@teksavvy.com>
Subject: Re: [PATCH 1/3] libata: glob_match for ata_device_blacklist
Date: Thu, 01 Jul 2010 11:34:39 -0400
Message-ID: <4C2CB58F.1020001@teksavvy.com>
References: <4C2CB497.3000701@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:26509 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752171Ab0GAPel (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Jul 2010 11:34:41 -0400
In-Reply-To: <4C2CB497.3000701@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: IDE/ATA development list <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>

On 01/07/10 11:30 AM, Mark Lord wrote:
>
> Replace rudimentry pattern matching with more capable shell-style globbing.
> This will enable shrinking ata_device_blacklist[] table in subsequent patches,
..

I am working on this, because a future device to be added (not ready yet)
to the blacklist table requires matching on only the end of the firmware string.
The old pattern matcher cannot handle that case, so..

In the meanwhile, this gives us decent memory savings,
and makes the list easier to maintain even for current entries.

Cheers

Mark
