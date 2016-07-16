From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 1/3] libata: remove ata_is_nodata
Date: Sat, 16 Jul 2016 19:10:27 +0300
Message-ID: <e0ac8d8b-0d56-ef71-5d77-969798df5735@cogentembedded.com>
References: <1468675003-13701-1-git-send-email-hch@lst.de>
 <1468675003-13701-2-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:35314 "EHLO
	mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbcGPQKa (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Jul 2016 12:10:30 -0400
Received: by mail-lf0-f41.google.com with SMTP id f93so106641248lfi.2
        for <linux-ide@vger.kernel.org>; Sat, 16 Jul 2016 09:10:29 -0700 (PDT)
In-Reply-To: <1468675003-13701-2-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, tj@kernel.org
Cc: linux-ide@vger.kernel.org

On 7/16/2016 4:16 PM, Christoph Hellwig wrote:

> The only caller an just check for !ata_is_data instead.

    s/ca/can/?

> Signed-off-by: Christoph Hellwig <hch@lst.de>

[...]

MBR, Sergei

