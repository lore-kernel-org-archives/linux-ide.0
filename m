From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/3] libata: remove ata_is_nodata
Date: Sun, 17 Jul 2016 03:26:07 +0200
Message-ID: <20160717012607.GA10263@lst.de>
References: <1468675003-13701-1-git-send-email-hch@lst.de> <1468675003-13701-2-git-send-email-hch@lst.de> <e0ac8d8b-0d56-ef71-5d77-969798df5735@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:44155 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751871AbcGQB0K (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 16 Jul 2016 21:26:10 -0400
Content-Disposition: inline
In-Reply-To: <e0ac8d8b-0d56-ef71-5d77-969798df5735@cogentembedded.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Christoph Hellwig <hch@lst.de>, tj@kernel.org, linux-ide@vger.kernel.org

On Sat, Jul 16, 2016 at 07:10:27PM +0300, Sergei Shtylyov wrote:
> On 7/16/2016 4:16 PM, Christoph Hellwig wrote:
>
>> The only caller an just check for !ata_is_data instead.
>
>    s/ca/can/?

Yes.
