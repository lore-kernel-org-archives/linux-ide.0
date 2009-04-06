From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/6] ide: move common code out of tf_load() method
Date: Mon, 6 Apr 2009 23:14:23 +0200
Message-ID: <200904062314.23903.bzolnier@gmail.com>
References: <200904022301.14906.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:42401 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758945AbZDFVLs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Apr 2009 17:11:48 -0400
Received: by fg-out-1718.google.com with SMTP id e12so851171fga.17
        for <linux-ide@vger.kernel.org>; Mon, 06 Apr 2009 14:11:47 -0700 (PDT)
In-Reply-To: <200904022301.14906.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Thursday 02 April 2009, Sergei Shtylyov wrote:
> Move device register masking (and setting drive->select) out of tf_load() method
> and into the only function that needs to use this code, do_rw_taskfile()...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

fixed while merging:

ERROR: code indent should use tabs where possible
#62: FILE: drivers/ide/ide-taskfile.c:93:
+^I^I ^Iu8 HIHI = (cmd->tf_flags & IDE_TFLAG_LBA48) ?$
