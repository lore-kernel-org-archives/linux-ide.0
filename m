From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 02/16] ata: Convert dev_printk(KERN_<LEVEL> to dev_<level>(
Date: Wed, 28 Nov 2012 12:42:58 -0500
Message-ID: <50B64D22.2010004@pobox.com>
References: <cover.1351411047.git.joe@perches.com> <ff89ae9b42c644728575a3cf606184ab9875d6e9.1351411047.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:48127 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754006Ab2K1RnB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Nov 2012 12:43:01 -0500
In-Reply-To: <ff89ae9b42c644728575a3cf606184ab9875d6e9.1351411047.git.joe@perches.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 10/28/2012 04:05 AM, Joe Perches wrote:
> dev_<level> calls take less code than dev_printk(KERN_<LEVEL>
> and reducing object size is good.
> Coalesce formats for easier grep.
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>   drivers/ata/pata_cmd64x.c |    6 +++---
>   1 files changed, 3 insertions(+), 3 deletions(-)

applied



