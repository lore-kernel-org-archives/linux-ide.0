Return-Path: <SRS0=CgUK=UT=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB45EC43613
	for <linux-ide@archiver.kernel.org>; Thu, 20 Jun 2019 20:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B21A42082C
	for <linux-ide@archiver.kernel.org>; Thu, 20 Jun 2019 20:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giiFY++B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbfFTUrj (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 20 Jun 2019 16:47:39 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:39771 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFTUri (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 20 Jun 2019 16:47:38 -0400
Received: by mail-pg1-f175.google.com with SMTP id 196so2185268pgc.6;
        Thu, 20 Jun 2019 13:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N9BhP6AJGX4/ArJ/JFMbWVXhcLnmYVxtC1mz1SEKSR8=;
        b=giiFY++BbSROSuFBrkfw5O023FycScnvKKeHX2BSWLrGOUXLmNpUJ267vlvtc/YKrl
         RC9rAk0U41VqWubpzWZ6+8NaPl5EXl0vZlhZN+r1rJisKoSnmqWkOr/Y8CQ4dk0EiGez
         cP7elqWeIzp2wjC0hmqv9PoodSgUG8GV2HlkL2zmZJV7FAaya9KsTwC2fZ6EKXu2KyuV
         ZOfGE9k8byA7dGGt8hKYI40mdj9sXX8LjnI0RFBsDoz6om6GKK6wGulag9elT0iJUB9l
         KAz6Rm0G6UlJZmbdzUikrS5fYD7g6Y8z2779nLubwmP0EFBXjbPXsDhuAUg1rlcijbOQ
         UrQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N9BhP6AJGX4/ArJ/JFMbWVXhcLnmYVxtC1mz1SEKSR8=;
        b=iBLQ8r4f8tLMP0LekpHTwg0UrAGjkCoqdP4n9xTKH2LIaQTDRyBmXpB9Gvrosg/nI/
         1vpfqsUrEW0DaH4EPe5Z63gNSrOsWxUs4LW7x4q1JdHpIvOuXKrnrtoEldCyxxzkO4qE
         /XDI6eMdAVqngPYMOt2VNoss3wf4UOzH2HQi7gZHfFb/QLG7Q0hZ1QFB+07SQnSYIT9v
         3et7WeYxiDfvObIc92B6lsUGUtbVON9Innw5mADkLKReL+deScMFhNdGVonPovPLB+Rz
         ESgA9eEtDp7RJEpVaqm/cKonndgas2PRYWzQPzxfO0VK550NBO88PRFon9hj/b8egAJt
         bvrg==
X-Gm-Message-State: APjAAAUCtCOVH9RrToc1JVNlRuM4F/s8V6xvmAlh7i/I5MUMYgkaGcoh
        D45Z2TdmKNe4zUXlFL8HfEk=
X-Google-Smtp-Source: APXvYqzJo3f4Rzoh6HQ6dZRZg4pRZjakzp1GJN3BqfOShRm3ln7FG/gDpb0Webe0GETPPMjK4UbQAw==
X-Received: by 2002:a62:5253:: with SMTP id g80mr5385612pfb.179.1561063658395;
        Thu, 20 Jun 2019 13:47:38 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (122-58-182-39-adsl.sparkbb.co.nz. [122.58.182.39])
        by smtp.gmail.com with ESMTPSA id l21sm363295pff.40.2019.06.20.13.47.37
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 20 Jun 2019 13:47:37 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 8DD31360079; Fri, 21 Jun 2019 08:47:33 +1200 (NZST)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-m68k@vger.kernel.org, linux-ide@vger.kernel.org
Cc:     geert@linux-m68k.org, b.zolnierkie@samsung.com
Subject: [PATCH RFC 0/2] Convert Atari Falcon IDE driver to platform device
Date:   Fri, 21 Jun 2019 08:47:20 +1200
Message-Id: <1561063642-13900-1-git-send-email-schmitzmic@gmail.com>
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <CAMuHMdUcUqWWGNngNV3EpEq5wSsf5qTVeZvTB9gX1e26Jrq1xA@mail.gmail.com>
References: <CAMuHMdUcUqWWGNngNV3EpEq5wSsf5qTVeZvTB9gX1e26Jrq1xA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

As suggested by Geert, at least one of the drivers available for the Falcon
IDE interface should be converted to a platform device driver (to enable
module autoloading by the Debian installer).

Add platform device for Falcon IDE (patch 1), and rewrite the present
libata driver to make use of that device (patch 2).

Tested on ARAnyM with driver builtin.

Cheers,

	Michael

