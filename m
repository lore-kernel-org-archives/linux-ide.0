Received: from ns1.suksangroup.com (ns1.suksangroup.com [103.13.31.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5CE303CB0
	for <linux-ide@vger.kernel.org>; Tue, 14 Jul 2026 05:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.13.31.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784006459; cv=none; b=ijxPK+GghkkPUtxtWfroTEh3KlUm2qtGu4eeAWaWrPxmvUqZ8QXubeBWtXk7WTMkYNh9xZP1zZJ96+ZtkYZGjxdvEYm/MmfF1ov7LAzaDyXYpsS2OyK5MnwR/p/aUMdKWlDmaHOzA2qWRe0bNgRO4oXctsmxOnc1fB6LgWUNyQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784006459; c=relaxed/simple;
	bh=VcMeDOh/Mz9HmczkW5IB7jkl8va3R1iTHZTELnLYYgY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LkStRfrD/Qozbw54VDEE7evvjUE/DCN5mp8ZPs6RCZxnPNq3iGy4UbUuVLVtLFp7jjQoemjtNxgToiujKZFyoUYu0BnP+Pcznh/yD89r9Ca6IpsqzrlqW+ifsSY0K1DBrHsNvQQihTiCe3fwdZC3UUGeMUy7/XVBQN65WmnAnRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=inbox.org; spf=fail smtp.mailfrom=inbox.org; dkim=pass (2048-bit key) header.d=suksangroup.co.th header.i=@suksangroup.co.th header.b=sqpn+A7y; arc=none smtp.client-ip=103.13.31.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=inbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=inbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suksangroup.co.th header.i=@suksangroup.co.th header.b="sqpn+A7y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=suksangroup.co.th; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VcMeDOh/Mz9HmczkW5IB7jkl8va3R1iTHZTELnLYYgY=; b=sqpn+A7yeDJY8mpZD7VyhQDkjY
	u9LCrqHmuWYnGiB+OKeIj8dGc9ZbBrcNFSOJId8un9HLbAIGdXT6ASk17pbBcsuxRUaD3Ue8cN2Yi
	q+b8srl64Gw33i/vwJaBZNpd0WqeQ5vXE4xprkkQwfZqNCkDc6rvCfbl80AKX1MJherefEOK+4cOy
	Eb11BXMG4YrpJ5zL2+4zKgfzkRWhLaEjS9iwO0cqhzi0mJnir+50ye2lIvGkzh0ktVpT8hZqeT2W1
	naG1hgor5MB96OMhCOVZKUXrqul4iW2m9Ffk/dJkocWZrsqogm2ziZvl5LRgjVY+HSahIyhRfNRrE
	nF3nSuVA==;
Received: from [207.189.26.187] (port=62259)
	by ns1.suksangroup.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <info@inbox.org>)
	id 1wjVZg-0000000Fuaa-23fy
	for linux-ide@vger.kernel.org;
	Tue, 14 Jul 2026 12:20:55 +0700
Reply-To: hanns.schofield@lexcapitalgrowth.com
From: Harry Schofield ESQ <info@inbox.org>
To: linux-ide@vger.kernel.org
Subject: Dear linux-ide@vger.kernel.org, project stage
Date: 14 Jul 2026 00:20:52 -0500
Message-ID: <20260714002052.D5190CDB2323D6F5@inbox.org>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns1.suksangroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - inbox.org
X-Get-Message-Sender-Via: ns1.suksangroup.com: authenticated_id: smtp@suksangroup.co.th
X-Authenticated-Sender: ns1.suksangroup.com: smtp@suksangroup.co.th
X-Source: 
X-Source-Args: 
X-Source-Dir: 


Re:Good day linux-ide,

Please let me know if this is best email to send you the project=20
info.

Kind regards,

Harry Schofield, ceMBA


