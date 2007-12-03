From: "saeed bishara" <saeed.bishara@gmail.com>
Subject: Re: [PATCH 2/2] [libata] sata_mv: Support integrated controllers
Date: Mon, 3 Dec 2007 09:46:48 +0200
Message-ID: <c70ff3ad0712022346k44ec6303s3cecff9ec7e7d549@mail.gmail.com>
References: <11966092121262-git-send-email-saeed.bishara@gmail.com>
	 <11966092143056-git-send-email-saeed.bishara@gmail.com>
	 <11966092162669-git-send-email-saeed.bishara@gmail.com>
	 <475336EA.2050206@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:13447 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752697AbXLCHqv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Dec 2007 02:46:51 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4933158wah
        for <linux-ide@vger.kernel.org>; Sun, 02 Dec 2007 23:46:50 -0800 (PST)
In-Reply-To: <475336EA.2050206@rtr.ca>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: linux-ide@vger.kernel.org, nico@cam.org, buytenh@wantstofly.org, Saeed Bishara <saeed@marvell.com>

>
> This patch won't apply, because sata_mv.c was just recently updated
> to fix 7042 PCIe support.  You'll have to rebase this patch against that.
ok. I'll check that.
>
> Also, I'm not sure I understand why there's a need for the new sata_mv.h file ?
This file contains the definition of the data structure that passed by
board setup code to the sata driver. so this data structure must be
defined in header file. for this specific case where the information
made up of only one integer, you can avoid the structure definition
and the new file creation, but, the this will make the code less
readable, and I know that this information will be extended in the
future.
>
