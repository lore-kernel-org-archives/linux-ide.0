Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42BF28C5DE
	for <linux-ide@vger.kernel.org>; Mon, 30 Jun 2025 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751294865; cv=none; b=NKhZQ6Qia1PnVJkT4khC3dNJRPmHDRsU4t5wpFMtbWQfDeg5K4O/YLdwA22Z3Gu4DABiDLSdSqqpHELJJ/Qf9i9i76HMLaoXKVfRL1zU5RXCPQCY96y0wwvwW/IZxGOwlZQPbhu0QL5MsNeNtww2xyXO2WiILA5KKpJeQKWiZfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751294865; c=relaxed/simple;
	bh=3J34NDruwYsCUmt2iWufFqVkEyWgCqIT7Fh1GiLBnNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvJIUh9r4LYIfRiYsNvnpLVfQmxwF/tY7+Pm5QqtsoIF4Eio5fpdxph2bKHyfbDRzkcDIFplW7oPzjD/2kdmpyyHyWz2WSin1tcjPaFjwzgtn1J7zILUnaEMX1ABkIMY2GfSW626hM5TTcRmE2SBroMIx5vNENl2AX4oEcRAgdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpKyuoCk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpKyuoCk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD85C4CEEF;
	Mon, 30 Jun 2025 14:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751294865;
	bh=3J34NDruwYsCUmt2iWufFqVkEyWgCqIT7Fh1GiLBnNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dpKyuoCk4hV1YkwRXdV3r9+vjWzXDsm7rFQ5lBRDHv+rwSgAphU9SoRWENdOF4l+7
	 rV0BU5sGqPQbanO0sQi/6wcYBsK4Tnkju1n9GdT7osm/cDCpy7vW6YQtjaBsSs9j3A
	 RAPUjUCZUxcFjQRT+8KZUhbi5zhTFbDexWxuFLQ8eS7ACp4kNw7bTH/WtZppj0jivG
	 iojCWNwX/pHIGeHneIrWrUvsRAgnlCtn9zyhc0FXPl4byeCBEmLaBiawOx4J5Sv2Te
	 qQBlayOD8Qa6/VxD9zlA5wrl5rprUinDEMa54qafy+RiYDrVh8460Fy+DUjNSChNWV
	 jjEAkUhE9eOwA==
Date: Mon, 30 Jun 2025 16:47:42 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: Re: [PATCH 03/10] ata: libata-core: Advertize device support for
 DIPM and HIPM features
Message-ID: <aGKjjtBJ_LBQnpwA@ryzen>
References: <20250630062637.258329-1-dlemoal@kernel.org>
 <20250630062637.258329-4-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630062637.258329-4-dlemoal@kernel.org>

On Mon, Jun 30, 2025 at 03:26:30PM +0900, Damien Le Moal wrote:
> Modify ata_dev_print_features() to advertize if a device supports the
> Device Initiated Power Management (DIPM) and Host Initiated Power
> Management (HIPM) features.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Niklas Cassel <cassel@kernel.org>
