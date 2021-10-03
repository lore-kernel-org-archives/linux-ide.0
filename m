Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B25C433FE
	for <linux-ide@archiver.kernel.org>; Sun,  3 Oct 2021 11:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2689961AF0
	for <linux-ide@archiver.kernel.org>; Sun,  3 Oct 2021 11:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhJCLbL (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 3 Oct 2021 07:31:11 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:37723 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhJCLbI (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 3 Oct 2021 07:31:08 -0400
Received: from localhost ([217.85.124.89]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Ml3ym-1nDnf60Z8m-00lVtN; Sun, 03 Oct 2021 13:28:44 +0200
From:   =?UTF-8?q?Reimar=20D=C3=B6ffinger?= <Reimar.Doeffinger@gmx.de>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>, linux-ide@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, hch@infradead.org,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH v4] Fixes to DMA state check
Date:   Sun,  3 Oct 2021 15:28:45 +0200
Message-Id: <20211003132851.12574-1-Reimar.Doeffinger@gmx.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <11506f71-80ea-a40f-1d5a-50c8005fcc42@opensource.wdc.com>
References: <11506f71-80ea-a40f-1d5a-50c8005fcc42@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:thVHOPD9ZY8TJqgsy7OhznsUAAhUwzRgGAu+zBVaA2S4O8Vo76O
 Hlpid1KMAPP/Johl4wxaCb5BbRbFfBw1rbiDh7eH7t0eFM/OQaBxSkrQYslwJI0iTdx8lOf
 rgIKPqvhVnJLsmQChxf54J8W3jcdebjBm78PoSZDNNea7Nhrb8l6MbLF2EGYU+D4GxmEeyv
 2AjGCm1T2p4eu2TqdqOKw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WtN3xFk2YHE=:Emoz8+c9lZp4I5FbshKw6p
 OQTzjSJg+ZFmOpChqTLgynOY2TKZNDZwDYHvIRnviBqKdEio40PJw3YiQ6nv2hRGkGrZKyIZg
 Vj6zD0XfMZmuAKqAPhi6Vill401klcyWiG/uhtBInklDI0GDS5YAlZMLJp8qwRri6B58oC9Jh
 HoJxeJiWkUFcP8EUB3KvhoKjPdVpYCqCHal4FS9K4xD0gwJA9IN2ZePdGNj6Vjb1kaO4vLMpM
 B2/r3K8JcTLaiBuoM2XlPzgyuD8LrZAWOHxnJBxGpWqYZr+Bw5DiUCwDzMSSVXvd2b3ibcQKl
 8Y1A/oZutZvTXMBNHoNu6NRILyyQnaTwLNmkSEvwqO9bG83VM4hR2Vwubf4xoIbVtxjwcap8L
 2bGZbxWTFjei+1wycYKbNp8of3th+pwfD2Inc/+SwxBVPNCnzcZtZ0NTfqwwkre4rEUaGYC/d
 SGCodwu7c7XQn5hqx0Sif1Rv5Dbs7v6kHI4KGihyH+BRg3LQR/gO6wXNQHVlIXNRspzfEY+Pj
 dYRp9c8qcPIp+Ld+hWxuchwDpZgp0rvqtF+yCowKJSyl6u4qxmXg3DWhQyXY1/gNJ4nLViLvU
 uqKjNl8XVv3tVntRvhfkax7seYQwd7+r4XR7mDD9o1LmC8XOZwp1PZJXPRAgzeiAaCb5muuLk
 Dv8PUJJuMDMpuVPMXaa3Pr1XmfgO/OIdMAxq2Q8dQ6w7leVNXDLTHQB3jg9efOCbHaX8ebCmM
 4pttqQGzAdCy8waXBXOdYpUnhpoAXodOmJ5b2m/nSt3KfHjM0aMUWLkwzss=
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Patch series to add ata_dma_enabled calls instead of incorrectly
checking dev->dma_mode != 0.
Only the first patch is confirmed to have caused real issues
that it indeed fixes, rest based purely on code review.

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



