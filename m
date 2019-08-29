Return-Path: <SRS0=7q5m=WZ=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96332C3A5A3
	for <linux-ide@archiver.kernel.org>; Thu, 29 Aug 2019 23:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D182173E
	for <linux-ide@archiver.kernel.org>; Thu, 29 Aug 2019 23:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="biWGoeyf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfH2XfM (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 29 Aug 2019 19:35:12 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43615 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfH2XfM (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 29 Aug 2019 19:35:12 -0400
Received: by mail-ot1-f65.google.com with SMTP id 90so1285842otg.10
        for <linux-ide@vger.kernel.org>; Thu, 29 Aug 2019 16:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w7I+vTCF8MoRhaFpK08T7rrw/DewwWxf4o+4A7aaGhM=;
        b=biWGoeyfg87WAVV9jfzPsO0CvuI+vFgmGePiq3Ubf5qve9suqY4yqgfZnPY8o8Q0iT
         ldqbICZnsF2Z0PcJJv2YH3XLpdVsolvfwJKa93jFo1FNW745Zj62Y68Db8HP69B8yI25
         FhG4qRqeJbCGxQ393M/TXty/F9pEEPrqLGEgDfA3uIL9CbNCSU0hB6KNTZrks1TU3TWB
         N+hF1FIw9xfqtVHhstS7aQVZ8LNPNoJxBZvklZrW/o0fwLvD6NMJO014nVOsKc6jM+1X
         7N27G0dsJ+Vqt3bcnxmg7RIHC0eUgH2lx8ZBSQmf49kc4EMM9HJShs4e9+O7yLgHbDhk
         vFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w7I+vTCF8MoRhaFpK08T7rrw/DewwWxf4o+4A7aaGhM=;
        b=na5TFXXswdKpx7MTnvmTsZctE2pO03ri6hGLyXtWK6rfIQtv6cTYTGM1M0wZWnNDKJ
         2HFwjL4v9WqGRIXAjNPqHrcXit4yIjV9qbCDBgritms++wpp3mh85WNfNXzl/OJ3aLGz
         TujUjh4kUGLScZ+RpXYpNq1a9yRG1djlpcaC/Gg5OW3vTpKTa+R+Q/Xsj+xPmarzZlat
         iic+uCuz0AcazufglXnlIF1UEcDcAheWNoWfLO5nS4w257pLZqvh9iVm6EW1SfkIgzdm
         2VE3diwW8xoBXCkIeaHOjGUc4b9GAn/l6IZM98gHB2lKomdXb0HltskeXf9HfMlIR87q
         jmYg==
X-Gm-Message-State: APjAAAX23NO/StdpM1OyVU4KA1vZN+KbxQBlHxq3mQ7Xf9MhJVhmjF9L
        dr2aVJqm7R45XCTEm3O17r2ggqa785ktmk6H7/IZFQ==
X-Google-Smtp-Source: APXvYqyCgFlGZVk6JvnxAvkATHGZWNhCzYn7EP5r7tl1z1c7LpgffQZCiIV9wIvV+Z/O+Cof0dtgknD1/eoqnT+gXWU=
X-Received: by 2002:a05:6830:1e05:: with SMTP id s5mr9416289otr.247.1567121711247;
 Thu, 29 Aug 2019 16:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <156712072444.1601704.7392596435870876837.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156712072444.1601704.7392596435870876837.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 29 Aug 2019 16:35:00 -0700
Message-ID: <CAPcyv4jGOy+WsdFrPfS9Pr9UiJHrogfdYqUcXxC0GxBsFefpWw@mail.gmail.com>
Subject: Re: [PATCH v2] libata/ahci: Drop PCS quirk for Denverton and beyond
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stephen Douthit <stephend@silicom-usa.com>,
        Christoph Hellwig <hch@infradead.org>,
        "IDE/ATA development list" <linux-ide@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Thu, Aug 29, 2019 at 4:33 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> The Linux ahci driver has historically implemented a configuration fixup
> for platforms / platform-firmware that fails to enable the ports prior
> to OS hand-off at boot. The fixup was originally implemented way back
> before ahci moved from drivers/scsi/ to drivers/ata/, and was updated in
> 2007 via commit 49f290903935 "ahci: update PCS programming". The quirk
> sets a port-enable bitmap in the PCS register at offset 0x92.
>
> This quirk could be applied generically up until the arrival of the
> Denverton (DNV) platform. The DNV AHCI controller architecture supports
> more than 6 ports and along with that the PCS register location and
> format were updated to allow for more possible ports in the bitmap. DNV
> AHCI expands the register to 32-bits and moves it to offset 0x94.
>
> As it stands there are no known problem reports with existing Linux
> trying to set bits at offset 0x92 which indicates that the quirk is not
> applicable. Likely it is not applicable on a wider range of platforms,
> but it is difficult to discern which platforms if any still depend on
> the quirk.
>
> Rather than try to fix the PCS quirk to consider the DNV register layout
> instead require explicit opt-in. The assumption is that the OS driver
> need not touch this register, and platforms can be added with a new
> boad_ahci_pcs7 board-id when / if problematic platforms are found in the
> future. The logic in ahci_intel_pcs_quirk() looks for all Intel AHCI
> instances with "legacy" board-ids and otherwise skips the quirk if the
> board was matched by class-code.
>
> Reported-by: Stephen Douthit <stephend@silicom-usa.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> Changes since v1 [1]:
> - Find a way to not duplicate a large portion of the ahci_pci_tbl[]
>   array (Stephen).
> - Add a definition for the PCS register offset rather than hard code
>   (Stephen)
>
> [1]: https://lore.kernel.org/r/a04c0ae7-ef4d-4275-de05-b74beaeef86c@silicom-usa.com/
>
>  drivers/ata/ahci.c |   70 ++++++++++++++++++++++++++++++++--------------------
>  drivers/ata/ahci.h |    2 +
>  2 files changed, 45 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index f7652baa6337..847e3796d505 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -65,6 +65,12 @@ enum board_ids {
>         board_ahci_sb700,       /* for SB700 and SB800 */
>         board_ahci_vt8251,
>
> +       /*
> +        * board IDs for Intel chipsets that support more than 6 ports
> +        * *and* end up needing the PCS quirk.
> +        */

Ugh, sorry, I just realized I did not opt Denverton out of this... v3
on the way.
