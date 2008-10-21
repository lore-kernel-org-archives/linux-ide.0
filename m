From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [git pull] IDE updates #4
Date: Tue, 21 Oct 2008 23:18:13 +0400
Message-ID: <48FE2AF5.2010603@ru.mvista.com>
References: <200810212100.52985.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:12498 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755553AbYJUTSc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Oct 2008 15:18:32 -0400
In-Reply-To: <200810212100.52985.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Remove needless/confusing subdirs from drivers/ide/.

    I dunno, they didn't confuse me...

> Linus, please pull from:

> master.kernel.org:/pub/scm/linux/kernel/git/bart/ide-2.6.git/

> to receive the following updates:

>  rename drivers/ide/{pci => }/generic.c (100%)

    Not even pci-generic.c?

> Bartlomiej Zolnierkiewicz (1):
>       ide: remove useless subdirs from drivers/ide/

    Argh, as if I had too little to do... now I'll have to modify my 
unsubmitted series. :-(

MBR, Sergei

