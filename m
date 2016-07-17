From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 1/3] libata: remove ata_is_nodata
Date: Sun, 17 Jul 2016 14:21:37 +0300
Message-ID: <bc51a9a9-1825-b324-e81e-e28f74d80bd5@cogentembedded.com>
References: <1468675003-13701-1-git-send-email-hch@lst.de>
 <1468675003-13701-2-git-send-email-hch@lst.de>
 <e0ac8d8b-0d56-ef71-5d77-969798df5735@cogentembedded.com>
 <20160717012607.GA10263@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:36041 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865AbcGQLVk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 Jul 2016 07:21:40 -0400
Received: by mail-lf0-f43.google.com with SMTP id g62so4617109lfe.3
        for <linux-ide@vger.kernel.org>; Sun, 17 Jul 2016 04:21:39 -0700 (PDT)
In-Reply-To: <20160717012607.GA10263@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: tj@kernel.org, linux-ide@vger.kernel.org

On 7/17/2016 4:26 AM, Christoph Hellwig wrote:

>>> The only caller an just check for !ata_is_data instead.
>>
>>    s/ca/can/?
>
> Yes.

     Sorry, I meant s/an/can/. :-)

MBR, Sergei

