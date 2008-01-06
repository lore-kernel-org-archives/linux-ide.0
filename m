From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [RFC PATCH] ide-floppy: remove struct idefloppy_capabilities_page
Date: Sun, 6 Jan 2008 17:18:58 +0100
Message-ID: <200801061718.58903.bzolnier@gmail.com>
References: <20080106094614.GA25272@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:42024 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755505AbYAFQMF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 6 Jan 2008 11:12:05 -0500
Received: by ug-out-1314.google.com with SMTP id z38so3032835ugc.16
        for <linux-ide@vger.kernel.org>; Sun, 06 Jan 2008 08:12:04 -0800 (PST)
In-Reply-To: <20080106094614.GA25272@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bbpetkov@yahoo.de
Cc: linux-ide@vger.kernel.org

On Sunday 06 January 2008, Borislav Petkov wrote:
> Hi Bart,
> 
> before removing all those typedefs in ide-floppy i wanted to check with you whether what
> i have in mind is in the right direction before doing all the work for nothing.
> Here's the first patch removing struct idefloppy_capabilities_page. Please, tell
> me whether it is similar to what you guys have in mind or is it missing the
> point.
> 
> Thanks.

You are 100% on the right track. :)

> From 41c791f40e3fcf2287aa245f25796fa58bb17afc Mon Sep 17 00:00:00 2001
> From: Borislav Petkov <bbpetkov@yahoo.de>
> Date: Sun, 6 Jan 2008 10:37:47 +0100
> Subject: [PATCH] ide-floppy: remove struct idefloppy_capabilities_page
> 
> This change is rather temporary and is in preparation of using generic commands
> as is the case with ide-cd and the uniform cdrom layer (i.e. init_cdrom_command())
> However, before this happens, we'll have to remove all typedefs and teach
> idefloppy_create_mode_sense_cmd() to work directly on u8 buffers.
> 
> Also, since idefloppy_get_capability_page() was used to read only the sfrp bit,
> rename the latter so that the name reflects what it does.
> 
> Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>

applied
