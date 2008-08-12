From: "Boris Petkov" <petkovbb@googlemail.com>
Subject: Re: [PATCH 11/22] ide: add ide_set_media_lock() helper
Date: Tue, 12 Aug 2008 15:37:37 +0200
Message-ID: <9ea470500808120637w354b3ae0w3ceca791344bd7cc@mail.gmail.com>
References: <20080810153527.16255.2504.sendpatchset@localhost.localdomain>
	 <20080810153645.16255.80542.sendpatchset@localhost.localdomain>
	 <20080811060232.GA15436@gollum.tnic>
	 <200808121105.49645.bzolnier@gmail.com>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:15035 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009AbYHLNhi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 12 Aug 2008 09:37:38 -0400
Received: by wf-out-1314.google.com with SMTP id 27so4827741wfd.4
        for <linux-ide@vger.kernel.org>; Tue, 12 Aug 2008 06:37:37 -0700 (PDT)
In-Reply-To: <200808121105.49645.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

>> Are we switching to SCSI opcodes? What about the generic packet commands in
>> <include/linux/cdrom.h>?
>
> I prefer to use them when possible but there is no strict policy.
>
> [ SCSI defines are shorter, one of the drivers was using them already
>  and it also makes easier for comparing code with SCSI. ]

I still think we should stick to one format or the other. All
the drivers' functions, for example, comply with a naming scheme
(ide_cd/ide_floppy/...) so opcodes shouldn't be an exception, imho...

-- 
Regards/Gruss,
Boris
