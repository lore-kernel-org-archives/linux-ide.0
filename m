From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 09/10] libata-scsi: Fix ZBC management out command
 translation
Date: Thu, 14 Jul 2016 14:54:43 +0300
Message-ID: <16f8c110-070b-74fd-6768-c01dde942254@cogentembedded.com>
References: <1468454751-12466-1-git-send-email-hch@lst.de>
 <1468454751-12466-10-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:36027 "EHLO
	mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbcGNLyq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Jul 2016 07:54:46 -0400
Received: by mail-lf0-f53.google.com with SMTP id q132so61397789lfe.3
        for <linux-ide@vger.kernel.org>; Thu, 14 Jul 2016 04:54:45 -0700 (PDT)
In-Reply-To: <1468454751-12466-10-git-send-email-hch@lst.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, tj@kernel.org
Cc: hare@suse.com, damien.lemoal@hgst.com, linux-ide@vger.kernel.org

On 7/14/2016 3:05 AM, Christoph Hellwig wrote:

> From: Damien Le Moal <damien.lemoal@hgst.com>
>
> The subcommand for NCQ NON-DATA must be specified in the feature
> (low byte), not the high-order count byte.  Also make sure to properly
> cast the all bit to a u16 before shiting it by 8 to avoid undefined

    Shifting. :-)

> behavior.
>
> Signed-off-by: Damien Le Moal <damien.lemoal@hgst.com>
> [hch: split the original patch into two, updated changelog]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
[...]

MBR, Sergei

