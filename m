From: "Alexander Beregalov" <a.beregalov@gmail.com>
Subject: 2.6.27-rc1 (2fca5c): libata: kernel cant boot
Date: Fri, 24 Oct 2008 11:04:21 +0400
Message-ID: <a4423d670810240004t2d7c3bdah2bea77a6a49bb7c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.251]:31110 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483AbYJXHEW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Oct 2008 03:04:22 -0400
Received: by an-out-0708.google.com with SMTP id d40so80850and.103
        for <linux-ide@vger.kernel.org>; Fri, 24 Oct 2008 00:04:21 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jens.axboe@oracle.com, tj@kernel.org, torvalds@linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Hi

commit 2fca5ccf97d2c28bcfce44f5b07d85e74e3cd18e
Author: Jens Axboe <jens.axboe@oracle.com>
Date:   Wed Oct 22 09:34:49 2008 +0200

    libata: switch to using block layer tagging support


This kernel can not read even 0 sector on disk with rootfs. It
initialized disk, but cant read it at all.
 CMD646 on Sparc

Rverting helped.
