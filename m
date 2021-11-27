Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C07C433EF
	for <linux-ide@archiver.kernel.org>; Sat, 27 Nov 2021 10:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353721AbhK0Kj3 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sat, 27 Nov 2021 05:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242286AbhK0Kh3 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sat, 27 Nov 2021 05:37:29 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C49C061574;
        Sat, 27 Nov 2021 02:34:15 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id az37so23395995uab.13;
        Sat, 27 Nov 2021 02:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rOJTrm7pvpXG8OPQj4tl03mE+3NVVMlvWgKC+FZ17/8=;
        b=D/fwNt1EEd23XsSwKpFanuS8OuvISpqfC9ickWo11XMIdp8ByltQeLW76AWMiUg5uW
         J4rF2QGlhKCR+u5xF2t7FP5Ewr+ssTzrJgvcx33c8Ueb7IQ5lL2W4RFepRb4mnGWGfgj
         Yt2gW3Sji1psOt4oG7ZwmZpSYG1whNCFbzd9JucaiHrB1z/I+CgYUMdnnHppQimnRWho
         R8KZn9scDi9jtfypyaHBVIyGzr9W4iOsnPauUOl6I1mXFdVNxeDRLDpbTrteHhfKsVED
         4Y513s5ESJurZdrQx4R+L5kZkfcdt0v4jkGvnvUJnJ/yDA6zW+9qAiAUeAg1n291Q/YW
         Ow1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rOJTrm7pvpXG8OPQj4tl03mE+3NVVMlvWgKC+FZ17/8=;
        b=XMgYXLpDLz0AXk26qjEpdcr7LwhVOEFZZrlLFBzLV9rNzd2vdHIw1Ez9iV4Hn0d3Qk
         Z+iTZbAMPWFmtVcHQZT10B5kEUFr+cx0AEiOQrUKmHoxdAU3aGq/29cVbaR3vw0Ylmkd
         WhmhN6xA8Ogk6sPUd5gnedFpat8hTnptGyiq4YPYeYptdP1ukSZD0YIPlBp2xBrfwvGy
         MaNoEhsJzM9rPHtdUzYAKyD6hWIQWT+upIpxTIgAM1AXORFxNP4EGAUoQK80UvHc/Q/u
         d37X4XnEw7gWUFdXA6g4KED48jm6siJgJ+gSUVXCDqdgRT2fTMdwS0cTpGanrygQ5A9f
         QtZg==
X-Gm-Message-State: AOAM531KL2q2cJsTJkWSoEZT/oCY6Vw3m5cUDbPBoQQ76I9kS6389leb
        C5ioa7KvgHzM3xTWP2aba2Yy1/lxtRafe3vkqaE4NHuR
X-Google-Smtp-Source: ABdhPJz0nfNKG5nJFF+5WtTcFKU/psjOZJm2FiH9ZRecRrN/c14Tto3gvgL90KNmW0abOVY8Zc4pSyyKfboFSGQU26k=
X-Received: by 2002:ab0:5b5d:: with SMTP id v29mr39626779uae.110.1638009254485;
 Sat, 27 Nov 2021 02:34:14 -0800 (PST)
MIME-Version: 1.0
References: <YZABtvQab/M2CCQd@msi.localdomain> <14b22c98-dc4c-fe3b-fa20-b3dd78afd5cc@opensource.wdc.com>
 <CAMJR_v6igrNZMzXpio27PpA6rQvo+efAVd2nM5GNg2+agQa9=A@mail.gmail.com>
 <b386bdc4-db27-3160-80ac-ecd9d8d69c9f@opensource.wdc.com> <CAMJR_v7Y+o7sFh+ViM-hmZ-AqfEujcTSOYNf8ospvPHuk++wcQ@mail.gmail.com>
 <8e55f354-0522-de56-2c1e-56557888602f@opensource.wdc.com>
In-Reply-To: <8e55f354-0522-de56-2c1e-56557888602f@opensource.wdc.com>
From:   Nikolay Kyx <knv418@gmail.com>
Date:   Sat, 27 Nov 2021 13:34:02 +0300
Message-ID: <CAMJR_v4_3npqoTkFYW+2OVDHjj4-9WK70xASK6C1Mqn=S5z2Wg@mail.gmail.com>
Subject: Re: PROBLEM: [drivers/ata] Read log page failed (boot error message)
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, Nov 16, 2021 at 2:44 AM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
> Latest kernel will not even print this warning since not having support for the
> IDENTIFY DEVICE log page with ATA-9 drives is expected. The patch fixing this
> will go to stable too.
While with 5.15.2 + patch there weren't errors from libata, with
vanilla 5.15.5 (in which patch 'libata: core: add missing
ata_identify_page_supported() calls'
was included) there are 2 other (new because it wasn't the case with
5.15.4) error messages:
sd 5:0:0:0: [sda] Asking for cache data failed
sd 5:0:0:0: [sda] Assuming drive cache: write through
With the old warning (twice):
ata6.00: ATA Identify Device Log not supported
To summarize errors:
pre-5.15 kernels: no errors from libata.
5.15 - 5.15.4 (twice): Read log page 0x08 failed, Emask 0x1
5.15.5: Asking for cache data failed; Assuming drive cache: write through
Same hardware, just upgraded kernel to 5.15.5.
I still think that my HDD doesn't deserve error messages in dmesg.
Errors from the storage subsystem can be scary for someone.
