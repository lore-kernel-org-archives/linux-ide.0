Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9394526AA6
	for <linux-ide@vger.kernel.org>; Tue,  8 Sep 2026 11:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788867433; cv=none; b=pzgBGmz6U5FVXybryhJsT+OeyEDiXuc5g1kIQHMCYYYWnLprfvEtfR+GuhTKMEAWsZlBtslwWVy+pArccqtSB73uMeZbwEpMaU+xTSVsqD3qwY4PU0zfMinuQts37QJe+18gsYk59UrRsLx82Vya1f58FBoKqyEwKoKxY1B076g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788867433; c=relaxed/simple;
	bh=DkR/qPyXvDywcICQDbO38ezLz1FWxDysOfeFaBdmvPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NEs6a5HtASJAEqmJZASByd8PqFq/9RZsLsB34L90oCKqZDUObuJTooa/LvkbDuFEkeKLrlCeDndEcv/nk2AueSSQjLXHyoqqO4p+ZFvB86SUzeO9ltRlce9G4xJ1s/dZltn/jwV51TrVk755CIHs8B2AQ62+spHnIpzg8L5jhVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FiVro/SJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FiVro/SJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5D71F00A3A;
	Tue,  8 Sep 2026 11:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788867424;
	bh=6gl8h9L5AnFP5z9lIJRtUy8TzewAka1O2qMp4WezJ+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FiVro/SJh8t3MgeiYWEVk5yxRT6gzCFVsFDSpsbfuYT3XJh3vC/1XH9+267p8Yqkc
	 dgC3BZsKAFhZYG5Nr/DMaR6EynJvDioJC8bXRS3A/GLwpEx912n3hV2hdhxpnBMXgJ
	 Yxmt+9k5e1kruE6nLniG2gSbhx5h2i7AKtaifQHL2XA82xdUb/yY6erebij7fQLSZT
	 XFLbHiHJ3Hp1b2Wmk/q0bn64Rrbmuwgea1CpJvWTHd8lY9mFIsTG9aPTxOfRgXEaJw
	 BM3pkqgB74+g3h9raa0YEOliaYLysotpXLdKID1d7cTIzZhq0K5qLbLpv5U6p/85yd
	 Loi/kGrVVp21Q==
From: Niklas Cassel <cassel@kernel.org>
To: dlemoal@kernel.org,
	linux-ide@vger.kernel.org,
	Li Jun <lijun01@kylinos.cn>
Cc: Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v5] ata: ahci_da850: switch to DEFINE_SIMPLE_DEV_PM_OPS
Date: Tue,  8 Sep 2026 13:36:53 +0200
Message-ID: <178886739269.2568643.10668122871048248753.b4-ty@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908094901.2527974-1-lijun01@kylinos.cn>
References: <20260908094901.2527974-1-lijun01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=482; i=cassel@kernel.org; h=from:subject:message-id; bh=DkR/qPyXvDywcICQDbO38ezLz1FWxDysOfeFaBdmvPw=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLLmfw6rmy3O8l395Yz42mkfrIs4rOs6r0SZxPr8O/TJZ H1owJz9HaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZgIWzDDf0flw11nXfdMMYxp qQ2XWOVSnnyg7GqUtJ2pwMV7R2uPKTP8M6pX+19z2Smkb99ZTfcV+xO71R78CZvr3jql6HLW0t/ +7AA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

On Tue, 08 Sep 2026 17:49:01 +0800, Li Jun wrote:
> Replace the deprecated SIMPLE_DEV_PM_OPS macro with the recommended
> DEFINE_SIMPLE_DEV_PM_OPS. Use pm_ptr(&ahci_da850_pm_ops) to complete
> the API migration and allow the structure to be correctly dropped
> when CONFIG_PM=n.
> 
> 

Applied to libata/linux.git (for-7.4), thanks!

[1/1] ata: ahci_da850: switch to DEFINE_SIMPLE_DEV_PM_OPS
      https://git.kernel.org/libata/linux/c/2ce5b29b

Kind regards,
Niklas
