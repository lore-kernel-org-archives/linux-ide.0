From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/8] IBM Akebono: Add support to AHCI platform driver
Date: Fri, 22 Nov 2013 17:24:59 -0500
Message-ID: <CAOS58YOTq2BHcc9hNWup35OBRYcW=auGN-F1ECGMkC+nvk9tUw@mail.gmail.com>
References: <1385086057-10884-1-git-send-email-alistair@popple.id.au>
	<1385086116-10972-1-git-send-email-alistair@popple.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:38705 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755338Ab3KVWZA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Nov 2013 17:25:00 -0500
Received: by mail-pd0-f180.google.com with SMTP id q10so1829520pdj.11
        for <linux-ide@vger.kernel.org>; Fri, 22 Nov 2013 14:24:59 -0800 (PST)
In-Reply-To: <1385086116-10972-1-git-send-email-alistair@popple.id.au>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alistair Popple <alistair@popple.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org, linux-ide <linux-ide@vger.kernel.org>

Hello,

On Thu, Nov 21, 2013 at 9:08 PM, Alistair Popple <alistair@popple.id.au> wrote:
> The new IBM Akebono board has a PPC476GTR SoC with an AHCI compliant
> SATA controller. This patch adds a compatible property for the new SoC
> to the AHCI platform driver.
>
> Signed-off-by: Alistair Popple <alistair@popple.id.au>

Applied to libata/for-3.13-fixes w/ stable cc'd.

Thanks.

-- 
tejun
