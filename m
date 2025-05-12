Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E1A3D76;
	Mon, 12 May 2025 23:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747091728; cv=none; b=iCdgY+m8W5fbkZO1wDMpbt59jAuqfDdDon7mMvppduDRvLM9b5vQPsc9pzH0hwPAs4dsn1NnUuwpP1BPIHEoX4Niw8sGGXkMxA3SxwqM9HBFDS7GhJVE4VPDHJ+nHzajXcDnP/XftBTpKgqRThs8J9dwkLpujNJ+q3N62lQrsDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747091728; c=relaxed/simple;
	bh=3ENOP1N0MOsWBL67E31k5g9380JJsDj/TFtarKQDIdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/1mIIOwhcgCRcQHfi1fuY22dOl01k/+OJ6h3nKIiAdkCh9rRXwu36wQ+5UaB6i8esyhachZHPiDaSP6wae0cM1O7BtxMMKyFOT76+xNzu1s3XXQu1TKRZIHe2sOj2nFmQ9k8mvwCikjwZhHcbmqKchCdPnxw0F+bISSbtPvDTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GS5vjynT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GS5vjynT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=i95nx22mrAS5Fcg9BWfFqljdB7CX6Kw5WtqL/xqdDGE=; b=GS5vjynTSClTRVn/0ujjI32U8n
	/ssKyrC4D6tk0k9xGPSzs71gEd8LMhBNzikuFB/F5cxCXqhlAHprUfhL4iW8ZP8D6lwRRI2mdmyAe
	5EO9qQvQ4lPDmG+cN9xLcrWt9kZLblanmASW3fkFxz85tGMchTrm1IsmXthlrWoe1BHA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uEcMk-00COQZ-NM; Tue, 13 May 2025 01:15:22 +0200
Date: Tue, 13 May 2025 01:15:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Gregory Clement <gregory.clement@bootlin.com>,
	linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: ata: Convert marvell,orion-sata to DT schema
Message-ID: <d6bfa9fb-739c-413a-a6ff-78b06ec620b6@lunn.ch>
References: <20250512215750.4179075-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512215750.4179075-1-robh@kernel.org>

On Mon, May 12, 2025 at 04:57:48PM -0500, Rob Herring (Arm) wrote:
> Convert the Marvell Orion SATA Controller to DT schema format.
> 
> The clocks and clock-names properties were missing. The names for
> phy-names were incorrect. The maximum "nr-ports" was determined from the
> Linux driver.

Hi Rob

All the SoCs using this IP have either 1 or 2 ports. There was a PCI
card using the same IP which had more ports, but that obviously does
not use the binding.

So if you want you could reduce down all the lists to two items.

	Andrew
