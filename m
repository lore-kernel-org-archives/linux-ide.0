From: Jisheng Zhang <jszhang@marvell.com>
Subject: Re: [PATCH 5/6] ARM: berlin: add the AHCI node for the BG2
Date: Wed, 23 Apr 2014 10:45:39 +0800
Message-ID: <20140423104539.37c9366f@xhacker>
References: <1398181105-19714-1-git-send-email-antoine.tenart@free-electrons.com>
	<1398181105-19714-6-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:21773 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755845AbaDWCrr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 22 Apr 2014 22:47:47 -0400
In-Reply-To: <1398181105-19714-6-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Antoine =?UTF-8?B?VMOpbmFydA==?= <antoine.tenart@free-electrons.com>
Cc: "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>, "tj@kernel.org" <tj@kernel.org>, "alexandre.belloni@free-electrons.com" <alexandre.belloni@free-electrons.com>, Jimmy Xu <zmxu@marvell.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Antoine

On Tue, 22 Apr 2014 08:38:24 -0700
Antoine T=C3=A9nart <antoine.tenart@free-electrons.com> wrote:

> The BG2 has an AHCI SATA controller. Add the corresponding node
> in its device tree.

The AHCI IP of BG2 is different with BG2Q, so the driver in the series =
of patch
doesn't work on BG2.

Thanks
