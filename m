From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 06/21] ide-floppy: remove struct idefloppy_flexible_disk_page
Date: Sat, 12 Jan 2008 21:15:29 +0100
Message-ID: <200801122115.29227.bzolnier@gmail.com>
References: <1200052699-28420-1-git-send-email-bbpetkov@yahoo.de> <1200052699-28420-7-git-send-email-bbpetkov@yahoo.de> <200801120158.57895.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:21288 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758060AbYALUUB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Jan 2008 15:20:01 -0500
Received: by ug-out-1314.google.com with SMTP id z38so640515ugc.16
        for <linux-ide@vger.kernel.org>; Sat, 12 Jan 2008 12:20:00 -0800 (PST)
In-Reply-To: <200801120158.57895.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <bbpetkov@yahoo.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Saturday 12 January 2008, Bartlomiej Zolnierkiewicz wrote:

[...]

> > -	header = (idefloppy_mode_parameter_header_t *) pc.buffer;
> > -	floppy->wp = header->wp;
> > +	floppy->wp = pc.buffer[3] & 0x80;
> 
> This is not an equivalent transformation:
> 
> header->wp is 0 or 1
> pc.buffer[3] & 0x80 is 0 or 0x80
> 
> It seems to work fine for ->wp (because it is needlessly defined as 'int')
> but may seriously confuse set_disk_ro() and thus bdev_read_only() users.
> 
> Should be fixed to '(pc.buffer[3] & 0x80) ? 1 : 0' (or something similar).

Update: this change belongs to patch #10 (+ the need for such change in
patch #6 is a hint that #10 should be before #6)
