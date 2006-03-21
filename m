From: Denis Leroy <denis@poolshark.org>
Subject: Re: Some sata_mv error messages
Date: Tue, 21 Mar 2006 11:33:39 -0800
Message-ID: <44205513.8030109@poolshark.org>
References: <20060318044056.350a2931.akpm@osdl.org> <20060320133318.GB32762@favonius> <441F508E.1030008@pobox.com> <441F8599.7080703@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from customer-reverse-entry.64.151.106.180 ([64.151.106.180]:40658
	"EHLO charlie.albator.org") by vger.kernel.org with ESMTP
	id S932349AbWCUTdv (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Mar 2006 14:33:51 -0500
In-Reply-To: <441F8599.7080703@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, sander@humilis.net, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, lkml@rtr.ca

Mark Lord wrote:
> Jeff Garzik wrote:
>>
>> Without answering your specific question, just remember that sata_mv
>> is considerly "highly experimental" right now, and still needs some
>> workarounds for hardware errata.
>>
>> For now, the goal is a system that doesn't crash and doesn't corrupt
>> data.  If its occasionally slow or spits out a few errors, but
>> otherwise still works, that's pretty darned good :)
> 
> I'm currently working with the original authors of sata_mv, and have taken
> over maintenance of it for now.  It should progress from "highly
> experimental"
> to "production quality" over the next month or so.
> 
> The (mucho) updated driver I'm using here now is already much improved
> in many ways.  At some point, I'll break it out into patches for Jeff.
> 
> But there's one MAJOR bugfix patch that I'll release here shortly,
> to go with the interrupt handler fix already posted.

This is great news. Is there any relationship between the development of
this driver and the one maintained by Marvell that's available from
their web site ? Their latest version (3.6.1) is released under the GPL,
and is a very solid driver based our experience with it over the past
few years, though it's targeted at older versions of the linux kernel
and needs some porting to 2.6.16 (and contains redundant stuff like its
own scsi-ata layer).

Denis Leroy
