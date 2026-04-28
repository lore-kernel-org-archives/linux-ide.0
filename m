Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B859261B70;
	Tue, 28 Apr 2026 07:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360111; cv=none; b=POq7/b91BqgMLw2J3bMFwEtxvSx+M6zShusC9r+xAqAlQiIK1XGyRJPFWGwrKEmgD9428s3ODPSxNhtgl7ixuSuyhLwJbn6yWS8GqBTp5aHJhKiwc2jrkoJ63bF2ml1Tv+dTItD6hq7EhnMJefTB9xwYohNbMXnzjOaGNtQHoFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360111; c=relaxed/simple;
	bh=AQjPUcIzNpSZyztCSPKpLqd6toajevEvMaRkLw61jT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J9rBj+3UCl4uFAD6BypPIcR8dYxITnfpwOFOKNQ4nUqZsR4iVJp3L5c72DL2WPe1ptOnilS/5PJ7iMOScq6HOuiwF/G//L6Usx6jF1eZ5xKCjfqDW6bhNXZVJQCsh/ejicqIjxHQwmHgwRu9DmN2untDRgcoWjJ/d389+6cRvh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sp6SmTjt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sp6SmTjt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CF7C2BCAF;
	Tue, 28 Apr 2026 07:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777360111;
	bh=AQjPUcIzNpSZyztCSPKpLqd6toajevEvMaRkLw61jT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sp6SmTjtYdLeZCszt4ZXtII+cEV0ITZuL7vnSqE2+ubAJ04QJPzkHU+U2qerrtzO6
	 ldMAA6ZdR40Odqf64ftBNM7CKA72o7DMsLOFUsNAYHyPXbuiW0KbYTxRXF4DtX8Med
	 xQ00oN+4ka95O0nlJeDVFAGcREw41Wn1wW8Z8iK7YbIFq0PHxC0Tlv31Md80PBHMMn
	 aZ0guZA1FtJhrDZ973BXHjiUiQ9l7hiGENimxwccSo+c0mctZVfWveH3jeo5MyAJeH
	 rww0VSB1M2yNuAraA/X7M2yjn2Q09KFYrpZiM4eRzcK4Rbq1XI6AGHUcv/UKm3nwmS
	 cFHWJZT/tkwmg==
From: Niklas Cassel <cassel@kernel.org>
To: linux-ide@vger.kernel.org,
	dayou5941@163.com,
	linux-kernel@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>,
	dlemoal@kernel.org,
	liyouhong@kylinos.cn
Subject: Re: [PATCH v5] ata: ahci: fail probe if BAR too small for claimed ports
Date: Tue, 28 Apr 2026 09:08:20 +0200
Message-ID: <177735961706.2183577.4033506737290437474.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428020935.2049617-1-dayou5941@163.com>
References: <20260428020935.2049617-1-dayou5941@163.com>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1160; i=cassel@kernel.org; h=from:subject:message-id; bh=AQjPUcIzNpSZyztCSPKpLqd6toajevEvMaRkLw61jT4=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDI/xDzeO1MzMjhisj3zn/qHLwxcjq/U8t3fLTPZyyvgc 9xbdVuVjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAExkjwQjwy5WRf7Na0KTRBlc WH9u5l1a8Xgxs3N9u+Y8+Um73xQ3ejAyTLz1VvCcjYR6TbO0aHTZ5fUrU8qS43LzJbss6qtf1Dd yAwA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

On Tue, 28 Apr 2026 10:09:35 +0800, dayou5941@163.com wrote:
> When an AHCI controller is disabled in BIOS, its HOST_CAP register may
> contain invalid values (e.g., 0xFFFFFFFF) indicating an impossibly large
> number of ports.

Indicating an impossibly large number of ports is simply not correct.

The CAP.NP field is a zeroes based 5-bit register field, so it can represent
values in the range 1-32.

Values in the range 1-32 is not impossibly large, it it simply the possible
number of ports defined by the standard.


> If CAP.NP claims more ports than can physically fit
> within the mapped BAR region, accessing port registers beyond the BAR
> boundary causes a kernel panic.
> 
> Add validation in ahci_init_one() to check that the BAR size is
> sufficient for the number of ports claimed in CAP.NP. The check
> calculates the required MMIO size as:
> 
> [...]

Applied to libata/linux.git (for-7.2), thanks!

I rephrased the "impossible number of ports" sentence while applying.

[1/1] ata: ahci: fail probe if BAR too small for claimed ports
      https://git.kernel.org/libata/linux/c/eb9c9a3a

Kind regards,
Niklas
