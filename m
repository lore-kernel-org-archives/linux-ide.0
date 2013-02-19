From: =?ISO-8859-1?Q?Csaba_Hal=E1sz?= <csaba.halasz@gmail.com>
Subject: Re: [PATCH 1/4] libata: add R-Car SATA driver
Date: Tue, 19 Feb 2013 19:49:29 +0100
Message-ID: <CA+WQ+_1pZ6ASbjWdJdOdiszT1VWo5kmdnrS32iKGjbcBNu5S4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-vc0-f177.google.com ([209.85.220.177]:59692 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932809Ab3BSS5g (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Feb 2013 13:57:36 -0500
Received: by mail-vc0-f177.google.com with SMTP id m18so4480292vcm.22
        for <linux-ide@vger.kernel.org>; Tue, 19 Feb 2013 10:57:35 -0800 (PST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

The "return IRQ_NONE;" in sata_rcar_interrupt bypasses the
spin_unlock_irqrestore, that doesn't sound right.

-- 
Cheers,
Csaba Halasz
