From: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>
Subject: Re: [PATCH 1/2] ide: use generic ATAPI packet command flags in ide-{floppy,tape,scsi}
Date: Wed, 13 Feb 2008 17:35:34 +0100
Message-ID: <58cb370e0802130835p242386fcj815649c9c33f43f4@mail.gmail.com>
References: <1202919531-17798-1-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.185]:33997 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933266AbYBMQfg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Feb 2008 11:35:36 -0500
Received: by fk-out-0910.google.com with SMTP id z23so69559fkz.5
        for <linux-ide@vger.kernel.org>; Wed, 13 Feb 2008 08:35:35 -0800 (PST)
In-Reply-To: <1202919531-17798-1-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

On Feb 13, 2008 5:18 PM, Borislav Petkov <petkovbb@googlemail.com> wrote:
> This is done in one single patch in order not to cause git breakage.
>
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

Looks good but could you please reorder patches and move PC_* -> PC_FLAG *
rename in ide-scsi to the patch removing atomic bitops from ide-scsi?

Thanks,
Bart
