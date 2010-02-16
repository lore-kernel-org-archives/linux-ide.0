From: Tejun Heo <htejun@gmail.com>
Subject: Re: [patch 1/1] Delay on vt6420 when starting ATAPI DMA write
Date: Tue, 16 Feb 2010 17:34:27 +0900
Message-ID: <4B7A5893.9010809@gmail.com>
References: <20100214120449.503204189@gmail.com> <20100214120819.947320201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-px0-f191.google.com ([209.85.216.191]:35771 "EHLO
	mail-px0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246Ab0BPI0Q (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Feb 2010 03:26:16 -0500
In-Reply-To: <20100214120819.947320201@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bart Hartgers <bart.hartgers@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 02/14/2010 09:04 PM, Bart Hartgers wrote:
> When writing a disc on certain lite-on dvd-writers (also rebadged 
> as optiarc/LG/...) connected to a vt6420, the ATAPI CDB ends
> up in the datastream and on the disc, causing silent corruption. 
> Delaying between sending the CDB and starting DMA seems to 
> prevent this.
> 
> I do not know if there are burners that do not suffer from
> this, but the patch should be safe for those as well.
> 
> There are many reports of this issue, but AFAICT no solution was 
> found before. For example:
> http://lkml.indiana.edu/hypermail/linux/kernel/0802.3/0561.html
> 
> Signed-off-by: Bart Hartgers <bart.hartgers@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks!

-- 
tejun
