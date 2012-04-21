From: cwillu <cwillu@cwillu.com>
Subject: Re: SSD slowdown with 3.3.X?
Date: Sat, 21 Apr 2012 05:45:58 -0600
Message-ID: <CAE5mzvhsBq5nh=A6sMnzBKust8nLgDYg8tB7aykXxGV5CRV8fA@mail.gmail.com>
References: <4F8F7533.6020300@gmail.com>
	<4F8F82EC.1060708@teksavvy.com>
	<4F90C4CF.1010000@gmail.com>
	<4F921E18.6000301@teksavvy.com>
	<4F921ECF.2080303@teksavvy.com>
	<4F922F43.4050809@hardwarefreak.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:57479 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628Ab2DULp6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 21 Apr 2012 07:45:58 -0400
Received: by yenl12 with SMTP id l12so5594867yen.19
        for <linux-ide@vger.kernel.org>; Sat, 21 Apr 2012 04:45:58 -0700 (PDT)
In-Reply-To: <4F922F43.4050809@hardwarefreak.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: stan@hardwarefreak.com
Cc: Mark Lord <kernel@teksavvy.com>, Joe Ceklosky <jfceklosky@gmail.com>, "linux-ide@vger.kernel.org >> IDE/ATA development list" <linux-ide@vger.kernel.org>

> Probably not relevant in this case but maybe worth mentioning to get the
> word out:
>
> "As of kernel 3.2.12, the default i/o scheduler, CFQ, will defeat much
> of the parallelization in XFS."
>
> http://www.xfs.org/index.php/XFS_FAQ

Not that it's terribly relevant to btrfs, but do you have a better
citation for that than a very recent one-line wiki change that only
cites the user's own anecdote?
