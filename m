Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CD4391E57
	for <linux-ide@vger.kernel.org>; Mon, 23 Mar 2026 10:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774263583; cv=none; b=pc2CpNsR5UDxMBqXo6ZYxil4b+PlV7YJeVlE4+VPtwbJl92YJXrPiXP61j4GenkCUu+aQGAdh028w79ZKMgYi4r6P7t5lYn93OS/BVjwLFPT1Q823NBt65fEgfLWLn8QzXycZpp82vpAlapMEyZ+L3O6PXpeKepegJMYY764W3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774263583; c=relaxed/simple;
	bh=LSEP8RtRa/R4pcbEnDRPnHTMihDmSwz5I1WskoxkCaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A5Bm/g/DUq7MxC+iM0MuYHR5lRDBKO/TVdFImsf0T/1ztBdcMhkqqdl1BnrtiMctTRK9HNuXF8oLncQUHecZWfvxbpGnCP8BaBnel098OMsL5eMVqmVjEljup4xR2vkTYywTn30i4UvHw/RDETQMJGaLlbqhL2/miKuOOQCS0pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IG7Xj6vz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IG7Xj6vz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03360C4CEF7;
	Mon, 23 Mar 2026 10:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774263582;
	bh=LSEP8RtRa/R4pcbEnDRPnHTMihDmSwz5I1WskoxkCaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IG7Xj6vz0tFwfusnNhFtfal04WGnBsza2PDp4Twvn/92V1ZWCBkDi2SYOjpTOCmFs
	 LhyR/SwWq8Qn3HTCA2ZWMWrEGy/qISujH9nxq8RIDVmWpKbTHjLdVJtOP5LIdc+KvQ
	 6YNViURQII3+KDHtC9mHBBceTwPvaSb1sLjQgGw8SNVSAo3VqgSZ9GgG6MIiP/rzwo
	 Ts5Yn72k+yn7euuHazw1B/dx2mh8KYTpLMwvIrV11uqldRew/tBCMDFn3ly1wpIb5O
	 UbwjqTLsvARd6+d4V6JlXvHW9y9BLOHW89w4brgMRELEamBaMNcJFmV4viuCmlla3U
	 9NJQZFdvFSWXQ==
Date: Mon, 23 Mar 2026 11:59:39 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] ata: libata-transport: remove redundant dynamic sysfs
 attributes
Message-ID: <acEdG2YzV7DQmutM@ryzen>
References: <44265829-58c8-41ad-b202-e5488892af26@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44265829-58c8-41ad-b202-e5488892af26@gmail.com>

On Fri, Mar 20, 2026 at 11:10:59PM +0100, Heiner Kallweit wrote:
> Use the static sysfs attributes directly, this allows to significantly
> simplify the code. See attribute_container_add_attrs() for why member
> grp can be used instead of attrs.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---

The sysfs attributes are still accessible from the file paths as defined in:
Documentation/ABI/testing/sysfs-ata

The sysfs attributes still have S_IRUGO file permissions.

Thus:
Tested-by: Niklas Cassel <cassel@kernel.org>
