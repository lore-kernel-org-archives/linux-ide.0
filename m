Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3E4C433F5
	for <linux-ide@archiver.kernel.org>; Sun, 20 Mar 2022 23:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbiCTXJ3 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Sun, 20 Mar 2022 19:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242265AbiCTXJ3 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 20 Mar 2022 19:09:29 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A742BEB
        for <linux-ide@vger.kernel.org>; Sun, 20 Mar 2022 16:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1647817681;
        bh=mkHiB95KRzWTu6TEkuV+t13X/4qCHu11JAw0gya0FgU=;
        h=X-UI-Sender-Class:Date:To:From:Subject;
        b=hujfMBXo2/DOs8dVv0swoKp6alDCOVv65udjWYijBG+785t5z9P0bMM+qdwiCfy8C
         /MKgEOASgw3nvRqk6WEJcftheTGmCTTBlaBgcbKcbtJM69TlwEwJ3bJFRE/WQhGMVV
         72tg7Ko6s3ENov0Fo8AZveCsCcQjKmyHAY0NqVPE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.200.19] ([109.43.178.122]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McpJq-1o4a7n0l7K-00Zti5 for
 <linux-ide@vger.kernel.org>; Mon, 21 Mar 2022 00:08:01 +0100
Message-ID: <572a1710-24d4-5047-24fe-f2097b7dfcdc@gmx.de>
Date:   Mon, 21 Mar 2022 00:08:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     linux-ide@vger.kernel.org
From:   Radisson <Radisson97@gmx.de>
Subject: AHCI Led management ?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:hfFLqkh42sY2txABZjOdoqLenmdnYvKfHA1zCmx+INJvAqksjOO
 SM79QJ1w5QKiJsPIeeI4aTBWwfwz5lDvp2xh9ww45jZJbHy/N6B3mPdMpZVLlWAbDR+nAyL
 4fBH/WK571Ey93FaHqS8zWePVZwhyWj+Xlk7M2IMaQ/Fwt9Ud15jS9PMu94LZtami9gP2Hd
 mO8r8K2edFK9BiOrRftvA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GuV00yttig4=:z+1oVYTtGHqJmyKt/g0hcm
 G8Cny91vCJpydyjPNmoNcImc+EWzldFT5MQB8xc01zJ6iUn90IXPdnwW90CKAAX0G/mWGF7Oz
 Yczw9gze56rn4bwuofXzPu03h/4xZBpqXkKre0Qd8Fgp2dbQ459SLphRflCAXB8V+i8whG7bu
 2T4AYIOhtjzWu7MKYc0VHTpRb2zPjb8ijeYh5J8hy3XfYwIabjRk4g+lgkODIO4AFIkoya+FV
 TQ/wk2WHQrmvm193Y1+wBKfKsG82lghHASZD9n9+tqKddKiqqKoZIxejhfPao5Ca+CRHcNw2k
 LSq/G48DptsWabsu4uLhnyVYhhJUg/Jqsb7l8vqpQHp8THgW7KPDf4bUINo8jZfLxGJCONpUE
 xVhguYstaDEnUZmGxal7/+zzg0vKhU5xg/tS9QvTUy9eDNY/o+yjpe3R32RoJE2jIICOzfEsS
 BWA4IrE7TA4a3pG6YFMQ82HgRCp66KQhyT0ndYLUlXiZCWKgDOG+PvQAZDxmIzeYrMF9mJPFW
 o1uaI85j5JVWkyX5Oa3EzgiKsg5x/r3owAqo5dGwK46kHOvuvDNC6dcEbsyLCgMc25gGc85Xk
 NuwwQJxSPSULl3kk73uMm/pVzxYoGkUKmSrZDlkTjOOppqMyTMhgjbEj4nx+3E9HzHL1iEQV7
 moTq2f4J+qFGhJgM+8DnY1b63bmXDsMEpuJxR6jcrWQjMCxLHHLKLi7F+BlvpkhxkWVt+Uwoc
 EXVh6+3yB86edF9VRf5G9iAq0tcpJLZ+LaU1NgO3Fp0ZYYRSE5K237QWJOKKZJ20ZkLcCe43G
 grCimFpXtzlhMTkoEgj1ExU6jF3nqWol6HwWtWJDJ7Ogd6LsGAbS/4F8nJUuruQSCWKLgD+pG
 xJkmQ6eD2kLPB90XTYIYxjzSLVnpLWt8aovwpxZ7FhaLqX2U/6wfVIvawKzwlcP2sjTYCNypa
 jTTKuYemrdjLD63TFHvg+Mdgmc+sztMMwGH/1DR5Q1WPYo2qN/938EAkuWCdsS1LxVw/mhsFD
 JSWkaeZr0r7CHPC+TizpeQcWsjBqaiK7XWM1mNvqY5ZpUlUfEowSQqp0XX6lKaQWSgIhJAiRj
 mkSdeYrU0qms3s=
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Hello List,
i was looking for a way to access a drive LED from user space
to make it blink.
If found some solutions (ledctl, sgio,..) but these do not support AHCI.
I found this patch:
https://lwn.net/Articles/256322/
so there is a cmd.
But i was unable to find a ioctl() or /sys/something that would allow
me to controll the leds. (did i miss something)

Interesstingly bsd seems to support this:
https://www.freebsd.org/cgi/man.cgi?ahci(4)
so it seems possible.
(I do not use bsd no idea if it works)

please reply directly, i am not member of this mailing list.


