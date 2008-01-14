From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 11/12] ide-floppy: remove IDEFLOPPY_DEBUG_INFO
Date: Mon, 14 Jan 2008 22:51:36 +0100
Message-ID: <200801142251.36534.bzolnier@gmail.com>
References: <1200255505-31418-1-git-send-email-bbpetkov@yahoo.de> <1200255505-31418-11-git-send-email-bbpetkov@yahoo.de> <1200255505-31418-12-git-send-email-bbpetkov@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:2576 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898AbYANVoM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Jan 2008 16:44:12 -0500
Received: by ug-out-1314.google.com with SMTP id z38so900340ugc.16
        for <linux-ide@vger.kernel.org>; Mon, 14 Jan 2008 13:44:11 -0800 (PST)
In-Reply-To: <1200255505-31418-12-git-send-email-bbpetkov@yahoo.de>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sunday 13 January 2008, Borislav Petkov wrote:

[...]

> -		printk(KERN_ERR "ide-floppy: Packet size is not 12 bytes long\n");
> +		printk(KERN_ERR "ide-floppy: Packet size is not 12 bytes "
> +				"long\n");

I added dumping 'gcw.packet_size' for unsupported packet sizes while
merging the patch.
