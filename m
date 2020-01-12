Return-Path: <SRS0=hzpW=3B=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF954C3F68F
	for <linux-ide@archiver.kernel.org>; Sun, 12 Jan 2020 14:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE002187F
	for <linux-ide@archiver.kernel.org>; Sun, 12 Jan 2020 14:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733030AbgALOpm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 12 Jan 2020 09:45:42 -0500
Received: from mail02.vodafone.es ([217.130.24.81]:8919 "EHLO
        mail02.vodafone.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733028AbgALOpm (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 12 Jan 2020 09:45:42 -0500
IronPort-SDR: 1AHBbMRRuBQNywmQ4FQN1fd0LZekkWG4vfKzX+UQfyLgj4YftrcseWiYYf5U/sSwui33wOdNiE
 nn2uavNnaj2w==
IronPort-PHdr: =?us-ascii?q?9a23=3AP2Dj4BLT7MVcjssm/dmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgeIvjxwZ3uMQTl6Ol3ixeRBMOHsqkC0bSG+P6wEUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCezbL9oMhm7rAbcusYXjIZhN6081g?=
 =?us-ascii?q?bHrnxUdupM2GhmP0iTnxHy5sex+J5s7SFdsO8/+sBDTKv3Yb02QaRXAzo6PW?=
 =?us-ascii?q?814tbrtQTYQguU+nQcSGQWnQFWDAXD8Rr3Q43+sir+tup6xSmaIcj7Rq06VD?=
 =?us-ascii?q?i+86tmTgLjhCEAOzAk7G7YkMlwjaJCrB+/oBx/2ZbUYIaPNPVkYqPSY8oWSn?=
 =?us-ascii?q?RHXspISyFBHp+8YJETAOoBI+lYqpfyp10SrRenGwasAvrjxDhPhn/ww6I70/?=
 =?us-ascii?q?0tHh/A3Ac9G94DvmjYoMnwOKoUTOu7zrTHzS/bYv1Y2Tn98pbGfBM8r/6DQb?=
 =?us-ascii?q?1+ftHcyVUtGgzZklmctZDpMy2T2+8Qs2ab9e1gVee3hmA9tQ5xviagxt0xgY?=
 =?us-ascii?q?bJgYIVzF/E/jh+zYYtO9K4VFB0YcSqEZtXsSGaOJB7QsM5Q25zpCk20KEJuZ?=
 =?us-ascii?q?m+fCQQyJQnxAfSZvqaeIaL+hLuTPidLSp6iX5/Zb6yiQq+/VK+xuDzTMW4zk?=
 =?us-ascii?q?tGoyhDn9LRrH4CzQbT5dKCSvZl+0eh3iuA2B7L5+FfJEA0ibLbK5k8wr4sjp?=
 =?us-ascii?q?YTsVrMHivxmEjuia+ZbEQk+uyy6+v5ZrXqupGRO5VqigH5L6shgMK/AeM+Mg?=
 =?us-ascii?q?cQRWSU5/+82KXi/U3/XrpKkuU7nrfEvJ3YP8gXu6C0DxNP3oo95BuzFSmq3M?=
 =?us-ascii?q?kakHUfKVJKYhOHj4znO1HUJ/D4CO+yg0yynzd32f/GJLPgApLLLnjMi7rhfa?=
 =?us-ascii?q?195FVAxwYp0d9f4JdUBqsBIPLwQkPxrsDXDgclMwyoxObqENF91oIYWWKSDa?=
 =?us-ascii?q?6VKaLSvkKW6e80PemMa5EauCznJ/gm+fHul3k5lkEZfaWz2psXcn+4TbxaJB?=
 =?us-ascii?q?CdYHzxkpIAHWoioAUzVqrphUeEXDoVYGy9DJgx/jUqNIXzNYrfS5rlv7uH02?=
 =?us-ascii?q?/vBoIPOTAaWgukHnLhdoHCUPAJPnG8OMhkxwQJSbW7A7Am0x7m4Bf317d9Me?=
 =?us-ascii?q?3S9QUYrpjoktNy4qvTlkdhpnRPE82B3jTUHClPlWQSSmpthPhy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HhAgBpMBteXdkYgtlNGBoBAQEBAQE?=
 =?us-ascii?q?BAQEDAQEBAREBAQECAgEBAQGBaAQBAQEBCwEBARgBAYEugU1SIBKNOYdkH4F?=
 =?us-ascii?q?KgXmLY4EAggqBFBWGBxQMgVsNAQEBAQEbGgIBAYRATgEXgTM1CA4CAw0BAQU?=
 =?us-ascii?q?BAQEBAQUEAQECAxoWBYV0QgEBBAcBgU0MHgEEAQEBAQMDAwEBDAGDXQcZDzk?=
 =?us-ascii?q?pIUwBDgEET4VPAQEznUMBhASJAA0NAoUdgkUECoEJgRojgTYBjDKBQT+BIyG?=
 =?us-ascii?q?CKwgBggGCfwESAWyCSIJZBI1CEiGBB4gpmBeCQQR2iUyMAoI3AQ+IAYQxAxC?=
 =?us-ascii?q?CRQ4BHG2IA4ROgX2jN1d0AYEecTMagiYagSBPGA2WSECBFhACT4RNgUmFJII?=
 =?us-ascii?q?yAQE?=
X-IPAS-Result: =?us-ascii?q?A2HhAgBpMBteXdkYgtlNGBoBAQEBAQEBAQEDAQEBAREBA?=
 =?us-ascii?q?QECAgEBAQGBaAQBAQEBCwEBARgBAYEugU1SIBKNOYdkH4FKgXmLY4EAggqBF?=
 =?us-ascii?q?BWGBxQMgVsNAQEBAQEbGgIBAYRATgEXgTM1CA4CAw0BAQUBAQEBAQUEAQECA?=
 =?us-ascii?q?xoWBYV0QgEBBAcBgU0MHgEEAQEBAQMDAwEBDAGDXQcZDzkpIUwBDgEET4VPA?=
 =?us-ascii?q?QEznUMBhASJAA0NAoUdgkUECoEJgRojgTYBjDKBQT+BIyGCKwgBggGCfwESA?=
 =?us-ascii?q?WyCSIJZBI1CEiGBB4gpmBeCQQR2iUyMAoI3AQ+IAYQxAxCCRQ4BHG2IA4ROg?=
 =?us-ascii?q?X2jN1d0AYEecTMagiYagSBPGA2WSECBFhACT4RNgUmFJIIyAQE?=
X-IronPort-AV: E=Sophos;i="5.69,425,1571695200"; 
   d="scan'208";a="323424708"
Received: from smtp.iservicesmail.com (HELO mailrel03.vodafone.es) ([217.130.24.217])
  by mail02.vodafone.es with ESMTP; 12 Jan 2020 15:45:39 +0100
Received: (qmail 27481 invoked from network); 12 Jan 2020 14:45:34 -0000
Received: from unknown (HELO 192.168.1.3) (quesosbelda@[217.217.179.17])
          (envelope-sender <peterwong@hsbc.com.hk>)
          by mailrel03.vodafone.es (qmail-ldap-1.03) with SMTP
          for <linux-ide@vger.kernel.org>; 12 Jan 2020 14:45:34 -0000
Date:   Sun, 12 Jan 2020 15:45:36 +0100 (CET)
From:   Peter Wong <peterwong@hsbc.com.hk>
Reply-To: Peter Wong <pw178483@gmail.com>
To:     linux-ide@vger.kernel.org
Message-ID: <1715051.558767.1578840337049.JavaMail.cash@217.130.24.55>
Subject: Investment opportunity
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Greetings,
Please read the attached investment proposal and reply for more details.
Are you interested in loan?
Sincerely: Peter Wong




----------------------------------------------------
This email was sent by the shareware version of Postman Professional.

