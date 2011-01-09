From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH v4 3/3] ahci_platforms: add support for CNS3xxx SoC
 devices
Date: Sun, 9 Jan 2011 06:02:23 +0300
Message-ID: <20110109030223.GB27507@oksana.dev.rtsoft.ru>
References: <1294537775-21714-1-git-send-email-mkl0301@gmail.com>
 <1294537775-21714-4-git-send-email-mkl0301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:64003 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012Ab1AIDC1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 8 Jan 2011 22:02:27 -0500
Received: by eye27 with SMTP id 27so8155857eye.19
        for <linux-ide@vger.kernel.org>; Sat, 08 Jan 2011 19:02:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1294537775-21714-4-git-send-email-mkl0301@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mkl0301@gmail.com
Cc: htejun@gmail.com, linux-arm-kernel@lists.infradead.org, jgarzik@pobox.com, linux-ide@vger.kernel.org

On Sun, Jan 09, 2011 at 09:49:35AM +0800, mkl0301@gmail.com wrote:
> From: Mac Lin <mkl0301@gmail.com>
> 
> CNS3xxx override the softreset function of ahci_platform ahci_softreset by
> cns3xxx_ahci_softreset, which would retry ahci_do_softreset again with pmp=0 if
> pmp=15 failed, for the controller has problem receiving D2H Reg FIS of the
> different PMP setting of the previous sent H2D Reg FIS.
[...]
> Signed-off-by: Mac Lin <mkl0301@gmail.com>

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

Thanks!

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
