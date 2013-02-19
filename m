From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 1/4] libata: add R-Car SATA driver
Date: Tue, 19 Feb 2013 23:44:19 +0300
Message-ID: <5123E423.1020202@cogentembedded.com>
References: <CA+WQ+_1pZ6ASbjWdJdOdiszT1VWo5kmdnrS32iKGjbcBNu5S4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:58166 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933048Ab3BSTnx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Feb 2013 14:43:53 -0500
Received: by mail-la0-f43.google.com with SMTP id ek20so6997627lab.30
        for <linux-ide@vger.kernel.org>; Tue, 19 Feb 2013 11:43:50 -0800 (PST)
In-Reply-To: <CA+WQ+_1pZ6ASbjWdJdOdiszT1VWo5kmdnrS32iKGjbcBNu5S4A@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?ISO-8859-1?Q?Csaba_Hal=E1sz?= <csaba.halasz@gmail.com>
Cc: linux-ide@vger.kernel.org

Hello.

On 02/19/2013 09:49 PM, Csaba Hal=E1sz wrote:

> The "return IRQ_NONE;" in sata_rcar_interrupt bypasses the
> spin_unlock_irqrestore, that doesn't sound right.
>   =20

    You're right, thanks. The IRQ save/restore in the interrupt handler=
=20
also causes some doubts.

WBR, Sergei

