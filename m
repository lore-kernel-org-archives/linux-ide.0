Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF44C433EF
	for <linux-ide@archiver.kernel.org>; Tue,  5 Oct 2021 08:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E469E61130
	for <linux-ide@archiver.kernel.org>; Tue,  5 Oct 2021 08:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbhJEI3a (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 5 Oct 2021 04:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbhJEI3a (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 5 Oct 2021 04:29:30 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E1DC061745
        for <linux-ide@vger.kernel.org>; Tue,  5 Oct 2021 01:27:40 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id v18so74138614edc.11
        for <linux-ide@vger.kernel.org>; Tue, 05 Oct 2021 01:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:disposition-notification-to
         :user-agent:mime-version:content-transfer-encoding;
        bh=wqPZ4iDqZ7dqwFYDjv0YIzf6EtbVraCQ6xngUJ77e9Q=;
        b=I+owwhPnlomTGNGCNANPsRZJBCUZFe7/I7eMKkLW/HPqT5ztiHZR+H+XnjDrmResEX
         QxBRniznHQ5vwDKfMvfLr7gMkHFdS0nysd+/kTVp0R8iIK8UuRJfWmT1uKqapFcmQYDl
         PaG3ed0XHPZtP530+WFBgPU/hpjQpPH3amyUCNvSihmId+lmNmgBdn9cCpgl5n64EAKB
         w5YMyMYiXXuL1jgpZrPSGokY+z6JBGsEs4lgoWSu99SXBKeFtkxe6IvJmP44ysvnMJHS
         9QL0+n8C+JW/wUOdURB7iHB2H0O3kBUHSYVlplbNelDZYZGPwKxMQFqOv6hoI8NMI6cw
         BkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date
         :disposition-notification-to:user-agent:mime-version
         :content-transfer-encoding;
        bh=wqPZ4iDqZ7dqwFYDjv0YIzf6EtbVraCQ6xngUJ77e9Q=;
        b=rAgFtA5llsg+O3uQdKwyIyDnwucA7jv2XGztZhwQrC9Mr9cErRROpn2BFrBR2Mi6bj
         aFZuISmxKYnBG8WcjbsD/pqOM1E6uLqKxVttXx+bQBuDCTdt1LTaWR3FCA5jICk4vStM
         kL8G0V7snZYRbmNpWDoZcjhVwcbfUfasrLDMDdgN7eCBesK5/ggi2y7hmSSRO8b00OtA
         w1dqiP6i92g49/m7wQ9LIh5T/qIfWU9eXQaBeWStr8LokZ0ceTBuXMXk3XqIgze1z4NB
         pXrVgGSX3HcvAIomxAV7p7apl4bZY4sQ/DjmXc+BuS/AoEzMw/pIhoeXR6mr/W4JCnIO
         gjtw==
X-Gm-Message-State: AOAM530RH8oWSRNnvnsfqJHxNilEIuAeKh/LVjjq1dAygelV8r5f/rMY
        xUPZUM6RwuJMSCX4Pa7/BWFa+Fp2GDo=
X-Google-Smtp-Source: ABdhPJwJLrqDcsTQekcrxuCn17dsCkyJwDuj/pJHwlgNUEjp6jlW6vYEH7qUzoyxnHmJxuYXEIvx1Q==
X-Received: by 2002:a17:906:e011:: with SMTP id cu17mr19752260ejb.244.1633422457213;
        Tue, 05 Oct 2021 01:27:37 -0700 (PDT)
Received: from ipc5 (netacc-gpn-4-195-71.pool.telenor.hu. [84.224.195.71])
        by smtp.googlemail.com with ESMTPSA id z4sm1606027ejn.112.2021.10.05.01.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 01:27:36 -0700 (PDT)
Message-ID: <8f4b17c763cb2742c6699d54d7577834b411722b.camel@gmail.com>
Subject: Asmedia 0x0624 support in linux kernel - request - txt format
From:   =?ISO-8859-1?Q?Pongr=E1cz_Istv=E1n?= <pongracz.istvan@gmail.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-ide@vger.kernel.org
Date:   Tue, 05 Oct 2021 10:27:35 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Dear Tejun/All,

EDIT: sorry, the first email sent as html, now this is a clean txt
version of it. Sorry again.

----

I checked the ahci.c after I failed to use Asmedia sata card (pci:1b21-
0624-1b21-1060;01-01-85;detected;storage;pata_acpi;ASMedia Technology
Inc.;IDE interface;ASMedia Technology Inc.) in linux, using
kernel 5.11.0-37-lowlatency.

As I found no answer/solution on the net, as a final resort I write to
you about this card and try to ask you to look after this chip.

Technically this pci sata card is a 10 ports card, using (as I can see)
3 chips in cascade to get 2x5 sata ports.

Regarding to the recent Asmedia support, I found this: 
https://github.com/torvalds/linux/blob/master/drivers/ata/ahci.c#L588

	/* Asmedia */
	{ PCI_VDEVICE(ASMEDIA, 0x0601), board_ahci },	/* ASM1060 */
	{ PCI_VDEVICE(ASMEDIA, 0x0602), board_ahci },	/* ASM1060 */
	{ PCI_VDEVICE(ASMEDIA, 0x0611), board_ahci },	/* ASM1061 */
	{ PCI_VDEVICE(ASMEDIA, 0x0612), board_ahci },	/* ASM1062 */
	{ PCI_VDEVICE(ASMEDIA, 0x0621), board_ahci },   /* ASM1061R */
	{ PCI_VDEVICE(ASMEDIA, 0x0622), board_ahci },   /* ASM1062R */


So, unfortunately the 0624 is not there yet.

Thank you all for your time an efforts regarding the development!

Best regards,
Mr. István Pongrácz

