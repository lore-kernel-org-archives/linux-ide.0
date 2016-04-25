From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 5/5] dt-bindings: ata: add compatible string for Armada
 8K to ahci-platform
Date: Mon, 25 Apr 2016 07:47:02 -0500
Message-ID: <20160425124702.GA1324@rob-hp-laptop>
References: <1461335561-18363-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1461335561-18363-6-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49954 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932231AbcDYMrI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 25 Apr 2016 08:47:08 -0400
Content-Disposition: inline
In-Reply-To: <1461335561-18363-6-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>, devicetree@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>, linux-ide@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Hanna Hawa <hannah@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>

On Fri, Apr 22, 2016 at 04:32:41PM +0200, Thomas Petazzoni wrote:
> In order to support the AHCI controller found in the Marvell Armada
> 7K/8K, a new compatible string is introduced in the Device Tree
> binding for AHCI platform controllers.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/ata/ahci-platform.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
