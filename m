From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/2] hpt366: fix PCI clock detection for HPT374
Date: Wed, 8 Aug 2007 23:10:00 +0200
Message-ID: <200708082310.01017.bzolnier@gmail.com>
References: <200708060006.35511.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.189]:56851 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762374AbXHHW6D (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Aug 2007 18:58:03 -0400
Received: by mu-out-0910.google.com with SMTP id i10so406849mue
        for <linux-ide@vger.kernel.org>; Wed, 08 Aug 2007 15:58:01 -0700 (PDT)
In-Reply-To: <200708060006.35511.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: rah@bash.sh, linux-ide@vger.kernel.org

On Sunday 05 August 2007, Sergei Shtylyov wrote:
> HPT374 BIOS seems to only save f_CNT register value for the function #0 before
> re-tuning DPLL causing the driver to report obviously distorted f_CNT for the
> function #1 -- fix this by always reading the saved f_CNT register value from
> in the init_chipset() method the function #0 of HPT374 chip.
> While at it, introduce 'chip_type' for the copy of the 'struct hpt_info' member
> and replace the structure assignment by memcpy()...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied but the issue raised by Alan needs addressing
