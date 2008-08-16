From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Re: [PATCH 03/18] ide-cd: cdrom_decode_status: factor out block pc
	error handling code
Date: Sat, 16 Aug 2008 22:26:00 +0200
Message-ID: <20080816202600.GA13726@gollum.tnic>
References: <1213252870-20474-1-git-send-email-petkovbb@gmail.com> <1213252870-20474-4-git-send-email-petkovbb@gmail.com> <200806141929.21329.bzolnier@gmail.com> <20080815073413.GA9906@gollum.tnic>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:36304 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752547AbYHPUZ4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Aug 2008 16:25:56 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1252930fgg.17
        for <linux-ide@vger.kernel.org>; Sat, 16 Aug 2008 13:25:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080815073413.GA9906@gollum.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

[.. ]

> here's a first attempt at that. These are only RFC of nature, please take a look
> when there's time. They've been lightly tested but I'll do more later since this
> path is not hit that often and a special test case will be required.

Yep, this one has problems as I just noticed. Reworking... 
