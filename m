From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] libata-zpodd: must use ata_tf_init()
Date: Wed, 26 Jun 2013 15:10:14 +0400
Message-ID: <51CACC16.9050005@cogentembedded.com>
References: <201306232325.04732.sergei.shtylyov@cogentembedded.com> <51CA4C74.50400@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:57884 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027Ab3FZLKP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Jun 2013 07:10:15 -0400
Received: by mail-lb0-f179.google.com with SMTP id w20so1376630lbh.24
        for <linux-ide@vger.kernel.org>; Wed, 26 Jun 2013 04:10:14 -0700 (PDT)
In-Reply-To: <51CA4C74.50400@intel.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: linux-ide@vger.kernel.org, tj@kernel.org

Hello.

On 26-06-2013 6:05, Aaron Lu wrote:

>> There are  some SATA controllers which have both devices 0 and 1 but this module

> Do you mean a SATA port can connect to two SATA devices without PMP?

    No, I mean 2 SATA ports combined in one ATA channel as 2 devices. 
Look for SLAVE_POSS in drivers/ata/[s]ata*.c...

> Thanks,
> Aaron

MBR, Sergei


