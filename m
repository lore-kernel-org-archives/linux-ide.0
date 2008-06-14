From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 03/18] ide-cd: cdrom_decode_status: factor out block pc error handling code
Date: Sat, 14 Jun 2008 19:29:21 +0200
Message-ID: <200806141929.21329.bzolnier@gmail.com>
References: <1213252870-20474-1-git-send-email-petkovbb@gmail.com> <1213252870-20474-4-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:10415 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754029AbYFNRrP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Jun 2008 13:47:15 -0400
Received: by fg-out-1718.google.com with SMTP id 19so3007218fgg.17
        for <linux-ide@vger.kernel.org>; Sat, 14 Jun 2008 10:47:14 -0700 (PDT)
In-Reply-To: <1213252870-20474-4-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

On Thursday 12 June 2008, Borislav Petkov wrote:
> ... into cdrom_handle_failed_pc_req().

I actually think that we should try to unite pc/fs error handling as much
as possible as it shouldn't really matter if i.e. READ command came through
fs or pc request - the error handling w.r.t. hardware should be the same
(at the moment it is not always the case - the most blatant example of this
disrepancy is handling of NOT_READY sense key for WRITE commands).

When I was suggesting factoring out error handling I rather meant moving
out _everything_ after OK_STAT() (sorry for the confusion).  On the second
thought we may do it in even simpler way by moving:

...
	/* check for errors */
	stat = ide_read_status(drive);

	if (stat_ret)
		*stat_ret = stat;

	if (OK_STAT(stat, good_stat, BAD_R_STAT))
		return 0;
...

to cdrom_decode_status() users and passing as an argument 'stat' instead
of 'good_stat' and 'stat_ret'.

Therefore I skipped this patch (and also patch #4) for now.
