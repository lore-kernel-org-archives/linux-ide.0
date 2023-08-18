Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64770C05052
	for <linux-ide@archiver.kernel.org>; Fri, 18 Aug 2023 07:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358107AbjHRHOn (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 18 Aug 2023 03:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358065AbjHRHON (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 18 Aug 2023 03:14:13 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF5D30DF;
        Fri, 18 Aug 2023 00:14:12 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-688779ffc0aso503346b3a.3;
        Fri, 18 Aug 2023 00:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692342852; x=1692947652;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpStSHx9PZSNge/AWnYCDh1uhkuNrlXQuCgOlPNyHUM=;
        b=iiENQsZi0eAS7MS9G4JoXygo1VsW5e0Q2k/HFUuEV/1mu+5DiL4S4wmFw7XCbpgVGh
         jIqWZfj/Zw0SFbOXbv4V/NoTM7Xz5kGbLmfCspvIpuU3K6V9sQAUmBlFFXuJ+RTUgqSS
         a0Qca00hMyDjhsOL7nyCZJcjxmDTsXCoRaC0eRIduS0Ws/G9NLFW4Ug4+Q4+sHPSf707
         IBxvbks8A68QLHyUYEdZAXxG7yZ4etAtAabd3Zmv7bmjW6IyQ9k6lVz0bufJCJWnwurd
         ecjITR5CGrSGo66AQq3fxbneuBTchUrs7Ooc09avdz3UwdrtQ3Vo+bGyUVVGaB7fc9Fp
         zXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692342852; x=1692947652;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wpStSHx9PZSNge/AWnYCDh1uhkuNrlXQuCgOlPNyHUM=;
        b=akKZ/wBzaD+sZKRTMLpJko8TF6ntiOWAnMHN8Zckk157F1Mmvhmw2yux1Qw4nqw7bH
         CuMFJwrVLRk7nSqYk+h9AX5y8kobtM/p5vp5hbJ1JV7D8+utjEXfXnPqKMk/YS/d1jbI
         7fkmOokPSG7SbTCv+LvfYM/k7Xv9Xe4pFSLN9ozn6IL34u0IxhO35Pu+H0KUQMXoVQ0t
         KJugp9Avpj/HpvG3CJCIIUbv1QGEzMQOVWt8fYuyGLuiz0v9meClGwaHHtKHzG9DTYIc
         gJOiKiWwJtPLWm7xNu9oMcGQO2lRhZqXYkWMqUGUQUZyr1e2v9datT8KyxSuM4JzhMKX
         P3lA==
X-Gm-Message-State: AOJu0Yx/2pdIKRED9oBZgbpotRFG1l/YNMIpproMaazVAq3zVvOFw3Ro
        XHtgPz1nT6N2/kojtH4HIuAvOO9lINE=
X-Google-Smtp-Source: AGHT+IGYP8rhLNHB9xguGu8v0BKjJCUPOUModC30EYImLfca+gLqz5OUOXIrI1y5qmfYOtFsdFDHRw==
X-Received: by 2002:a05:6a00:1acc:b0:661:4a00:1ea5 with SMTP id f12-20020a056a001acc00b006614a001ea5mr1865848pfv.20.1692342852059;
        Fri, 18 Aug 2023 00:14:12 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (122-62-141-252-fibre.sparkbb.co.nz. [122.62.141.252])
        by smtp.gmail.com with ESMTPSA id g10-20020a63be4a000000b0056368adf5e2sm710865pgo.87.2023.08.18.00.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 00:14:11 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 87321360334; Fri, 18 Aug 2023 19:14:07 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     dlemoal@kernel.org, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org
Cc:     will@sowerbutts.com, rz@linux-m68k.org, geert@linux-m68k.org
Subject: [PATCH v2 0/3] Q40 IDE fixes
Date:   Fri, 18 Aug 2023 19:14:02 +1200
Message-Id: <20230818071405.28581-1-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Version 2 of the Q40 bugfix series for pata_falcon.

Comments by Damien and Finn have been addressed.

Cheers,

   Michael

