From: Grant Grundler <grundler@google.com>
Subject: Re: [git patches] libata fixes
Date: Fri, 16 Jan 2009 10:49:19 -0800
Message-ID: <da824cf30901161049n35ae8723ieb5e2fd7fbbdf739@mail.gmail.com>
References: <20090116152721.GA6994@havoc.gtf.org>
	 <20090116093101.6d77b69b.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:45960 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937078AbZAPStY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Jan 2009 13:49:24 -0500
In-Reply-To: <20090116093101.6d77b69b.akpm@linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jeff Garzik <jeff@garzik.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Fri, Jan 16, 2009 at 9:31 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
...
>> +static void octeon_cf_tf_read16(struct ata_port *ap, struct ata_taskfile *tf)
>> +{
>> +     u16 blob;
>> +     /* The base of the registers is at ioaddr.data_addr. */
>> +     void __iomem *base = ap->ioaddr.data_addr;
>> +
>> +     blob = __raw_readw(base + 0xc);
>
> why __raw?

Avoid byte swapping. If it's "native" HW on Big Endian platform,
byte swapping isn't needed. If it's working, it's correct.

hth,
grant
