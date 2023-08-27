Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B1FC83F11
	for <linux-ide@archiver.kernel.org>; Sun, 27 Aug 2023 04:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjH0EOP (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 27 Aug 2023 00:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjH0EN7 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 27 Aug 2023 00:13:59 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3C81AC;
        Sat, 26 Aug 2023 21:13:55 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-76d7b5e374fso142683385a.2;
        Sat, 26 Aug 2023 21:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693109634; x=1693714434;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qg02qKk+w2DzK/TtLkjAeK4hPNPaPX6Icpe7TDyMPc=;
        b=h4sT4jriRBnmZ5IrFsdJJqzB/DyCWijGa8xrudAc5udTvcyZ8HAZwT0/tP7psuI0yc
         1nKBSqpOUrwiI8B9yPxI2w3VPGQQCUJaQUcIjQ6Rve8JoBm3hLUJl/UTisFSAcemSbrj
         95xpSQfvnDy2IjkT30YEoHch+u9Sjn2s6ZQmYM/g7M0Sidx5+Vn1HA0+nK9q88+UQcGw
         VWQ4N0cn5Alke4FDGSdazDgMv0w+zIjyEbjkYk7BEEYoo1HEcfBlb1nKYJOo3hCHeAdB
         HwlNDGkoM3tefZKnkTFeKE6g2MfwTycKQfH88hDg+tekEp3XUI2NY7+IX4YjJedNAcbV
         bv7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693109634; x=1693714434;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1qg02qKk+w2DzK/TtLkjAeK4hPNPaPX6Icpe7TDyMPc=;
        b=XiAV5tLMmFbuR7mO1GCar1P3AZn87FUrIo+ix6KXzxqf+kCb6oAf1JCOpji9wB8b5e
         C6LmgO5TqHxXpUQ5NJrc5tm8hGxAlZDiXZF8GpBlRfBQPWeh9TI5IAp4mmiAJs5TPgyH
         EsCrPhwj9Z3uO4uANgaO4qHTNmJdV9vpZ5OcJ6UjclIFqN6486Yi8LQR15ItMBmyvmGv
         huKxV4XALAYmMv9T/1+oltKAGosgbMYKjwZxmoMYSiJQt9r/WxcGS6PtC+oQqpKNT1gD
         eEyL2mlQeXmXssamDYek/06tymxasSLDse4pylRNHF7vyCNSvMyRqHPU1BG/k+/qGqoK
         7B9Q==
X-Gm-Message-State: AOJu0YwhQkiAlswZKnuac65INA0xmwabWGNT1gKogmJ0/7mvDYxjYdN/
        xjQvrrAzSttRrfk0FizCDEc=
X-Google-Smtp-Source: AGHT+IEO7RuDNkR6rn67Qx/NGfUrwgGBEINJkFHcRfOd163njWvPBsjfXKZte+fWZaR1pEi5W0kPBw==
X-Received: by 2002:a05:620a:4415:b0:767:2bbc:fcc7 with SMTP id v21-20020a05620a441500b007672bbcfcc7mr27793278qkp.14.1693109634654;
        Sat, 26 Aug 2023 21:13:54 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (125-236-136-221-fibre.sparkbb.co.nz. [125.236.136.221])
        by smtp.gmail.com with ESMTPSA id u18-20020a63b552000000b005501b24b1c9sm4463328pgo.62.2023.08.26.21.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 21:13:54 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 5A1AB360439; Sun, 27 Aug 2023 16:13:50 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     s.shtylyov@omp.ru, dlemoal@kernel.org, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org
Cc:     will@sowerbutts.com, rz@linux-m68k.org, geert@linux-m68k.org
Subject: [PATCH v6 0/2] Q40 IDE fixes
Date:   Sun, 27 Aug 2023 16:13:46 +1200
Message-Id: <20230827041348.18887-1-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Version 6 of the pata_falcon bugfix patch for Q40 support,
addressing the latest comments by Geert and Damien.

No logic changes from v5 which was tested by William.

Cheers,

   Michael


