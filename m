From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 0/5] ata: add support for Marvell Armada 7K/8K AHCI
Date: Thu, 19 May 2016 10:19:54 +0200
Message-ID: <20160519101954.64c4291a@free-electrons.com>
References: <1461335561-18363-1-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:48915 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753570AbcESIT6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 May 2016 04:19:58 -0400
In-Reply-To: <1461335561-18363-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>
Cc: linux-ide@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Hanna Hawa <hannah@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>

Tejun,

On Fri, 22 Apr 2016 16:32:36 +0200, Thomas Petazzoni wrote:

> The following small series adds support for the Marvell Armada 7K/8K
> AHCI controller. This controller is a standard AHCI controller, so not
> much is needed, except that it uses a non-default port offset and
> length. Due to this, some preparatory patches are used to make it
> possible to override the default port offset/length used by the AHCI
> core.

I recently learned that the non-standard port base/length is considered
as an HW issue, and it will be fixed in upcoming revisions of the SoC.
We are not interested in supporting the previous revisions that have
this bug, so I'm withdrawing this patch series.

Sorry for the noise and time spent there, I was not aware of the fact
that this issue would be fixed in HW.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
