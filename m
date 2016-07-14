From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 06/10] libata-eh: decode all taskfile protocols
Date: Thu, 14 Jul 2016 14:51:28 +0300
Message-ID: <7a548386-8ac6-24da-e158-affc6ad769c2@cogentembedded.com>
References: <1468454751-12466-1-git-send-email-hch@lst.de>
 <1468454751-12466-7-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:36419 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739AbcGNLva (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Jul 2016 07:51:30 -0400
Received: by mail-lf0-f50.google.com with SMTP id q132so61324297lfe.3
        for <linux-ide@vger.kernel.org>; Thu, 14 Jul 2016 04:51:30 -0700 (PDT)
In-Reply-To: <1468454751-12466-7-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, tj@kernel.org
Cc: hare@suse.com, damien.lemoal@hgst.com, linux-ide@vger.kernel.org, Hannes Reinecke <hare@suse.de>

Hello.

On 7/14/2016 3:05 AM, Christoph Hellwig wrote:

> From: Hannes Reinecke <hare@suse.de>
>
> Some taskfile protocol values where missing in ata_eh_link_report().

    Were -- perhaps Tejun could fix...

>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
[...]

MBR, Sergei

