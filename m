Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD226BA4D
	for <linux-ide@vger.kernel.org>; Mon, 19 Feb 2024 10:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708339033; cv=none; b=JpVxpCWSztbc2yN2s8/Izig4HSwVvdQgJERKyKsiROa0ofERGdZATjYWNkT+BvKW8MhmXGKwl84KRGJ3ozOUnGBz9zJVVy76jZh+pQVCq+IkvwLlp44DIiXUaco/GLkphIt/ZCsEJBU85YUF1R5csy63o0q6M/kSpNA0tigI4aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708339033; c=relaxed/simple;
	bh=KotdvC0JkA1/7MxB4fuFTqcv8WYS7ZBp7Fr6DVFDhqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfCw9jldv7M8V56ofoX2GINr2LPLVRXvtr5OhDzkoG51OD4cR+XlsvTAbo6FSXqXScsqnyBOI4Wt0JyajdedEDeIDzmC0PIl8C0YryryunnQos+uHgos5pMTN0k7fAXleHZt9aXL/bh7ivBj/aIc69+Ds4wmdYU5b4xhGlCtgaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3ckuHIx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3ckuHIx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12993C433C7;
	Mon, 19 Feb 2024 10:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708339033;
	bh=KotdvC0JkA1/7MxB4fuFTqcv8WYS7ZBp7Fr6DVFDhqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P3ckuHIxx1wBc8IcgXVyAs49MEnvjduZbuVMrNsrWNb3XzqdbpWAnAGFmohghFJet
	 QJp539FTNuHRQSmQe47/tG0fKLbUHGDEHEz1o2xtMfmGy/Q0oLa53u5EKG0bUABGPU
	 FkUbzHPLJ8H2hWuJPQRlmj+IE4f9V1FpyQNCHGy8WA9Pl9re1mQvC2GnbBbJEzs4PG
	 QqG2TkVqKMI0AbxcTM3ptXLUjGkyca2jCiphDbFSrcynydZzHJA4+eIvcM4HDRZEDZ
	 skW21pHKAT47ooiu0vCZ5LpAMvdBUWBM98N+thxNkLKP7R11SgYWYCZ53UfxpSg0lx
	 2mavj7b22tWFg==
Date: Mon, 19 Feb 2024 11:37:08 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: "Andrey Jr. Melnikov" <temnota.am@gmail.com>, linux-ide@vger.kernel.org
Subject: Re: [PATCH v2] ahci: asm1064: correct count of reported ports
Message-ID: <ZdMvVPY5/51aoxOa@x1-carbon>
References: <20240214165758.986896-1-cassel@kernel.org>
 <ZdMfn5bp19qd3vft@x1-carbon>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdMfn5bp19qd3vft@x1-carbon>

On Mon, Feb 19, 2024 at 10:30:07AM +0100, Niklas Cassel wrote:
> On Wed, Feb 14, 2024 at 05:57:57PM +0100, Niklas Cassel wrote:

(snip)

> While I agree with Andrey that we should change the quirks that use
> saved_port_map to instead use force_port_map (so that we don't have
> two different ways to apply port_map quirks), that clean up can be
> done on top of this fix.

s/force_port_map/mask_port_map/

(force_port_map was the third way of applying these quirks,
but it has been removed already.)


Kind regards,
Niklas
