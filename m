Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCC4C727A8
	for <linux-ide@archiver.kernel.org>; Fri, 25 Aug 2023 01:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238477AbjHYBN7 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 24 Aug 2023 21:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235445AbjHYBNn (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 24 Aug 2023 21:13:43 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5043319BB;
        Thu, 24 Aug 2023 18:13:41 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bc63ef9959so4115295ad.2;
        Thu, 24 Aug 2023 18:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692926021; x=1693530821;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4b9rnjSIKe3D8+lZFGAZDxvOJUAGOV5nVfLgKI+tMKY=;
        b=PU0BR7u0+Dm/+Mwgc12qO7TmvVEshnlxnSyhGfDMs/FblJtowxsMVptcJzvQz/+bAA
         w8Z57HxbjDJuR6TS4Fg5agakmS7cPpC/dgY6D2b8PNN1TpkxARMeWnqWPQW3QpFFgEDA
         4qZJmycWARkUUrvW/7sy8GuU/6OylFijuP7WS6jfNpcqg8ujn9Eiy5cUBk1+4DikA/K4
         Pz2TZ1pa8KneEHwJFEagmUUa7aCL7kGV5LxH4mcrX7moMF20n6N9w4cIIzPR5OFD82dp
         6g/CHtCHe2ZfiVrG1GQPTt2jHMbq0Jb6qyswKpqrXQnpSt+5Rz8ZatCGzf88EvFAewhO
         721g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692926021; x=1693530821;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4b9rnjSIKe3D8+lZFGAZDxvOJUAGOV5nVfLgKI+tMKY=;
        b=Sk7XqBDGhOWI0K1JX72B8U8IrJt98BRw1Wg3KPEYc/1HNV6lrLWC0zd0puuf8emvtE
         O4l4wWaBbVe72M+2YFPHupS0ZqdK2SWSRTE/jOONu1xM0VHlOBpsjhCmVNzsHCMmJ+q0
         WwgxDlPqJA91IlhXToL9QlNKnyOzT9fCzTvZomOXaC+lvei9aItZ8X+ps3f/gbTUMg5t
         tIN9wTnmY8Ogj/qdKFyRLQ2HOmBSypryAC1wLq3TNFTpsF5gsTCPBAg6vPA7snaI/ifN
         p/5CzeAi+IDx88m0exPxSUsGo8dKdCgAkTLohiWEHfbbb5Q1GqjQv84mmKxMWkNtN7fb
         BO4w==
X-Gm-Message-State: AOJu0YyYBpHIqsEZuolE/pxBP8ISowaZI7dEx72HgwLzdoHDe4qGugic
        pAyYnz8NBhuORJwnvh4ncls=
X-Google-Smtp-Source: AGHT+IEAHX/1btyja1FNwspLXRW/C9wbuNL5O8YKfBAJI3tgnOd46aTIraW4h4Y/2rKHGRutzJ0yJQ==
X-Received: by 2002:a17:902:e5d1:b0:1c0:cbaf:6930 with SMTP id u17-20020a170902e5d100b001c0cbaf6930mr2710121plf.54.1692926020812;
        Thu, 24 Aug 2023 18:13:40 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (125-236-136-221-fibre.sparkbb.co.nz. [125.236.136.221])
        by smtp.gmail.com with ESMTPSA id k1-20020a170902694100b001b8b45b177esm309524plt.274.2023.08.24.18.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 18:13:40 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 8C9E436032D; Fri, 25 Aug 2023 13:13:36 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     s.shtylyov@omp.ru, dlemoal@kernel.org, linux-ide@vger.kernel.org,
        linux-m68k@vger.kernel.org
Cc:     will@sowerbutts.com, rz@linux-m68k.org, geert@linux-m68k.org
Subject: [PATCH v5 0/2] Q40 IDE fixes
Date:   Fri, 25 Aug 2023 13:13:33 +1200
Message-Id: <20230825011335.25808-1-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Version 5 of the pata_falcon bugfix patch for Q40 support.

Review comments from Sergey, Damien and Geert have been addressed.

Cheers,

   Michael


