From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 09/13] sata_mv ncq Use DMA memory pools for hardware memory
 tables
Date: Thu, 31 Jan 2008 12:31:14 +0900
Message-ID: <47A14102.9080605@gmail.com>
References: <479BC217.60709@rtr.ca> <479BC31D.1050206@rtr.ca> <479F5E1F.8030508@pobox.com> <479F6F40.7040401@rtr.ca> <47A04954.7010306@pobox.com> <47A0A875.1070203@rtr.ca> <47A0AF1F.1070609@pobox.com> <47A0B18C.1060300@rtr.ca> <47A0B7B4.9080502@pobox.com> <47A0C8AB.9050505@rtr.ca> <47A13F28.7050001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from po-out-1718.google.com ([72.14.252.152]:21318 "EHLO
	po-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753411AbYAaDbV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 Jan 2008 22:31:21 -0500
Received: by po-out-1718.google.com with SMTP id c31so848062poi.1
        for <linux-ide@vger.kernel.org>; Wed, 30 Jan 2008 19:31:20 -0800 (PST)
In-Reply-To: <47A13F28.7050001@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Tejun Heo wrote:
> I'm skeptical about the benefit of IRQ coalescing on storage
> controllers.  Coalescing improves performance when there are many small
> requests to complete and if you put a lot of small non-consecutive
> requests to a disk, it gets really really really slow and IRQ coalescing
> just doesn't matter at all.  The only way to achieve high number of
> completions is to issue small commands to consecutive addresses which is
> just silly.  In storage, high volume transfer is achieved through
> request coalescing not completion coalescing and this is true for even SDDs.

To add a bit, I was thinking about writes regarding SDDs.  Completion
coalescing makes more sense for reads from SDDs if log based filesystem
is used on it because then read operations are scattered all over the
disk and the device doesn't have to seek.  Limited queue size compared
to network interfaces will make completion coalescing less effective but
yeah, I think it will be worth playing with it on SDD + lfs.

Thanks.

-- 
tejun
