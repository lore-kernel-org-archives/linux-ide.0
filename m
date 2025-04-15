Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0202D27A12C
	for <linux-ide@vger.kernel.org>; Tue, 15 Apr 2025 07:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744702228; cv=none; b=gjIMUnxs77keAIOOfiOhQMEv5szFFlQNWozDaqb7vt56SKy8C/J06jpClRgKXwLT30Bj1LmSgw7F2qLKr6Cjzy8AgmnssWWazamhNstx/+511X26eRV2tl3j0Qg6/ogS2Ph/3szfJ0ZWDi0QUJwUheEozyTVbDrGsfkIoWUcYhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744702228; c=relaxed/simple;
	bh=yVl1NiUqTbQoYHcvuzzmI/0oYrhwjbaDWgeszLB9fm8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qtv37xK0GbB9Vj4cXUUwBaMj6JA5giBgAQ8JoG0GhjOd3uMczfQtxdo0gEuBHunNpzrxTrp5vfSC7jZrREXD7zDy60QI35jJVdI7RUUuoGBGm3LAvaJFDsVGrLtqImwo2WR98RrjT7rITRAZYkNo34S8ypFjFhs87YYC4g9vwkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xmc+v8zc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xmc+v8zc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8D0C4CEDD;
	Tue, 15 Apr 2025 07:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744702227;
	bh=yVl1NiUqTbQoYHcvuzzmI/0oYrhwjbaDWgeszLB9fm8=;
	h=From:To:Cc:Subject:Date:From;
	b=Xmc+v8zcdkxd3AxFj+07/l+9ufpfB9WTt2x/hS98EZlcoNhQIFSTLB1f6ASBz4F1m
	 MLogkMqMBvHMw/Zu9j0y1h+WeAn1YibHEAmIfdqBKNFwWgJo0g3FWlthJ8TR2sTq5g
	 dUSA/x+dwa6RySqk9wy6NaBuD63qiM/ns68q24MF+fDiZxUt5jXtYsOOn+ZhqCttB2
	 gOPg1HbsHif5bGuysX/oz5xzMhNqDePBxPfajfUl/VRVRy2CW4NeceYHWcuAJFw4Nq
	 ++Io7ZkEbAPFjsrLtfg9U3BkF6MNdUP+TdvomnbduMfO0dy+mABa1ltsp2sD14y3lB
	 KGvyTCKApTyUg==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org,
	Igor Pylypiv <ipylypiv@google.com>,
	Hannes Reinecke <hare@suse.de>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 0/3] Successful NCQ commands sense_valid cleanups/fixes
Date: Tue, 15 Apr 2025 09:30:14 +0200
Message-ID: <20250415073013.414987-5-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=597; i=cassel@kernel.org; h=from:subject; bh=yVl1NiUqTbQoYHcvuzzmI/0oYrhwjbaDWgeszLB9fm8=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNL/cbPy+Yt9NjppU3P52vI3xxinOFQlsjU5MTbOONor8 MpMVZqjo5SFQYyLQVZMkcX3h8v+4m73KccV79jAzGFlAhnCwMUpABPZzsPwV2KHSMzXw0vSlQQr BF3W922+cYgr5m7NtHT5CcZ5LpstHjEyNKamis7k67pQX5R4o31BU8u3vR9nsVpG1IjeChXW09R kBwA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Hello all,

Here comes some minor cleanups/fixes related to the sense_valid field in
the Successful NCQ commands log.


Kind regards,
Niklas


Changes since v1:
-Pick up tags.
-Added patch 3/3.
-Changed sense_valid to u32 (Igor).
-Clarified commit message in patch 2/3 (Hannes).


Niklas Cassel (3):
  ata: libata-sata: Save all fields from sense data descriptor
  ata: libata-sata: Simplify sense_valid fetching
  ata: libata-sata: Use BIT() macro

 drivers/ata/libata-sata.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

-- 
2.49.0

