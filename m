From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] ata_piix.c ICH6M MAP typo.
Date: Thu, 28 Dec 2006 10:53:32 +0900
Message-ID: <4593239C.2050204@gmail.com>
References: <826a2b270612271514k12e87daag3ec84fc5f0fd8d0a@mail.gmail.com> <826a2b270612271519id1da2a0x671632e8079a02f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.242]:13263 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964832AbWL1Bxt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Dec 2006 20:53:49 -0500
Received: by an-out-0708.google.com with SMTP id b33so1282488ana
        for <linux-ide@vger.kernel.org>; Wed, 27 Dec 2006 17:53:48 -0800 (PST)
In-Reply-To: <826a2b270612271519id1da2a0x671632e8079a02f4@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pierre Tardy <tardyp@gmail.com>
Cc: linux-ide@vger.kernel.org

Pierre Tardy wrote:
> I assume, this patch is a typo correction. this still avoids me an
> error at boot:
> ata_piix 0000:00:1f.2: version 2.00
> ata_piix 0000:00:1f.2: MAP [ P0 P2 XX XX ]
> ata_piix 0000:00:1f.2: invalid MAP value 0

Please post with proper patch description and Signed-off-by: line.
Other than that,

Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
