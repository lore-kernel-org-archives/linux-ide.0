From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/3] ahci-remap.h: add ahci remapping definitions
Date: Mon, 5 Dec 2016 16:31:32 +0100
Message-ID: <20161205153132.GC6340@lst.de>
References: <1480703463-17489-1-git-send-email-hch@lst.de> <1480703463-17489-3-git-send-email-hch@lst.de> <aa6cba2c-6cf7-0222-b871-d98d1c8e4fe8@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:47483 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751790AbcLEPcY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Mon, 5 Dec 2016 10:32:24 -0500
Content-Disposition: inline
In-Reply-To: <aa6cba2c-6cf7-0222-b871-d98d1c8e4fe8@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Christoph Hellwig <hch@lst.de>, tj@kernel.org, dan.j.williams@intel.com, linux-ide@vger.kernel.org, linux-nvme@lists.infradead.org

On Sat, Dec 03, 2016 at 01:57:01PM +0300, Sergei Shtylyov wrote:
>> +#ifndef _LINUX_AHCI_REMAP_H
>> +#define _LINUX_AHCI_REMAP_H
>> +
>> +#include <linux/sizes.h>
>> +
>> +#define AHCI_VSCAP		0xa4
>> +#define AHCI_REMAP_CAP		0x800
>> +#define AHCI_VSCAP		0xa4
>
>    Why do it twice?

No good reason, probably just me messing up the move..
