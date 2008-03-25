From: "Bjoern Olausson" <lkmlist@gmail.com>
Subject: Re: Burning CDs as user produces coasters (Plextor drive)
Date: Tue, 25 Mar 2008 02:46:21 +0100
Message-ID: <5501535d0803241846k69f68738mda1aa6d10f1baa49@mail.gmail.com>
References: <9d2cd630803241039m79c47754v6562404133a61274@mail.gmail.com>
	 <47E8142D.4040301@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.188]:64856 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754056AbYCYBqW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 24 Mar 2008 21:46:22 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1615390rvb.1
        for <linux-ide@vger.kernel.org>; Mon, 24 Mar 2008 18:46:21 -0700 (PDT)
In-Reply-To: <47E8142D.4040301@garzik.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Gregor Jasny <gjasny@googlemail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

On 3/24/08, Jeff Garzik <jeff@garzik.org> wrote:
> Gregor Jasny wrote:
>  > Hi,
>  >
>  > since some time burning ISO CD images as user fails.
>  > Wodim stops during OPC and the kernel prints some messages:
>  >
>  > scsi: unknown opcode 0xe9
>  > scsi: unknown opcode 0xed
>  > scsi: unknown opcode 0xf5
>  > scsi: unknown opcode 0xeb
>  >
>  > If I burn as root, everything works fine. The used CD writer is a
>  > "PLEXTOR  DVDR   PX-712A   1.09". I've seen in the wodim/cdrecord
>  > sources that plextor drives are handled different from other drives.
>  >
>  > Do you know what the above listed commands are for?
>  > Maybe they could be included in blk_verify_command?
>  > If your'e not sure about the dangerousness maybe as a config option?
>
>
> What drivers and kernel versions work (and which fail)?
>
>         Jeff
>
>

The PX-712A still doesn't work right? Maybe it is related to the bug:
http://bugzilla.kernel.org/show_bug.cgi?id=8918

Tejun has the dirve, but nothing new for now.
http://bugzilla.kernel.org/show_bug.cgi?id=8918

regards
Bjoern
