From: Mark Lord <kernel@teksavvy.com>
Subject: Re: Marvel PMP SATA controller
Date: Fri, 01 Oct 2010 09:46:25 -0400
Message-ID: <4CA5E631.2030903@teksavvy.com>
References: <4CA2E33B.70001@gmail.com> <4CA399FD.6030904@teksavvy.com> <4CA3A27B.3030906@gmail.com> <4CA4932D.6040501@teksavvy.com> <4CA498B5.6090503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.183]:47244 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756683Ab0JANq2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 1 Oct 2010 09:46:28 -0400
In-Reply-To: <4CA498B5.6090503@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard <tuxbox.guru@gmail.com>
Cc: linux-ide@vger.kernel.org

On 10-09-30 10:03 AM, Richard wrote:
> On 30/09/10 14:39, Mark Lord wrote:
..
>> Does the existing libata parameter take care of it for you?
>>
>> linux/Documentation/kernel-parameters.txt:
>> eg. libata.force=[ID:]1.5" ## replace [ID:] with port[.device] for the PMP and/or HD
>>
> Unfortunately not.. which is why I asked how to write commands directly on to the SATA bus from kernel space.


Right.  Well, just keep plunking away at it in that ancient kernel, then.
The two modern routines to study/backport are sata_pmp_read() and sata_pmp_write(),
which are used by most controllers to perform PMP register accesses.

However, the host controller may require additional tweaks,
especially if it is a Marvell host controller (sata_mv),
or something that doesn't normally "do" PMP, like ata_piix.

Cheers
