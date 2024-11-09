Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FFF14EC60;
	Sat,  9 Nov 2024 17:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731173549; cv=none; b=LAdkrdk5BnSRSZTKbM89F12e3Kc4v3F2yhfoAwEWeUOumOLOrfbjRBJ+DXjtCD1X4NDEuYKjS/vwcV4rGJZ13mI+XnVj6OeJx/D+YokdhaQT87A5LjNdulRiS4h9QQ3D7Ca2GddYHsr8oxcfkeU/rXQDLCr++ShpefwSqNkaJ24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731173549; c=relaxed/simple;
	bh=IzghMAwHf5em8i0l6+K+MjT4IQ93fHfwLQg+x7OBWH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESCLx7ZEwkGcDUL/sypjdQvwvzuPoJEA5uXdl/vOrl6DN2U0Why8GOcied1pNy7/rcRbrpOBbQlYseAT0No9quJSHQgy5AUCWPtg4i4bzF+5i3dMFFrC/MEnlW8OwCDxEJ6yBK2KD7Oo10HIAVbzLWLXF828OjcQhLHTRDuo4+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QcDGpvz+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QcDGpvz+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3qqF74BTATSBYtiXjLbk2uFtyKcHYUi+s3TepMTAwwE=; b=QcDGpvz+grwY1kL4djQ13QwxdX
	5TMc3GCCFKeT0gYO6Lcx+gUfdVNSjW7MkW1XyUqrbksrmEMEG0Gq08P6W09JWllkKuM5swdUqD/CQ
	DrRs4w/uXOq46A+yENwGJtRjV5xahetVV8dYB5rlAAJ2FGtHNCMC23jB3sZDHZG5smO4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t9pJs-00CioJ-9D; Sat, 09 Nov 2024 18:32:20 +0100
Date: Sat, 9 Nov 2024 18:32:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Frank Wunderlich <linux@fw-web.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Frank Wunderlich <frank-w@public-files.de>,
	Hans de Goede <hdegoede@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 2/3] arm64: dts: marvell: drop additional phy-names
 for sata
Message-ID: <0eda1d9d-3241-4c1c-a6d2-56746410bcdc@lunn.ch>
References: <20241109094623.37518-1-linux@fw-web.de>
 <20241109094623.37518-3-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241109094623.37518-3-linux@fw-web.de>

On Sat, Nov 09, 2024 at 10:46:20AM +0100, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Commit facbe7092f8a ("arm64: dts: marvell: Drop undocumented SATA phy names")
> drops some phy-names from devicetrees but misses some. Drop them too.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
