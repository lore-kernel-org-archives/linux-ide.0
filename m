From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Sata_promise.c queries
Date: Wed, 9 Feb 2005 22:26:03 +0100
Message-ID: <58cb370e05020913264177867e@mail.gmail.com>
References: <8142CBF3-7AB2-11D9-A80A-000A95D2AC6A@iomega.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received: from wproxy.gmail.com ([64.233.184.199]:1681 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261933AbVBIV0E (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Feb 2005 16:26:04 -0500
Received: by wproxy.gmail.com with SMTP id 67so1370707wri
        for <linux-ide@vger.kernel.org>; Wed, 09 Feb 2005 13:26:04 -0800 (PST)
In-Reply-To: <8142CBF3-7AB2-11D9-A80A-000A95D2AC6A@iomega.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gary Poppitz <poppitzg@iomega.com>
Cc: linux-ide@vger.kernel.org

On Wed, 9 Feb 2005 08:51:47 -0700, Gary Poppitz <poppitzg@iomega.com> wrote:
> First off, I have the libdata-2.6 pull.
> 
> The version of sata_promise.c is 1.58 .
> 
> Is this the latest one available?
> 
> Next question, in function pdc_qc_issue_prot, there is a BUG() call in
> the case of
> ATA_PROT_ATAPI_DMA.

It seems like ATAPI support is not implemented in sata_promise.c yet.
 
> Is this one of those "fixme"s that will be addressed Real Soon Now, or
> is this an actual error that I am hitting. Naturally, the device I am
> using wants to do ATAPI DMA.

It is rather one of these "fix it yourself". ;)
 
Bartlomiej
