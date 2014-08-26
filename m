From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v14 8/8] ARM: berlin: enable the eSATA interface on the
 BG2Q DMP
Date: Tue, 26 Aug 2014 15:40:58 +0200
Message-ID: <53FC8E6A.8020008@gmail.com>
References: <1406744041-1269-1-git-send-email-antoine.tenart@free-electrons.com> <1406744041-1269-9-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:63845 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755088AbaHZNlD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Aug 2014 09:41:03 -0400
In-Reply-To: <1406744041-1269-9-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?QW50b2luZSBUw6luYXJ0?= <antoine.tenart@free-electrons.com>, tj@kernel.org
Cc: alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 07/30/2014 08:14 PM, Antoine T=C3=A9nart wrote:
> The BG2Q has an AHCI SATA controller with an eSATA interface. Enable =
it.
> Only enable the first port, the BG2Q DMP does not support the second =
one.
>
> Signed-off-by: Antoine T=C3=A9nart <antoine.tenart@free-electrons.com=
>
> ---
>   arch/arm/boot/dts/berlin2q-marvell-dmp.dts | 8 ++++++++
>   1 file changed, 8 insertions(+)

Applied to berlin/dt.

Thanks for the patience!

Sebastian

