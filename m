From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 0/10] ide: flags query macros
Date: Mon, 16 Feb 2009 23:17:31 +0100
Message-ID: <200902162317.32188.bzolnier@gmail.com>
References: <1234699692-9452-1-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.188]:14256 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177AbZBPWQv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 16 Feb 2009 17:16:51 -0500
In-Reply-To: <1234699692-9452-1-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

On Sunday 15 February 2009, Borislav Petkov wrote:
> Hi,
> 
> this series adds the drive->atapi_flags and drive->dev_flags macro wrappers
> we discussed. The idea was to make the code more readable and this has

Fine...

> been my main concern when coming up with the macro naming, therefore
> some macro names appear a tad more descriptive than the flag itself.

...but this part destroys consistency in the process.

If you think that some flag names should be fixed please just fix them
(or just leave them alone -- I think that people invest far too much time
into fixing all these minor things while tend to fix themselves when the
big things are being fixed).

Also ide_drv_ is bad name for ->{dev,atapi}_flags (drv == "driver" for
most people not "drive") -- please make it either ide_dev_ or ide_dflag_.

Thanks,
Bart
