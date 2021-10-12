Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B70C4332F
	for <linux-ide@archiver.kernel.org>; Tue, 12 Oct 2021 06:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D495C60C4D
	for <linux-ide@archiver.kernel.org>; Tue, 12 Oct 2021 06:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbhJLGap (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 12 Oct 2021 02:30:45 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:39713 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbhJLGak (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 12 Oct 2021 02:30:40 -0400
Received: from localhost ([98.128.181.94]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M277h-1mc68z33Gr-002WZw; Tue, 12 Oct 2021 08:28:12 +0200
From:   =?UTF-8?q?Reimar=20D=C3=B6ffinger?= <Reimar.Doeffinger@gmx.de>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>, linux-ide@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, hch@infradead.org,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH v5] Fixes to DMA state check
Date:   Tue, 12 Oct 2021 08:27:43 +0200
Message-Id: <20211012062749.4728-1-Reimar.Doeffinger@gmx.de>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:iKGpCQlpRsEaqlgxYVwv552X81G8hCzIeJn2OwqwVV6A0iAvjYJ
 xb7AalfgWoAhUPq37XS/Vr7qfE/5CPYAmg+yHjelIDaj0gV7WUYR0Pu/Zf3RopnQHUTn4Eu
 KYneH3LWgN40+ytul2jyHMIcpe2ZYpaQmDb3A+ETdrDfI2uyHrPafTnohIPWRvPJbJhe3u6
 XdH9T97qDkJ2Ma3Ny03GQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:13SVl8reyVI=:nCvpv0gMbiy3aUogXQa9dt
 szIR6WcnX/qu8hWqmPMSVkS4BUJJSCcZ7j1zSxR/70hoZMWOghqWGj6f3W/oADnwiqiEcHyAx
 KBCZ72dszFR3IsmDTGl6y039NIZLL2/NHugGFpU6GyRT6GaJIPf0aOhVamBaRFms0sqHFw+Ch
 k0IG3aiRRPr6xzeJ7OyBngfPpeM3q3IAgvKK2TYjH5JR5BSgRQvJEgohG5+J2OWgi8PMdddKe
 98Gx6KhHjNLnz0tFD9tZwpYfKUyQ6IRAkPSAYSe3YNb7Z0fUupwo8dqnsh2jDw6DokTshMM+y
 r+xyN8Rq8DdrzptTi87EfZmNHpKKnWfrmTll29xKHHDFs7J+Z7vl3JC6we0Iw2P+rN4PkDf4X
 gtqeTL8YbVof/wSlP20W8f3B/JhGnMr+Wgb8L5yCY8ShTZZtdjuDVgDrfkKuglSc+tERxXcfz
 auTZRXyJcgQID/ca939sSzjB94DQs/RLjWa5ryeS61c7yL0prZVNqc2fneQByRguD4u+o4C9W
 5CoQMv1h/KGiOoLWQOB6RJZ9JQLP9hN11zFzLdqpRPOc4eT5E6NuLrCZrB6/TpIvX2TsF+NMr
 nSgHUDRlpSZOrGTGEUcs74hzcHuQ9lj2+VPTirh8mRdPFstJ6R29RJeE7h9xu+PxCsplcVK0+
 CC857xqaltUDGqaMTltPcm+eXh87C3G3gfsNvWxpaOxSBnv3cWTm4TlzBZUWkAwCtp99KmcRJ
 jc1m3IhLYpazfrQUXTSYBz1Cq6dp+g0K3BsO/YGIZY4Wbr3UVeYF2VXyNsk=
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Patch series to add ata_dma_enabled calls instead of incorrectly
checking dev->dma_mode != 0.
Only the first patch is confirmed to have caused real issues
that it indeed fixes, rest based purely on code review.

Changes v5:
Add stable Cc to first patch, which is confirmed to fix
issues seen by users.

Changes v4:
- split per file/driver
- added Signed-off-by and Tested-by lines, improved commit messages
Changes v3:
- found and updated more cases in pata_ali, pata_amd and pata_radisys.
Changes v2:
- removed initialization change for SATA. I got confused by the
  ping-pong between libata-eh and libata-core and thought SATA did not
  set up xfermode
- reviewed other cases that used dma_mode in boolean context and those
  seemed to need changing as well, so added them to patch.
  I did not see any places that would set dma_mode to 0 ever, so I
  do think they were all indeed wrong.


