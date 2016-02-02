From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 04/10] Documentation: dt-bindings: Add a new compatible
 for the Armada 3700
Date: Tue, 2 Feb 2016 15:20:15 -0600
Message-ID: <20160202212015.GA21364@rob-hp-laptop>
References: <1454436468-4241-1-git-send-email-gregory.clement@free-electrons.com>
 <1454436468-4241-5-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35274 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965606AbcBBVUU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Feb 2016 16:20:20 -0500
Content-Disposition: inline
In-Reply-To: <1454436468-4241-5-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, arm@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Tejun Heo <tj@kernel.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org

On Tue, Feb 02, 2016 at 07:07:42PM +0100, Gregory CLEMENT wrote:
> The AHCI interfaces used in the Armada 3700 has a few differences with
> the one used in the Armada 38x, so it deserves its own compatible string.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/ata/ahci-platform.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
