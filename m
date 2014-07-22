From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] ahci: st: Make of_device_id array const
Date: Tue, 22 Jul 2014 15:53:47 +0100
Message-ID: <20140722145347.GA23210@lee--X1>
References: <1406038543-26545-1-git-send-email-kiran.padwal21@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:63063 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755276AbaGVOxx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 22 Jul 2014 10:53:53 -0400
Received: by mail-ig0-f178.google.com with SMTP id uq10so313813igb.11
        for <linux-ide@vger.kernel.org>; Tue, 22 Jul 2014 07:53:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1406038543-26545-1-git-send-email-kiran.padwal21@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kiran Padwal <kiran.padwal21@gmail.com>
Cc: tj@kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 22 Jul 2014, Kiran Padwal wrote:
> Make of_device_id array const, because all OF functions handle it as =
const.
>=20
> Signed-off-by: Kiran Padwal <kiran.padwal21@gmail.com>
> ---
>  drivers/ata/ahci_st.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
