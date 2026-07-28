Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7073AFCF2
	for <linux-ide@vger.kernel.org>; Tue, 28 Jul 2026 11:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785237196; cv=none; b=MPDPiHlGqkEMMINPj4yBFBVnai0HA3Zvr/mhjoTI3by1IffQFZbOo0wtKV2tSw87saYoUXKDmH2/5+4VJ78dC4u0bIea4m4wRUn26siJQfA97u7z9tB2CHNO9PyogBRXa3LcXGqCkS0K8UhBGJtmmYFpCnh2qcCR8n8DYFwnSp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785237196; c=relaxed/simple;
	bh=VXGQdfTLzDdpKpWukPfOjWZlTawbFblrCXGw5GLA68Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N3WI1/vQkD9EYuvGIDC3LXsRl8Xg+aOYvH1WcdS0gpQCv5lsToLoKc4JodHBkpma8Ng5T0/GpZaRbnU0qrbTKA1Hg/vWa5PGNVR3qBv5u/D3TEYstKDdZtVHv06/blTjfkZky1UBxt9t4oojcd4SvJYEdj2c+VyHauhGNZsgChE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsgMUhMi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsgMUhMi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7745F1F000E9;
	Tue, 28 Jul 2026 11:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785237195;
	bh=6nU2pF6NVeg6B5lnmg+uE0UTe/FSV+oDeEksgFSAwpU=;
	h=From:To:Cc:Subject:Date;
	b=FsgMUhMifrw+XNL7ExB4OdmYZPKq6PPenYeGNyWTy+wfOPr/INR4GUX/146bK4IAo
	 bsfx2oOvR1fGI9UJuD4KfATsODYaC84zl/bRcCeuWaAEnqszTt82PmIP11AERUAz1W
	 /Ko1Pr+MVgrbABg8JZhuB+ZX4KGdoRlJSF4fvwcxObFoWXMal4sXKI902i+g9fh7iT
	 cEWJoc2hZThWMotUR7qOQC9Zu+WPyPfMQD1jxcwPnvk7LjaNVWRcIp06ezcTGdcUAZ
	 mdN88759xM+5JeJ5RpcBzNUy+5aQNfFsZ/rvCebZHZzz0fdrpP7kpdBSst61opcymW
	 YsOs824cnBlew==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Cc: Ronald Garcia Vazquez <ronaldgarciavazquez@gmail.com>,
	linux-ide@vger.kernel.org
Subject: [PATCH 0/2] ata: disable LPM on some WDC drives
Date: Tue, 28 Jul 2026 13:13:10 +0200
Message-ID: <20260728111310.722450-4-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=360; i=cassel@kernel.org; h=from:subject; bh=VXGQdfTLzDdpKpWukPfOjWZlTawbFblrCXGw5GLA68Q=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLIy+o590ujUKss7sJ+5naf/6SXxSwd8dSKdYl17mLufV hufMd3VUcrCIMbFICumyOL7w2V/cbf7lOOKd2xg5rAygQxh4OIUgIm4TmNkWODCvUbucFPY9mmO SVHCNW7WTce/bep8JMI7eTP71SPXDRgZjiyUrpzL+WIiX3Rsz5XvhVsvtp7eHfPePzOgk2nybpb 3vAA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Hello there,

This disables LPM on some WDC drives, which, according to user reports,
have issues with LPM.

Kind regards,
Niklas


Niklas Cassel (2):
  ata: libata-core: Disable LPM on some WD drives
  ata: libata-core: Disable LPM on WD Green 2.5 480GB

 drivers/ata/libata-core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

-- 
2.55.0

