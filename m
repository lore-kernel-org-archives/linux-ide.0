From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v14 7/8] ARM: berlin: add the AHCI node for the BG2Q
Date: Tue, 26 Aug 2014 15:40:42 +0200
Message-ID: <53FC8E5A.9030404@gmail.com>
References: <1406744041-1269-1-git-send-email-antoine.tenart@free-electrons.com> <1406744041-1269-8-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:52203 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755071AbaHZNks (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Aug 2014 09:40:48 -0400
In-Reply-To: <1406744041-1269-8-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?UTF-8?B?QW50b2luZSBUw6luYXJ0?= <antoine.tenart@free-electrons.com>, tj@kernel.org
Cc: alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 07/30/2014 08:14 PM, Antoine T=C3=A9nart wrote:
> The BG2Q has an AHCI SATA controller. Add the corresponding nodes
> (AHCI, PHY) into its device tree.
>
> Signed-off-by: Antoine T=C3=A9nart <antoine.tenart@free-electrons.com=
>
> ---
>   arch/arm/boot/dts/berlin2q.dtsi | 39 ++++++++++++++++++++++++++++++=
+++++++++
>   1 file changed, 39 insertions(+)

Applied to berlin/dt.

Thanks for the patience!

Sebastian


