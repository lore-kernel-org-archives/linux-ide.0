From: Frans Pop <elendil@planet.nl>
Subject: Re: [PATCH 0/4] partitions/ide: improve Host Protected Area handling
Date: Sun, 31 May 2009 22:04:11 +0200
Message-ID: <200905312204.12549.elendil@planet.nl>
References: <20090531143911.7164.26834.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cpsmtpm-eml104.kpnxchange.com ([195.121.3.8]:56969 "EHLO
	CPSMTPM-EML104.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752638AbZEaUEM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 31 May 2009 16:04:12 -0400
In-Reply-To: <20090531143911.7164.26834.sendpatchset@localhost.localdomain>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>, linux-kernel@vger.kernel.org, Robert Hancock <hancockrwd@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>

On Sunday 31 May 2009, Bartlomiej Zolnierkiewicz wrote:
> Since from the perspective of most users of recent systems, disabling
> Host Protected Area (HPA) can break vendor RAID formats, GPT partitions
> and risks corrupting firmware or overwriting vendor system recovery
> tools this patchset makes the IDE subsystem preserve HPA by default.

Kudos! I have to leave a real review of the patches to others more 
qualified than me, but where the previous patch set raised all sorts of 
questions for me, this just looks logical.

I conclude the following from reading the patches:
- a HPA is always at the end of a disk, correct?
- the only case where a user should notice a change after switching
  to 2.6.30 is if he has a partition that starts on or after the
  start of the HPA: such a partition will be ignored (with warning
  in dmesg); I guess that is reasonable as at least it will prevent
  "broken" partitions and is probably relatively uncommon.

Thanks for your continued work on this Bart.

Cheers,
FJP
