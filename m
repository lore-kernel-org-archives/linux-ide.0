From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: CONFIG_IDE_PROC_FS: /sys is not full replacement of /proc
Date: Thu, 26 Jul 2007 21:40:22 +0200
Message-ID: <200707262140.22276.bzolnier@gmail.com>
References: <200707180742.42651.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:63978 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936147AbXGZT7t (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Jul 2007 15:59:49 -0400
Received: by ug-out-1314.google.com with SMTP id j3so591345ugf
        for <linux-ide@vger.kernel.org>; Thu, 26 Jul 2007 12:59:48 -0700 (PDT)
In-Reply-To: <200707180742.42651.arvidjaar@mail.ru>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org


Hi,

On Wednesday 18 July 2007, Andrey Borzenkov wrote:
> May be I miss something obvious but most information that was available 
> in /proc/ide is missing under /sys. At the very least, Mandriva hardware 
> detection expects /proc/ide/hdX/model; nothing close is under /sys.

It is really better to obtain some information using IOCTLs (i.e. SMART
data) but for other like "model" it makes perfect sense to add them to /sys.

> Are there any plans to extend IDE /sys interface to provide full range of 
> information from /proc? Alternatively I appreciate description (or pointer to 
> thereof) how to get information that was available under /proc/ide 
> without /proc/ide :)

Could you please add the information that you find missing to the existing
infrastructure in ide.c (ide_dev_attrs[] table)?

Thanks,
Bart
