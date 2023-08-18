Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670E4C7113E
	for <linux-ide@archiver.kernel.org>; Fri, 18 Aug 2023 09:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358873AbjHRJCy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 18 Aug 2023 05:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359012AbjHRJCU (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 18 Aug 2023 05:02:20 -0400
X-Greylist: delayed 1492 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Aug 2023 02:01:58 PDT
Received: from mail.leachkin.pl (mail.leachkin.pl [217.61.97.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7675B3C24
        for <linux-ide@vger.kernel.org>; Fri, 18 Aug 2023 02:01:58 -0700 (PDT)
Received: by mail.leachkin.pl (Postfix, from userid 1001)
        id 1FAB0848DB; Fri, 18 Aug 2023 09:16:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leachkin.pl; s=mail;
        t=1692346637; bh=elHzctRz/z3PfTIhGYJKd0TeBTmca98Y+JNgX4gfsPI=;
        h=Date:From:To:Subject:From;
        b=Oc5RnZwrME/68Nd5ZGOt7jv/fU2X2+l/iLEB9/0hlbSL/UqHqHEc+CCAW5dQihwOr
         Ye1utpvSeiVZD3GZnEM7C3YUAT5ps5xjdL3IzHeNGIsiOZ1hudWFiAdkRP5oDXr5bj
         HsTRkUt8PMvx7yQTZWZwzvpTxHIpV+TNGMvrcCaYGYzBq+eSqPpzFIoqrybIT7bOyl
         v4MqpYRjbEAtzKttrSAMlaQ+avUjLGj1Ak3pycxQdVxdoS4Pa1zc4C0fwoKIMpFvBI
         11taKItsfWu7JJvdni4ceAEb/37UHNHu3IhyhfKeEIgUtrOxpFkH2TzZ/3DNnaXyjz
         hN3OBPa7WybKw==
Received: by mail.leachkin.pl for <linux-ide@vger.kernel.org>; Fri, 18 Aug 2023 08:15:51 GMT
Message-ID: <20230818074501-0.1.4u.cusu.0.eeursk31el@leachkin.pl>
Date:   Fri, 18 Aug 2023 08:15:51 GMT
From:   "Jakub Lemczak" <jakub.lemczak@leachkin.pl>
To:     <linux-ide@vger.kernel.org>
Subject: =?UTF-8?Q?Pytanie_o_samoch=C3=B3d?=
X-Mailer: mail.leachkin.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Dzie=C5=84 dobry,

Czy interesuje Pa=C5=84stwa rozwi=C4=85zanie umo=C5=BCliwiaj=C4=85ce moni=
torowanie samochod=C3=B3w firmowych oraz optymalizacj=C4=99 koszt=C3=B3w =
ich utrzymania?=20


Pozdrawiam,
Jakub Lemczak
