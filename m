Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A47ECAAD4
	for <linux-ide@archiver.kernel.org>; Fri, 26 Aug 2022 12:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbiHZMBN (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 26 Aug 2022 08:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiHZMBK (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 26 Aug 2022 08:01:10 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614E61181D
        for <linux-ide@vger.kernel.org>; Fri, 26 Aug 2022 05:01:09 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id w28so1018891qtc.7
        for <linux-ide@vger.kernel.org>; Fri, 26 Aug 2022 05:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=3AsezBOsd3cCDoJFpgO+dIwXFEZlcEo7ddArgYWFprM=;
        b=cvf2M0YJbv6aYnrXLFiv3nYU4t9T5QiZmeS1mkHapgQ0qhEy0gFrvInrbLvP2eOeCb
         NgMXqaGBPqBBWVyobYXo3NrKQLvdtOsdQYl+Pfwyf+D2jYy3zwNeaKNoa2mCUBIFwmb+
         CMKauU4zs3JyDQf0rUiweA0SWYnnpK7mTVaJQ96l3+hQZfaG6vbOM6PAvV+1ahnOGpKa
         82ONXYxHKpxBCC6Jn5ARxm9XHl1bBUqw6by2hCrMMpDGLVAWdEWc1NJhPEfT1M/EDhs9
         iBI04+0ewWRxXTCtTh5zfv8kj8DE6iY6eDxuk9kUorKs0TQSVqr0r1S8c5vdPo3c0G4y
         h+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=3AsezBOsd3cCDoJFpgO+dIwXFEZlcEo7ddArgYWFprM=;
        b=R/WUT8tYvcNYZRORZ8zwatK5bs0+gxm4ZzVUXC1J+lmKX8CTZ582G3BblYftzNsW0B
         5e5AGZKUfm1akDHq1VSipiDdbMf6ia4eXGnfaIVIoJ+tCkc/VNYPzsLY5wLYsHtz5Xac
         A+dk61XpvmROGAJlxmQR54OowVW+1Z3dF1UXOKr3mu9XVbleiZSnZC/BTpRp4Fn64P+h
         UDhoWU9UiEZJf4z4V7dnS7YyjHky8ZVVhTpvX/hOpQBo/E83n30Uqebn7h6ga2n3ul5B
         JcTeK887NAaRJPn1skxPIlKYYiUJMtC45NA/ZKpJMcU4vYkO2q/gql1UvLrf1VR8mXpB
         Vl8Q==
X-Gm-Message-State: ACgBeo30fRiJEP2mXDZAwQTKJYz1X6zkHXxbbzXZRwbQ6JAyUNcLK0X+
        iY/z6SEr0xnNfeYNwf1UAldHTqBj9rKQrX7fiHE5xdFln+0=
X-Google-Smtp-Source: AA6agR4h3+U40n//rgmwaWMQ87rYna3q3lCKDr/8GdbofYWWDZnpogSzOnTyFm3f3rafHoLWXPNulcD/ef54hTc8JDc=
X-Received: by 2002:a05:622a:20e:b0:343:7345:36cc with SMTP id
 b14-20020a05622a020e00b00343734536ccmr7527200qtx.669.1661515267994; Fri, 26
 Aug 2022 05:01:07 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Peter_Fr=C3=B6hlich?= <peter.hans.froehlich@gmail.com>
Date:   Fri, 26 Aug 2022 14:00:57 +0200
Message-ID: <CAHXXO6Eio2LecHS3i7C7yeWOrGFdMA4HTDB=d7azS_67zw5cyg@mail.gmail.com>
Subject: libata-scsi: ata_to_sense_error handling status 0x40
To:     linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Apologies if this is the wrong place.

In commit 8ae720449fca4b1d0294c0a0204c0c45556a3e61 "libata: whitespace
fixes in ata_to_sense_error()" we find, among many actual whitespace
changes, another change that adds an entry for 0x40 to the stat_table.

I thought that 0x40 is bit 6 of the ATA status which means (I think)
"drive ready" and not, as we translate here, "unaligned write
command". I may be very much confused about this, but if so, please
tell me how.

(I've been tracking another, presumably unrelated, error and have the
impression that this "unaligned write" message has been leading me in
the wrong direction.)
